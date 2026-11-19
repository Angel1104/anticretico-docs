# Architecture

- **Components and repos:** {{backend: ..., web: ..., mobile: ...}}
- **Who calls whom:** {{...}}
- **Severity path patterns** (used by the severity script, see `model/severity.md`):

| Signal | Paths / patterns |
|---|---|
| Migrations | {{e.g. backend/migrations/**}} |
| Auth | {{...}} |
| Payments / legal / personal data | {{...}} |
| Infrastructure | {{e.g. infra/**, *.tf}} |
| Config / flags / env | {{...}} |

- **Shared registry files** (parallel epics may add entries; conflicts are resolved by keeping both sides, see `model/branches.md` rule 6):

| File | What it registers |
|---|---|
| {{e.g. web/src/routes.tsx}} | {{routes}} |
| {{e.g. web/src/i18n/*.json}} | {{texts per locale}} |
| {{canon/modules.md}} | {{modules}} |
