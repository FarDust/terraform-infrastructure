provider "google" {
  project     = var.landing_project_id
  region      = "${var.gcp_region}"
}