locals {
  suffix_map = {
    "standard"  = "-sa"
    "federated" = "-federated-user"
  }

  calculated_account_ids = {
    for key, sa_params in var.service_accounts : key => {
      calculated_suffix = sa_params.add_suffix_by_this_module ? lookup(local.suffix_map, sa_params.sa_type, "-sa") : ""
      account_id        = "${sa_params.domain}-${sa_params.component}-${sa_params.purpose}-${sa_params.env}${calculated_suffix}"
    }
  }

  validation_result = {
    for key, config in local.calculated_account_ids : key => {
      account_id = config.account_id
      is_valid  = length(config.account_id) <= 30
    }
  }

  _validation_check = alltrue([for k, v in local.validation_result : v.is_valid]) ? null : file("ERROR: Service Account ID length validation failed. Review the following IDs that exceed GCP's 30-character limit:\n${join("\n", [for k, v in local.validation_result : !v.is_valid ? "  - '${v.account_id}' (key: '${k}') - ${length(v.account_id)} chars" : ""])}\n\nReview 'domain', 'component', and 'purpose' for required abbreviations in your input, or consider setting 'add_suffix_by_this_module = false' if an external suffix is intended.")
}