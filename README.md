
# Terraform Infrastructure

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)


### 🌐 Terraform Infrastructure for Personal Projects

Welcome to the **Terraform Infrastructure** repository! 🚀 This repository serves as a powerful foundation for managing your personal project infrastructure effortlessly using Terraform, an **Infrastructure as Code (IaC)** tool.

### 📌 Key Features
- **✅ Workload Identity Pool (GitHub):** Seamlessly authenticate your GitHub actions with Google Cloud services securely.
- **🔧 Resources Provided:**
  - Google Cloud IAM member tailored specifically for GitHub actions.

### 🗂️ Project Structure
- **📁 Root Directory:** Contains main configuration files and entry points
- **📁 configs/:** Modularized Terraform configuration files organized by functionality
  - `apis.tf` - API enablement and common labels
  - `identity.tf` - Identity federation and service accounts
  - `mlops.tf` - MLOps and Vertex AI configuration
  - `artifact-registry.tf` - Container registries and IAM
  - `iam.tf` - IAM permissions and bindings
  - `billing.tf` - Billing alerts and budgets
- **📁 modules/:** Reusable Terraform modules
  - **👥 GitHub Identity Federation:** Located in `./modules/github-identity-federation`, this module facilitates identity federation with GitHub users.
  - **🤖 MLOps:** Located in `./modules/vertex-ai`, this module is designed for managing your MLOps workflows.
  - **🔧 Named Service Accounts:** Located in `./modules/named_sa`, this module manages service account naming conventions.

### 📋 Requirements
- **Terraform Version:** ~> 1.6
- **Google Provider Version:** ~> 5.4
- **Google Cloud Version:** 5.10.0

### 📝 License
This project is licensed under the **MIT license**, allowing for flexibility and customization!


## Modules Docs

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.6 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~>5.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.10.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apis"></a> [apis](#module\_apis) | ./configs/apis | n/a |
| <a name="module_artifact_registry"></a> [artifact\_registry](#module\_artifact\_registry) | ./configs/artifact-registry | n/a |
| <a name="module_billing"></a> [billing](#module\_billing) | ./configs/billing | n/a |
| <a name="module_federated_users"></a> [federated\_users](#module\_federated\_users) | ./modules/named_sa | n/a |
| <a name="module_github-identity-federation"></a> [github-identity-federation](#module\_github-identity-federation) | ./modules/github-identity-federation | n/a |
| <a name="module_iam"></a> [iam](#module\_iam) | ./configs/iam | n/a |
| <a name="module_identity"></a> [identity](#module\_identity) | ./configs/identity | n/a |
| <a name="module_mlops"></a> [mlops](#module\_mlops) | ./configs/vertex-ai | n/a |

## Resources

| Name | Type |
|------|------|
| [google_artifact_registry_repository.brainwave](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository) | resource |
| [google_artifact_registry_repository.public_docker](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository) | resource |
| [google_artifact_registry_repository_iam_member.brainwave-writer-deploy-ai-api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository_iam_member) | resource |
| [google_artifact_registry_repository_iam_member.public_docker_reader_all_users](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository_iam_member) | resource |
| [google_artifact_registry_repository_iam_member.public_docker_writer_registry_publisher](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository_iam_member) | resource |
| [google_project_iam_member.cloudrun-developer-deploy-ai-api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.github-actions-artifacts-binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.enable_apis](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account_id"></a> [billing\_account\_id](#input\_billing\_account\_id) | The ID of the GCP billing account to associate budgets and resources with | `string` | n/a | yes |
| <a name="input_federated_github_users"></a> [federated\_github\_users](#input\_federated\_github\_users) | Federated service accounts using named\_sa module. | <pre>map(object({<br>    display_name         = string<br>    description          = string<br>    allowed-repositories = list(string)<br>    domain              = string<br>    component           = string<br>    purpose             = string<br>    env                 = string<br>    sa_type             = optional(string, "federated")<br>    add_suffix_by_this_module = optional(bool, true)<br>  }))</pre> | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | The region in which the resources will be provisioned. | `string` | `"us-central1"` | no |
| <a name="input_landing_identity_pool_id"></a> [landing\_identity\_pool\_id](#input\_landing\_identity\_pool\_id) | The ID of the Identity pool. | `string` | n/a | yes |
| <a name="input_landing_identity_provider_id"></a> [landing\_identity\_provider\_id](#input\_landing\_identity\_provider\_id) | The ID of the Identity pool provider. | `string` | n/a | yes |
| <a name="input_landing_project_id"></a> [landing\_project\_id](#input\_landing\_project\_id) | The ID of the project in which the resources will be provisioned. | `string` | n/a | yes |
| <a name="input_legacy_federated_github_users"></a> [legacy\_federated\_github\_users](#input\_legacy\_federated\_github\_users) | The legacy Github users to federate. | <pre>map(object({<br>    name                 = string<br>    display_name         = string<br>    description          = string<br>    allowed-repositories = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_mlops_project_id"></a> [mlops\_project\_id](#input\_mlops\_project\_id) | The ID of the project in which the resources will be provisioned. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

