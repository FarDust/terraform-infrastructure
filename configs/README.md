# Terraform Configuration Structure

This directory contains the modularized Terraform configuration organized into logical modules.

## Module Organization

### `apis/`
- **main.tf**: API enablement and common labels
- **variables.tf**: Module variables
- **outputs.tf**: Module outputs
- **Purpose**: Enables required Google Cloud APIs

### `identity/`
- **main.tf**: Identity federation and service accounts
- **variables.tf**: Module variables
- **outputs.tf**: Module outputs
- **Purpose**: Manages federated users and GitHub identity federation

### `mlops/`
- **main.tf**: MLOps and Vertex AI configuration
- **variables.tf**: Module variables
- **Purpose**: Machine Learning Operations setup

### `artifact-registry/`
- **main.tf**: Container registry configurations
- **variables.tf**: Module variables
- **Purpose**: Manages artifact registries and their IAM permissions

### `iam/`
- **main.tf**: IAM permissions and role bindings
- **variables.tf**: Module variables
- **Purpose**: Project-level IAM permissions

### `billing/`
- **main.tf**: Billing and monitoring setup
- **variables.tf**: Module variables
- **Purpose**: Budget configuration and billing alerts

## Module Dependencies

```
apis/ → (no dependencies)
identity/ → (no dependencies)
mlops/ → (no dependencies)
artifact-registry/ → identity/
iam/ → identity/
billing/ → (no dependencies)
```

## Usage

The main entry point is `../main.tf` which orchestrates all modules with proper dependencies and moved blocks for resource organization.

## Benefits

- **Clean Separation**: Each module has a single responsibility
- **Professional Structure**: No cluttered root directory
- **Maintainable**: Easy to modify individual components
- **Scalable**: Simple to add new modules
- **Team Collaboration**: Different developers can work on different modules 