
module "github-identity-federation" {
  source = "./modules/github-identity-federation"
  project-id = var.landing_project_id
  federated-github-users = var.federated_github_users
  landing-identity-pool-id = var.landing_identity_pool_id
  identity-provider-id = var.landing_identity_provider_id
}

resource "google_project_iam_member" "github-actions-artifacts-binding" {
  depends_on = [
    module.github-identity-federation
  ]
  project = var.landing_project_id
  role = "roles/storage.objectCreator"
  member = "serviceAccount:${module.github-identity-federation.federated-github-users["public-artifacts"].federated-user.email}"
  condition {
    title       = "Artifact Loading"
    description = "Allow the creation of public artifacts"
    expression  = "resource.name.startsWith(\"//storage.googleapis.com/landing-artifacts\") &&\nresource.service == \"storage.googleapis.com\""
  }
}