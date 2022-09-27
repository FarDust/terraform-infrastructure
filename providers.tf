provider "google" {
  project     = var.landing-project-id
  region      = "${var.gcp-region}"
}