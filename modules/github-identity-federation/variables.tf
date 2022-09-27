variable "federated-github-users" {
  type = map(object({
    name = string
    display_name = string
    description = string
    allowed-repositories = list(string)
  }))
  description = "A map of federated users to create"
  sensitive = false
}

variable "project-id" {
  type        = string
  description = "The project ID to create the service account in."
  sensitive = true
}

variable "landing-identity-pool-id" {
  type        = string
  description = "The identity pool to use for the federated user"
  sensitive = true
}

variable "identity-provider-id" {
  type       = string
  description = "The identity provider to use for the federated user"
  sensitive = true
}