# Changelog

## 0.1.0

First SemVer release of the shared federation module.

- Add an optional sensitive repository-owner condition without changing existing defaults.
- Add explicit legacy compatibility for original IAM binding addresses and account naming.
- Preserve modern IAM member behavior and multi-repository support by default.
- Expose sensitive owner-condition and binding-count verification outputs.
- Add mock-provider regression coverage for modern and legacy callers.

Compatibility: additive inputs and outputs; no automatic resource migration.
