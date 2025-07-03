variable "landing_project_id" {
  type        = string
  description = "The ID of the project in which the resources will be provisioned."
  sensitive   = true
}

variable "gcp_region" {
  type        = string
  description = "The region in which the resources will be provisioned."
  default     = "us-central1"
  sensitive   = false
}

variable "github_identity_federation_output" {
  description = "Output from the GitHub identity federation module"
  type        = any
} 