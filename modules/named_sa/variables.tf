variable "service_accounts" {
  description = "A map of service account configurations, where keys are logical identifiers for each SA."
  type = map(object({
    domain            = string
    component         = string
    purpose           = string
    env               = string
    description       = optional(string)
    labels            = optional(map(string))
    sa_type           = optional(string, "standard")
    add_suffix_by_this_module = optional(bool, true)
  }))

  validation {
    condition = alltrue([
      for sa_name, sa_config in var.service_accounts : contains(["standard", "federated"], sa_config.sa_type)
    ])
    error_message = "Each 'sa_type' must be either 'standard' or 'federated'."
  }

  validation {
    condition = alltrue([
      for sa_name, sa_config in var.service_accounts : length(sa_config.domain) > 0
    ])
    error_message = "Domain cannot be empty for any service account."
  }

  validation {
    condition = alltrue([
      for sa_name, sa_config in var.service_accounts : length(sa_config.component) > 0
    ])
    error_message = "Component cannot be empty for any service account."
  }

  validation {
    condition = alltrue([
      for sa_name, sa_config in var.service_accounts : length(sa_config.purpose) > 0
    ])
    error_message = "Purpose cannot be empty for any service account."
  }

  validation {
    condition = alltrue([
      for sa_name, sa_config in var.service_accounts : length(sa_config.env) > 0
    ])
    error_message = "Environment cannot be empty for any service account."
  }
}