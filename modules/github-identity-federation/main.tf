resource "google_iam_workload_identity_pool" "identity-pool" {
  disabled                  = false
  project                   = var.project-id
  workload_identity_pool_id = "github-${var.landing-identity-pool-id}"
  display_name              = "Github Automation Pool"
  description               = "Identity pool for Github Automation"
}

resource "google_iam_workload_identity_pool_provider" "identity-pool-provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.identity-pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-${var.identity-provider-id}"
  display_name                       = "Github provider"
  description = "Identity pool provider for Github"

  attribute_mapping = {
    "attribute.repository" = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
    "attribute.actor" = "assertion.actor"
    "attribute.aud"   = "assertion.aud"
    "google.subject"  = "assertion.sub"
  }

  oidc {
    allowed_audiences = []
    issuer_uri        = "https://token.actions.githubusercontent.com"
  }
}

module "federated-github-user" {
  source = "./federated-github-user"
  for_each = var.federated-github-users
  project-id = var.project-id
  name = each.value.name
  display_name = each.value.display_name
  description = each.value.description
  identity-pool-name = google_iam_workload_identity_pool.identity-pool.name
  allowed-repositories = each.value.allowed-repositories
}