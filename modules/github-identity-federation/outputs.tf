output "federated-github-users" {
  value     = module.federated-github-user
  sensitive = true
}

output "owner_condition" {
  description = "Configured repository-owner condition for private verification."
  value       = google_iam_workload_identity_pool_provider.identity-pool-provider.attribute_condition
  sensitive   = true
}
