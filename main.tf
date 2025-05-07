
module "github-identity-federation" {
  source                   = "./modules/github-identity-federation"
  project-id               = var.landing_project_id
  federated-github-users   = var.federated_github_users
  landing-identity-pool-id = var.landing_identity_pool_id
  identity-provider-id     = var.landing_identity_provider_id
}

module "mlops" {
  source     = "./modules/vertex-ai"
  region     = var.gcp_region
  project-id = var.landing_project_id
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
