# Repository Workflow

## Scope and Structure

- Treat the root configuration as the integration layer for reusable modules in `configs/` and `modules/`.
- Keep changes focused. Do not mix unrelated infrastructure, documentation, or formatting updates in the same delivery.
- Read the nearest applicable `AGENTS.md` before working in a directory. Use repository-relative paths in documentation, commands, and review notes.

## Terraform Workflow

1. Inspect the affected root configuration, module interfaces, and their callers before editing.
2. Preserve the declared Terraform and provider constraints in `versions.tf`; coordinate version changes across the configuration and lock file when present.
3. Run `terraform fmt -check -recursive`, `terraform init -input=false`, and `terraform validate -no-color` from the repository root for configuration changes.
4. Review a full, non-targeted plan from the configured backend before requesting or performing an apply. Treat targeted plans as diagnostic only.
5. Never commit state, plan artifacts, generated credentials, or variable files containing environment values. Keep sensitive values in approved secret or workspace-variable systems.

## Shared Module Coordination

- When changing a module input, output, resource address, or default, update every in-repository caller and the module documentation in the same change.
- Preserve resource addresses and state continuity. Use explicit moved blocks for intentional address changes and include the expected state effect in review evidence.
- Keep module interfaces typed and documented. Make compatibility impacts explicit in the pull request description and release notes when applicable.

## Security and Cost Review

- Apply least privilege to IAM, federation, service accounts, and registry access. Scope identities and permissions to the required repositories, resources, and actions.
- Mark sensitive Terraform inputs and outputs appropriately, and do not expose secret values in plans, logs, issues, commit messages, or documentation.
- For changes that can alter spend, review the plan for creates, replacements, deletes, region changes, capacity changes, and billing-related resources. Record the expected cost impact or explain why it is unchanged.

## VCS Delivery and Completion Evidence

- Preserve unrelated working-tree changes. Stage and commit only files that belong to the requested change.
- Use focused commits that follow the repository's established commit-message style. Do not rewrite shared history or force-push unless explicitly authorized.
- Before delivery, provide evidence for formatting, validation, the full plan summary, module-caller compatibility, security review, and cost review as applicable.
- Report completion only after the requested observable result is verified. If a required check cannot run, state the exact blocker and distinguish it from a passing check.
