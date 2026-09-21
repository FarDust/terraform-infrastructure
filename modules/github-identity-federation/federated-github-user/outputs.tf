output "federated-user" {
  value     = google_service_account.federated-user
  sensitive = true
}

output "iam_binding_count" {
  description = "Number of legacy binding instances, for compatibility verification."
  value       = length(google_service_account_iam_binding.github-federated-user-repository-binding)
}

output "iam_member_count" {
  description = "Number of modern member instances, for compatibility verification."
  value       = length(google_service_account_iam_member.github-federated-user-repository-binding)
}
