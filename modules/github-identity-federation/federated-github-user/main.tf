resource "google_service_account" "federated-user" {
  account_id   = "${var.name}-federated-user"
  display_name = "${var.display_name} Federated User"
  description  = "Service account for ${var.display_name} Federated User that ${var.description}"
  project      = var.project-id
}

resource "google_service_account_iam_binding" "github-federated-user-repository-binding" {
  for_each = toset(var.allowed-repositories)
  service_account_id = google_service_account.federated-user.name
  role = "roles/iam.workloadIdentityUser"
  members = [
      "principalSet://iam.googleapis.com/${var.identity-pool-name}/attribute.repository/${each.value}"
    ]
}
