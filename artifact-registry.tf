resource "google_artifact_registry_repository" "brainwave" {
  project       = var.landing_project_id
  location      = var.gcp_region
  repository_id = "brainwave"
  format        = "DOCKER"
  description   = "Central Artifact Registry for AI backend containers"
  mode          = "STANDARD_REPOSITORY"
}

resource "google_artifact_registry_repository" "public_docker" {
  project       = var.landing_project_id
  location      = var.gcp_region
  repository_id = "public-docker"
  format        = "DOCKER"
  description   = "Public Artifact Registry for Docker images"
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

resource "google_artifact_registry_repository_iam_member" "public_docker_writer_registry_publisher" {
  depends_on = [
    module.github-identity-federation,
    google_artifact_registry_repository.public_docker
  ]
  project    = var.landing_project_id
  location   = google_artifact_registry_repository.public_docker.location
  repository = google_artifact_registry_repository.public_docker.name
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${module.github-identity-federation.federated-github-users["registry-publisher"].federated-user.email}"
}

resource "google_artifact_registry_repository_iam_member" "public_docker_reader_all_users" {
  depends_on = [
    google_artifact_registry_repository.public_docker
  ]
  project    = var.landing_project_id
  location   = google_artifact_registry_repository.public_docker.location
  repository = google_artifact_registry_repository.public_docker.name
  role       = "roles/artifactregistry.reader"
  member     = "allUsers"
} 