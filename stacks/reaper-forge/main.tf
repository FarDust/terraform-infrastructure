
module "reaper_forge_sa" {
  source = "../../modules/named_sa"
  service_accounts = {
    "reaper-forge" = {
      domain      = "vision"
      component   = "anomaly"
      purpose     = "reaper"
      env         = "prod"
      description = "Service account for reaper-forge vision anomaly detection model"
      sa_type     = "standard"
      add_suffix_by_this_module = true
    }
  }
}


resource "google_service_account" "reaper_forge" {
  project      = var.landing_project_id
  account_id   = module.reaper_forge_sa.service_account_ids["reaper-forge"]
  display_name = "Reaper Forge MLOps Pipeline"
  description  = "Service account for reaper-forge vision anomaly detection model"
}


resource "google_project_iam_member" "reaper_forge_datastore_user" {
  project = var.landing_project_id
  role    = "roles/datastore.user"
  member  = "serviceAccount:${google_service_account.reaper_forge.email}"
} 