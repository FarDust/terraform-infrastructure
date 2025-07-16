variable "landing_project_id" {
  type        = string
  description = "The ID of the project in which the resources will be provisioned."
  sensitive   = true
}

variable "firestore_database_name" {
  type        = string
  description = "The name of the Firestore database to grant access to."
  default     = "(default)"
} 