variable "gcp_region" {
  type = string
  description = "The region in which the resources will be provisioned."
  default = "us-central1"
  sensitive = false
}

variable "landing_project_id" {
  type = string
  description = "The ID of the project in which the resources will be provisioned."
  sensitive = true
}

variable "landing_identity_pool_id" {
  type = string
  description = "The ID of the Identity pool."
  sensitive = true
}

variable "landing_identity_provider_id" {
  type = string
  description = "The ID of the Identity pool provider."
  sensitive = true
}

variable "federated_github_users" {
  type = map(object({
    name = string
    display_name = string
    description = string
    allowed-repositories = list(string)
  }))
  description = "The Github users to federate."
  sensitive = false
}