output "github_identity_federation" {
  description = "Output from the GitHub identity federation module"
  value       = module.github-identity-federation
}

output "federated_users" {
  description = "Federated users service accounts"
  value       = module.federated_users
} 