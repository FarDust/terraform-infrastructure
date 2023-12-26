module "vertex-ai-blueprint" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//blueprints/data-solutions/vertex-mlops?ref=v28.0.0"
  notebooks = {
    "personal-workbench" = {
      type = "USER_MANAGED"
    }
  }
  bucket_name  = "fardust-mlops-artifacts"
  dataset_name = "MLOPS_TRAIN_DATASET"
  prefix       = null
  region       = var.region
  location     = split("-", var.region)[0]
  project_config = {
    project_id = var.project-id
  }
}