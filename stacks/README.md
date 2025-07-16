# Application Stacks

This directory contains application-specific infrastructure stacks. Unlike the foundational configurations in `configs/`, these stacks represent complete application deployments with their dedicated resources and service accounts.

## Stack Organization

### `reaper-forge/`
- **main.tf**: Reaper-forge application service account and permissions
- **variables.tf**: Stack variables
- **outputs.tf**: Stack outputs
- **Purpose**: Service account and IAM configuration for the reaper-forge MLOps application

## Stacks vs Configs

- **`configs/`**: Foundational infrastructure (APIs, storage services, identity federation, etc.)
- **`stacks/`**: Application-specific infrastructure bundles (service accounts, app-specific resources)

## Dependencies

Stacks typically depend on foundational configs:

```
stacks/reaper-forge/ → configs/storage/
```

## Usage

The main entry point is `../main.tf` which orchestrates both configs and stacks with proper dependencies. 