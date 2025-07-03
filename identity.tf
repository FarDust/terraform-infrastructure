# Federated users using named_sa module (only for users with named_sa config)
module "federated_users" {
  source = "./modules/named_sa"
  service_accounts = {
    for key, user in var.federated_github_users : key => {
      domain            = user.domain
      component         = user.component
      purpose           = user.purpose
      env               = user.env
      description       = user.description
      sa_type           = user.sa_type
      add_suffix_by_this_module = user.add_suffix_by_this_module
    } if user.domain != null
  }
}

module "github-identity-federation" {
  source                   = "./modules/github-identity-federation"
  project-id               = var.landing_project_id
  federated-github-users   = merge(
    var.legacy_federated_github_users,
    {
      for key, user in var.federated_github_users : key => {
        name                 = module.federated_users.service_account_ids[key]
        display_name         = user.display_name
        description          = user.description
        allowed-repositories = user.allowed-repositories
      }
    }
  )
  landing-identity-pool-id = var.landing_identity_pool_id
  identity-provider-id     = var.landing_identity_provider_id
  depends_on               = [module.federated_users]
} 