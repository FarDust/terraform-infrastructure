output "billing_alerts_topic" {
  description = "Pub/Sub topic for billing alerts"
  value       = google_pubsub_topic.billing_alerts
}

output "dev_budget" {
  description = "Billing budget resource"
  value       = google_billing_budget.dev_budget
} 