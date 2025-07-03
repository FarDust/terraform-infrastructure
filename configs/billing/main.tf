resource "google_pubsub_topic" "billing_alerts" {
  name    = "billing-alerts"
  project = var.landing_project_id
}

resource "google_billing_budget" "dev_budget" {
  billing_account = var.billing_account_id
  display_name    = "budget-alert-dev"

  budget_filter {
    projects = ["projects/${var.landing_project_id}"]
  }

  amount {
    specified_amount {
      currency_code = "USD"
      units         = 20
    }
  }

  threshold_rules {
    threshold_percent = 0.5
  }

  threshold_rules {
    threshold_percent = 1.0
  }

  all_updates_rule {
    pubsub_topic   = "projects/${var.landing_project_id}/topics/${google_pubsub_topic.billing_alerts.name}"
    schema_version = "1.0"
  }

  depends_on = [google_pubsub_topic.billing_alerts]
} 