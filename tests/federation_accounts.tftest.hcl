mock_provider "google" {}

variables {
  project-id           = "example-project"
  identity-pool-name   = "projects/123456/locations/global/workloadIdentityPools/example-pool"
  name                 = "example-fa"
  display_name         = "Example"
  description          = "shared module contracts"
  allowed-repositories = ["example-owner/first", "example-owner/second"]
}

run "modern_default_preserves_members_and_name" {
  command = plan
  module {
    source = "./modules/github-identity-federation/federated-github-user"
  }
  assert {
    condition     = length(google_service_account_iam_member.github-federated-user-repository-binding) == 2 && length(google_service_account_iam_binding.github-federated-user-repository-binding) == 0
    error_message = "Existing callers must continue to use independent IAM members."
  }
  assert {
    condition     = nonsensitive(google_service_account.federated-user.account_id) == "example-fa"
    error_message = "Existing modern account naming must remain unchanged."
  }
}

run "legacy_binding_preserves_address_and_name" {
  command = plan
  module {
    source = "./modules/github-identity-federation/federated-github-user"
  }
  variables {
    legacy-repositories = ["example-owner/first"]
  }
  assert {
    condition     = length(google_service_account_iam_member.github-federated-user-repository-binding) == 0 && length(google_service_account_iam_binding.github-federated-user-repository-binding) == 1
    error_message = "Legacy callers must retain binding resources rather than migrate resource types."
  }
  assert {
    condition     = nonsensitive(google_service_account.federated-user.account_id) == "example-fa-federated-user"
    error_message = "Legacy account naming must retain its original suffix."
  }
}

run "legacy_conflicting_bindings_rejected" {
  command = plan
  module {
    source = "./modules/github-identity-federation/federated-github-user"
  }
  variables {
    legacy-repositories = ["example-owner/first", "example-owner/second"]
  }
  expect_failures = [var.legacy-repositories]
}

run "legacy_duplicates_are_one_binding" {
  command = plan
  module {
    source = "./modules/github-identity-federation/federated-github-user"
  }
  variables {
    legacy-repositories = ["example-owner/first", "example-owner/first"]
  }
  assert {
    condition     = length(google_service_account_iam_binding.github-federated-user-repository-binding) == 1
    error_message = "Duplicate legacy repositories must not create competing bindings."
  }
}
