terraform {
  backend "gcs" {
    bucket  = "tf-state-fardust"
    prefix  = "landing/state/prod"
  }
}