terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>6.40"
    }
  }

  required_version = "~> 1.11.4"
}