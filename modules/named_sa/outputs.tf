output "service_account_ids" {
  description = "A map of generated service account IDs, validated against GCP's 30-character limit. Use these IDs to create the actual Service Accounts."
  value = {
    for key, config in local.calculated_account_ids : key => config.account_id
  }
}

output "service_account_configs" {
  description = "Complete service account configurations including calculated IDs and metadata."
  value = local.calculated_account_ids
}

output "validation_summary" {
  description = "Summary of validation results for all service account IDs."
  value = {
    total_accounts = length(local.calculated_account_ids)
    valid_accounts = length([for k, v in local.validation_result : v if v.is_valid])
    invalid_accounts = length([for k, v in local.validation_result : v if !v.is_valid])
    invalid_ids = [for k, v in local.validation_result : v.account_id if !v.is_valid]
  }
}