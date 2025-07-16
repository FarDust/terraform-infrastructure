
module "reaper_forge_sa" {
  source = "../../modules/named_sa"
  service_accounts = {
    "reaper-forge" = {
      domain      = "ml"
      component   = "reaper"
      purpose     = "forge"
      env         = "prod"
      description = "Service account for reaper-forge MLOps pipeline running on KFP runtime"
      sa_type     = "standard"
      add_suffix_by_this_module = true
    }
  }
}


resource "google_service_account" "reaper_forge" {
  project      = var.landing_project_id
  account_id   = module.reaper_forge_sa.service_account_ids["reaper-forge"]
  display_name = "Reaper Forge MLOps Pipeline"
  description  = "Service account for reaper-forge MLOps pipeline running on KFP runtime"
}


resource "google_firestore_database_iam_member" "reaper_forge_datastore_user" {
  project  = var.landing_project_id
  database = var.firestore_database_name
  role     = "roles/datastore.user"
  member   = "serviceAccount:${google_service_account.reaper_forge.email}"
} 