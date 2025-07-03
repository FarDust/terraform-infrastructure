module "vertex-ai-blueprint" {
  source = "github.com/FarDust/cloud-foundation-fabric//blueprints/data-solutions/vertex-mlops?ref=02ac1a21e1fe72f453f26f0472a3ff02ba924487"
  
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