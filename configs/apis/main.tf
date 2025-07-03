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