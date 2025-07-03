moved {
  from = google_project_service.enable_apis
  to   = module.apis.google_project_service.enable_apis
}

moved {
  from = module.federated_users
  to   = module.identity.module.federated_users
}

moved {
  from = module.github-identity-federation
  to   = module.identity.module.github-identity-federation
}


moved {
  from = google_artifact_registry_repository.brainwave
  to   = module.artifact_registry.google_artifact_registry_repository.brainwave
}

moved {
  from = google_artifact_registry_repository.public_docker
  to   = module.artifact_registry.google_artifact_registry_repository.public_docker
}

moved {
  from = google_artifact_registry_repository_iam_member.brainwave-writer-deploy-ai-api
  to   = module.artifact_registry.google_artifact_registry_repository_iam_member.brainwave-writer-deploy-ai-api
}

moved {
  from = google_artifact_registry_repository_iam_member.public_docker_writer_registry_publisher
  to   = module.artifact_registry.google_artifact_registry_repository_iam_member.public_docker_writer_registry_publisher
}

moved {
  from = google_artifact_registry_repository_iam_member.public_docker_reader_all_users
  to   = module.artifact_registry.google_artifact_registry_repository_iam_member.public_docker_reader_all_users
}

moved {
  from = google_project_iam_member.github-actions-artifacts-binding
  to   = module.iam.google_project_iam_member.github-actions-artifacts-binding
}

moved {
  from = google_project_iam_member.cloudrun-developer-deploy-ai-api
  to   = module.iam.google_project_iam_member.cloudrun-developer-deploy-ai-api
}

moved {
  from = google_pubsub_topic.billing_alerts
  to   = module.billing.google_pubsub_topic.billing_alerts
}

moved {
  from = google_billing_budget.dev_budget
  to   = module.billing.google_billing_budget.dev_budget
} 