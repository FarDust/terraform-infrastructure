variable "github_repository_owner" {
  type        = string
  description = "Optional repository-owner restriction. Supply privately to enable it; null preserves the existing provider configuration."
  sensitive   = true
  default     = null

  validation {
    condition     = var.github_repository_owner == null ? true : (length(var.github_repository_owner) <= 39 && can(regex("^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$", var.github_repository_owner)))
    error_message = "Supply a valid GitHub owner name or leave the optional restriction unset."
  }
}

variable "legacy_mode" {
  type        = bool
  description = "Preserve the original binding resource addresses and account naming for legacy state. Existing callers keep modern member semantics by default."
  default     = false
}

variable "federated-github-users" {
  type = map(object({
    name                 = string
    display_name         = string
    description          = string
    allowed-repositories = list(string)
  }))
  description = "A map of federated users to create"
  sensitive   = false
}

variable "project-id" {
  type        = string
  description = "The project ID to create the service account in."
  sensitive   = true
}

variable "landing-identity-pool-id" {
  type        = string
  description = "The identity pool to use for the federated user"
  sensitive   = true
}

variable "identity-provider-id" {
  type        = string
  description = "The identity provider to use for the federated user"
  sensitive   = true
}
