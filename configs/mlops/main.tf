module "mlops" {
  source     = "../../modules/vertex-ai"
  region     = var.gcp_region
  project-id = var.landing_project_id
} 