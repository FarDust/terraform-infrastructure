
resource "google_firestore_database" "main" {
  project     = var.landing_project_id
  name        = "(default)"
  location_id = var.gcp_region
  type        = "FIRESTORE_NATIVE"
  

  concurrency_mode                = "OPTIMISTIC"
  app_engine_integration_mode     = "DISABLED"
  point_in_time_recovery_enablement = "POINT_IN_TIME_RECOVERY_DISABLED"
  delete_protection_state         = "DELETE_PROTECTION_DISABLED"
} 