mock_provider "google" {}

variables {
  project-id               = "example-project"
  landing-identity-pool-id = "example-pool"
  identity-provider-id     = "example-provider"
  federated-github-users   = {}
}

run "existing_default_preserves_condition_absence" {
  command = plan
  module {
    source = "./modules/github-identity-federation"
  }
  assert {
    condition     = google_iam_workload_identity_pool_provider.identity-pool-provider.attribute_condition == null || google_iam_workload_identity_pool_provider.identity-pool-provider.attribute_condition == ""
    error_message = "An unset optional input must preserve the existing module default."
  }
}

run "explicit_owner_is_exact_and_sensitive" {
  command = plan
  module {
    source = "./modules/github-identity-federation"
  }
  variables {
    github_repository_owner = "example-owner"
  }
  assert {
    condition     = nonsensitive(output.owner_condition) == "attribute.repository_owner == \"example-owner\"\n" && issensitive(output.owner_condition)
    error_message = "The opt-in owner restriction must preserve its exact protected expression."
  }
}

run "invalid_owner_is_rejected" {
  command = plan
  module {
    source = "./modules/github-identity-federation"
  }
  variables {
    github_repository_owner = "example\" || true"
  }
  expect_failures = [var.github_repository_owner]
}

run "legacy_caller_retains_account_name" {
  command = plan
  module {
    source = "./modules/github-identity-federation"
  }
  variables {
    legacy_mode = true
    federated-github-users = {
      example = {
        name                 = "example-fa"
        display_name         = "Example"
        description          = "legacy contract"
        allowed-repositories = ["example-owner/example"]
      }
    }
  }
  assert {
    condition     = nonsensitive(output.federated-github-users["example"].federated-user.account_id) == "example-fa-federated-user"
    error_message = "Legacy callers must retain their original account IDs."
  }
}
