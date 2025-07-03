locals {
  common_labels = {
    env   = "public"
    owner = "github-oidc"
    repo  = "terraform-infrastructure"
  }
}

resource "google_project_service" "enable_apis" {
  for_each = toset([
    "run.googleapis.com",
    "artifactregistry.googleapis.com",
    "iamcredentials.googleapis.com",
    "cloudbuild.googleapis.com",
    "logging.googleapis.com",
    "compute.googleapis.com"
  ])
  project = var.landing_project_id
  service = each.key
}

module "github-identity-federation" {
  source                   = "./modules/github-identity-federation"
  project-id               = var.landing_project_id
  federated-github-users   = merge(
    var.legacy_federated_github_users,
    {
      for key, user in var.federated_github_users : key => {
        name                 = module.federated_users.service_account_ids[key]
        display_name         = user.display_name
        description          = user.description
        allowed-repositories = user.allowed-repositories
      }
    }
  )
  landing-identity-pool-id = var.landing_identity_pool_id
  identity-provider-id     = var.landing_identity_provider_id
  depends_on               = [module.federated_users]
}

module "mlops" {
  source     = "./modules/vertex-ai"
  region     = var.gcp_region
  project-id = var.landing_project_id
}

# Federated users using named_sa module (only for users with named_sa config)
module "federated_users" {
  source = "./modules/named_sa"
  service_accounts = {
    for key, user in var.federated_github_users : key => {
      domain            = user.domain
      component         = user.component
      purpose           = user.purpose
      env               = user.env
      description       = user.description
      sa_type           = user.sa_type
      add_suffix_by_this_module = user.add_suffix_by_this_module
    } if user.domain != null
  }
}



resource "google_project_iam_member" "github-actions-artifacts-binding" {
  depends_on = [
    module.github-identity-federation
  ]
  project = var.landing_project_id
  role    = "roles/storage.objectCreator"
  member  = "serviceAccount:${module.github-identity-federation.federated-github-users["public-artifacts"].federated-user.email}"
  condition {
    title       = "Artifact Loading"
    description = "Allow the creation of public artifacts"
    expression  = "resource.name.startsWith(\"//storage.googleapis.com/landing-artifacts\") &&\nresource.service == \"storage.googleapis.com\""
  }
}

resource "google_artifact_registry_repository" "brainwave" {
  project       = var.landing_project_id
  location      = var.gcp_region
  repository_id = "brainwave"
  format        = "DOCKER"
  description   = "Central Artifact Registry for AI backend containers"
  mode          = "STANDARD_REPOSITORY"
}

resource "google_artifact_registry_repository_iam_member" "brainwave-writer-deploy-ai-api" {
  depends_on = [
    module.github-identity-federation,
    google_artifact_registry_repository.brainwave
  ]
  project    = var.landing_project_id
  location   = google_artifact_registry_repository.brainwave.location
  repository = google_artifact_registry_repository.brainwave.name
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${module.github-identity-federation.federated-github-users["deploy-ai-api"].federated-user.email}"
}

resource "google_project_iam_member" "cloudrun-developer-deploy-ai-api" {
  depends_on = [module.github-identity-federation]
  project    = var.landing_project_id
  role       = "roles/run.admin"
  member     = "serviceAccount:${module.github-identity-federation.federated-github-users["deploy-ai-api"].federated-user.email}"
}

resource "google_pubsub_topic" "billing_alerts" {
  name    = "billing-alerts"
  project = var.landing_project_id
}

resource "google_billing_budget" "dev_budget" {
  billing_account = var.billing_account_id
  display_name    = "budget-alert-dev"

  budget_filter {
    projects = ["projects/${var.landing_project_id}"]
  }

  amount {
    specified_amount {
      currency_code = "USD"
      units         = 20
    }
  }

  threshold_rules {
    threshold_percent = 0.5
  }

  threshold_rules {
    threshold_percent = 1.0
  }

  all_updates_rule {
    pubsub_topic   = "projects/${var.landing_project_id}/topics/${google_pubsub_topic.billing_alerts.name}"
    schema_version = "1.0"
  }

  depends_on = [google_pubsub_topic.billing_alerts]
}
