# Infrastructure Outputs
# These outputs provide useful information for cross-project communication and monitoring

# Project Information
output "project_id" {
  description = "The GCP project ID where resources are deployed"
  value       = var.landing_project_id
  sensitive   = true
}

output "region" {
  description = "The GCP region where resources are deployed"
  value       = var.gcp_region
}

# Identity Federation Outputs
output "identity_pool_id" {
  description = "The Workload Identity Pool ID for GitHub federation"
  value       = var.landing_identity_pool_id
  sensitive   = true
}

output "identity_provider_id" {
  description = "The Workload Identity Provider ID for GitHub federation"
  value       = var.landing_identity_provider_id
  sensitive   = true
}

# Service Account Information
output "federated_service_accounts" {
  description = "Map of federated service accounts with their details"
  value = {
    for key, user in var.federated_github_users : key => {
      name        = module.identity.federated_users[key].name
      email       = module.identity.github_identity_federation.federated-github-users[key].federated-user.email
      display_name = user.display_name
      description = user.description
      allowed_repositories = user.allowed-repositories
    }
  }
}

# Artifact Registry Information
output "artifact_registries" {
  description = "Information about artifact registries"
  value = {
    brainwave = {
      name     = module.artifact_registry.brainwave.name
      location = module.artifact_registry.brainwave.location
      format   = module.artifact_registry.brainwave.format
      mode     = module.artifact_registry.brainwave.mode
    }
    public_docker = {
      name     = module.artifact_registry.public_docker.name
      location = module.artifact_registry.public_docker.location
      format   = module.artifact_registry.public_docker.format
      mode     = module.artifact_registry.public_docker.mode
    }
  }
}

# Registry URLs for cross-project access
output "registry_urls" {
  description = "Artifact Registry URLs for cross-project access"
  value = {
    brainwave = "${var.gcp_region}-docker.pkg.dev/${var.landing_project_id}/brainwave"
    public_docker = "${var.gcp_region}-docker.pkg.dev/${var.landing_project_id}/public-docker"
  }
  sensitive = true
}

# Billing Information
output "billing_topic" {
  description = "Pub/Sub topic for billing alerts"
  value       = module.billing.billing_alerts_topic.name
}

output "billing_budget" {
  description = "Billing budget information"
  value = {
    name         = module.billing.dev_budget.display_name
    amount       = module.billing.dev_budget.amount[0].specified_amount[0].units
    currency     = module.billing.dev_budget.amount[0].specified_amount[0].currency_code
    thresholds   = module.billing.dev_budget.threshold_rules[*].threshold_percent
  }
}

# Cross-Project IAM Information
output "cross_project_iam" {
  description = "IAM information for cross-project access"
  value = {
    registry_publisher_sa = module.identity.github_identity_federation.federated-github-users["registry-publisher"].federated-user.email
    public_artifacts_sa   = module.identity.github_identity_federation.federated-github-users["public-artifacts"].federated-user.email
    deploy_ai_api_sa      = module.identity.github_identity_federation.federated-github-users["deploy-ai-api"].federated-user.email
  }
}

# Network and Security Information
output "network_info" {
  description = "Network and security information for cross-project access"
  value = {
    project_number = data.google_project.current.number
    project_name   = data.google_project.current.name
  }
}

# Data source for project information
data "google_project" "current" {
  project_id = var.landing_project_id
} 