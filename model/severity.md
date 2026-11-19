# Severity

The Tech Lead declares severity at the start. A script recalculates it from the real diff on every PR; the higher one wins. Signals are paths and content patterns, never judgement, so a script can decide.

| Signal in the diff | Minimum level |
|---|---|
| UI only, non-legal copy, tests, docs | Low |
| Business logic without data model change | Low |
| New dependency or major version bump | Medium |
| Config, feature flag or environment variable change | Medium |
| Additive migration (new table or nullable column) | Medium |
| Migration that drops, renames or changes types | High |
| Auth, permissions, roles, sessions | High |
| Payments, legal text, personal data | High |
| Infrastructure (Terraform, Cloud Run, secrets) | High |
| New third party (API, external SDK) | High |

Path patterns per signal are configured per app in `canon/architecture.md`. If the recalculated level is higher than declared, the PR is relabelled and blocked until the Tech Lead accepts the new level. The `sev:*` label is the source of truth; the Project field mirrors it.

## Mandatory checks before merge or release

| Check | Who | Blocks |
|---|---|---|
| Tests green on the PR SHA | CI | Merge |
| Migrations detected and listed in the spec | CI (script) | Merge |
| New dependencies and CVEs | CI (dependency review, audit) | Merge |
| Recalculated severity ≤ declared, or relabelled | CI (script) | Merge until accepted |
| Review approved | Reviewer | Merge |
| UI QA with screenshots, PASS | QA web | Production |
| Legal text and translations complete (missing text never blocks the build) | CI (script) | Production |
| Tag guard: on push of `v*`, highest severity of the epics since the previous tag; medium/high and the tagger is not Angel → deploy fails | CI (script) | Production |
