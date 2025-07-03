# GCP Service Account Naming Enforcer 🛡️ (Terraform Module)

This module enforces a consistent naming standard for Google Cloud Platform Service Accounts. It generates and validates `account_id`s according to predefined rules, ensuring compliance with GCP's 30-character limit and promoting clear resource identification across your infrastructure.

## The Standard: Required Format 🎯

All Service Accounts will adhere to this format:

`[domain]-[component]-[purpose]-[env]-[suffix]`

### Component Breakdown:

*   **`[domain]`**: Identifies the primary logical grouping or infrastructure domain (e.g., `github`, `apps`, `ml`, `admin`). This should align with your folder structure domains and represent the top-level organizational boundary. Prioritize semantic clarity over strict abbreviation - the name should be immediately recognizable. 🧠
*   **`[component]`**: Describes the specific service or functional area within the domain (e.g., `registry`, `web`, `data-proc`, `federation`). This is equivalent to a service configuration file (like `registry.yml` in your stack). **This is the FIRST component to abbreviate** if the total name approaches or exceeds the 30-character limit, but maintain clarity.
*   **`[purpose]`**: Indicates the specific microservice or primary action/role (e.g., `publish`, `reader`, `invoker`, `admin`). This represents the actual workload or permission scope within the component. **This is the SECOND component to abbreviate** if shortening `[component]` was insufficient. Use clear abbreviations (`read`, `exec`, `pub`).
*   **`[env]`**: Identifies the environment or access scope (e.g., `prod`, `stg`, `dev`, `public`). This can represent traditional environments or access levels.
*   **`[suffix]`**: Explicitly marks the resource type based on `sa_type`.
    *   `-sa`: For standard Service Accounts.
    *   `-fa`: For Service Accounts used with Workload Identity Federation.

### Semantic Clarity Priority 📖

The naming convention prioritizes **semantic readability** over strict categorical adherence. The resulting name should read naturally and immediately convey:
1. What domain/system it belongs to
2. What service/component it serves  
3. What specific purpose it fulfills
4. What environment/scope it operates in

**Example**: `github-artifact-reg-pub-fa` reads as "GitHub artifact registry public federated account" - immediately clear that this is a GitHub federated user that publishes to GCP Artifact Registry.

### Naming Process:

1.  Draft the full name using all components, prioritizing semantic clarity.
2.  **Validate the length.** If `<= 30 characters`, proceed.
3.  **If `> 30 characters`:**
    1.  Abbreviate `[component]` while maintaining clarity (e.g., `registry` → `reg`).
    2.  If still exceeding 30 characters, then abbreviate `[purpose]` (e.g., `publish` → `pub`).
    3.  As a final resort, abbreviate `[domain]` (e.g., `github` → `gh`).

## Enforcement Rules:

This module validates generated `account_id`s against strict rules:

*   **30-Character Limit:** Terraform will fail if any generated `account_id` exceeds GCP's 30-character limit. The error message will explicitly state the offending name and its length. The responsibility for abbreviation to meet this limit lies with the user's input. 💥
*   **Suffix Control:** The `sa_type` variable determines the correct suffix. The `add_suffix_by_this_module` variable allows bypassing suffix generation by this module if an external process handles it. However, the 30-character validation will still apply to the resulting name. 🧠

## How to Use:

Provide a map of your Service Account definitions. This module will return a map of validated `account_id`s. These IDs are then used to instantiate `google_service_account` resources.

## Inputs:

*   `service_accounts` (map of objects): A map of Service Account definitions. Each object requires:
    *   `domain` (string): The primary logical grouping or infrastructure domain
    *   `component` (string): The specific service or functional area
    *   `purpose` (string): The specific microservice or primary action/role
    *   `env` (string): The environment identifier or access scope
    *   `sa_type` (string, optional, default `standard`): Allowed values: `"standard"` or `"federated"`.
    *   `add_suffix_by_this_module` (bool, optional, default `true`): Set to `false` if the suffix is managed externally.
    *   `description` (string, optional): Used for the final `google_service_account` resource's description.
    *   `labels` (map, optional): Used for the final `google_service_account` resource's labels.

## Outputs:

*   `service_account_ids` (map of strings): A map containing all generated `account_id`s, validated against the 30-character limit. These are ready for use in creating `google_service_account` resources.