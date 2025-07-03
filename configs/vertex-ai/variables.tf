variable "project-id" {
  type        = string
  description = "The project ID to create the service account in."
  sensitive   = true
}

variable "region" {
  type        = string
  description = "The region in which the resources will be provisioned."
  default     = "us-central1"
}