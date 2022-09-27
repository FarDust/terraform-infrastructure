terraform {

  cloud {
    organization = "fardust"
    workspaces {
      name = "terraform-infrastructure"
    }
  }
}