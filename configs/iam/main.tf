resource "google_project_iam_member" "github-actions-artifacts-binding" {
  project = var.landing_project_id
  role    = "roles/storage.objectCreator"
  member  = "serviceAccount:${var.github_identity_federation_output.federated-github-users["public-artifacts"].federated-user.email}"
  condition {
    title       = "Artifact Loading"
    description = "Allow the creation of public artifacts"
    expression  = "resource.name.startsWith(\"//storage.googleapis.com/landing-artifacts\") &&\nresource.service == \"storage.googleapis.com\""
  }
}

resource "google_project_iam_member" "cloudrun-developer-deploy-ai-api" {
  project    = var.landing_project_id
  role       = "roles/run.admin"
  member     = "serviceAccount:${var.github_identity_federation_output.federated-github-users["deploy-ai-api"].federated-user.email}"
} 