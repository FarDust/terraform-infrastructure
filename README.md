
# Terraform Infrastructure

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)


This module serves as the foundation for the infrastructure of my personal projects. It leverages Terraform, a popular Infrastructure as Code (IaC) tool, to provision and manage resources in an automated, consistent, and manageable manner.

The module is designed to create the following resources:

- Workload Identity Pool (Github): This resource allows your GitHub actions to authenticate with Google Cloud services. It provides a secure way to manage and authorize my GitHub workflows.

## Modules Docs

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.2.9 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.36.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.36.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_github-identity-federation"></a> [github-identity-federation](#module\_github-identity-federation) | ./modules/github-identity-federation | n/a |

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.github-actions-artifacts-binding](https://registry.terraform.io/providers/hashicorp/google/4.36.0/docs/resources/project_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_federated_github_users"></a> [federated\_github\_users](#input\_federated\_github\_users) | The Github users to federate. | <pre>map(object({<br>    name                 = string<br>    display_name         = string<br>    description          = string<br>    allowed-repositories = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | The region in which the resources will be provisioned. | `string` | `"us-central1"` | no |
| <a name="input_landing_identity_pool_id"></a> [landing\_identity\_pool\_id](#input\_landing\_identity\_pool\_id) | The ID of the Identity pool. | `string` | n/a | yes |
| <a name="input_landing_identity_provider_id"></a> [landing\_identity\_provider\_id](#input\_landing\_identity\_provider\_id) | The ID of the Identity pool provider. | `string` | n/a | yes |
| <a name="input_landing_project_id"></a> [landing\_project\_id](#input\_landing\_project\_id) | The ID of the project in which the resources will be provisioned. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

