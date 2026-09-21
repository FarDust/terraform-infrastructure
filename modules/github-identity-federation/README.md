# GitHub identity federation

Existing callers keep the current service-account naming and non-authoritative
IAM member resources by default.

## Optional owner restriction

Set `github_repository_owner` from private deployment configuration to require
an exact repository-owner match at the provider. The input and `owner_condition`
output are sensitive. The default `null` preserves the prior module behavior;
applications that require this trust boundary should require the input at their
own boundary. No deployment owner is embedded in this module.

## Preserving legacy state

Set `legacy_mode = true` only for a caller whose existing state uses the original
`google_service_account_iam_binding` resources and `-federated-user` account
naming. This keeps their resource addresses and naming unchanged instead of
implicitly migrating IAM ownership while updating the module.

Legacy bindings permit at most one distinct repository per account because
multiple authoritative bindings for the same role would compete. Modern mode
continues to support multiple repositories through independent IAM members.
The lower-level account module selects legacy behavior with the optional
`legacy-repositories` input; leaving it null preserves its existing API behavior.

## Versioning and verification

These optional capabilities are backward-compatible additions: existing inputs
and defaults remain accepted. Release them using Semantic Versioning and pin
consumers to an immutable release revision. A required new input, changed default,
resource-type change, or automatic state-address migration would require a major
release instead. Verify both modern and legacy contracts with the committed
mock-provider tests and inspect full plans against each consumer's own state.
