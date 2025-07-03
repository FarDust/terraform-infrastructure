output "brainwave" {
  description = "Brainwave artifact registry"
  value       = google_artifact_registry_repository.brainwave
}

output "public_docker" {
  description = "Public Docker artifact registry"
  value       = google_artifact_registry_repository.public_docker
} 