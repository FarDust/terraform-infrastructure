output "reaper_forge_service_account" {
  description = "The reaper-forge service account"
  value       = google_service_account.reaper_forge
}

output "reaper_forge_service_account_email" {
  description = "The email of the reaper-forge service account"
  value       = google_service_account.reaper_forge.email
} 