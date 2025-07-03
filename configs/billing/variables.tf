variable "landing_project_id" {
  type        = string
  description = "The ID of the project in which the resources will be provisioned."
  sensitive   = true
}

variable "billing_account_id" {
  description = "The ID of the GCP billing account to associate budgets and resources with"
  type        = string
  sensitive   = true
} 