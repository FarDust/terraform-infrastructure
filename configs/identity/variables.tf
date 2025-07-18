variable "landing_project_id" {
  type        = string
  description = "The ID of the project in which the resources will be provisioned."
  sensitive   = true
}

variable "federated_github_users" {
  type = map(object({
    display_name         = string
    description          = string
    allowed-repositories = list(string)
    domain              = string
    component           = string
    purpose             = string
    env                 = string
    sa_type             = optional(string, "federated")
    add_suffix_by_this_module = optional(bool, true)
  }))
  description = "Federated service accounts using named_sa module."
  sensitive   = false
}

variable "legacy_federated_github_users" {
  type = map(object({
    name                 = string
    display_name         = string
    description          = string
    allowed-repositories = list(string)
  }))
  description = "The legacy Github users to federate."
  sensitive   = false
}

variable "landing_identity_pool_id" {
  type        = string
  description = "The ID of the Identity pool."
  sensitive   = true
}

variable "landing_identity_provider_id" {
  type        = string
  description = "The ID of the Identity pool provider."
  sensitive   = true
} 