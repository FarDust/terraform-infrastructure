
module "apis" {
  source = "./configs/apis"
  landing_project_id = var.landing_project_id
}

module "identity" {
  source = "./configs/identity"
  landing_project_id = var.landing_project_id
  federated_github_users = var.federated_github_users
  legacy_federated_github_users = var.legacy_federated_github_users
  landing_identity_pool_id = var.landing_identity_pool_id
  landing_identity_provider_id = var.landing_identity_provider_id
}

module "mlops" {
  source     = "./configs/vertex-ai"
  region     = var.gcp_region
  project-id = var.landing_project_id
}

module "artifact_registry" {
  source = "./configs/artifact-registry"
  landing_project_id = var.landing_project_id
  gcp_region = var.gcp_region
  github_identity_federation_output = module.identity.github_identity_federation
  depends_on = [module.identity]
}

module "iam" {
  source = "./configs/iam"
  landing_project_id = var.landing_project_id
  github_identity_federation_output = module.identity.github_identity_federation
  depends_on = [module.identity]
}

module "storage" {
  source = "./configs/storage"
  landing_project_id = var.landing_project_id
  gcp_region = var.gcp_region
  depends_on = [module.apis]
}

module "reaper_forge" {
  source = "./stacks/reaper-forge"
  landing_project_id = var.landing_project_id
  firestore_database_name = module.storage.firestore_database.name
  depends_on = [module.storage]
}

module "billing" {
  source = "./configs/billing"
  landing_project_id = var.landing_project_id
  billing_account_id = var.billing_account_id
}
