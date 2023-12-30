module "vertex-ai-blueprint" {
  source = "https://github.com/FarDust/cloud-foundation-fabric//blueprints/data-solutions/vertex-mlops"
  notebooks = {
    "personal-workbench" = {
      type = "USER_MANAGED"
    }
  }
  bucket_name  = "fardust-mlops-artifacts"
  dataset_name = "MLOPS_TRAIN_DATASET"
  region       = var.region
  location     = split("-", var.region)[0]
  project_config = {
    project_id = var.project-id
  }
}