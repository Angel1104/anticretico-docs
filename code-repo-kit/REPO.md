# REPO.md

| Command | What |
|---|---|
| {{install}} | Install dependencies |
| {{test}} | Unit and integration tests |
| {{lint}} | Lint and format check |
| {{e2e}} | Playwright tests |
| {{run}} | Run locally |

Copy the first four commands into the `allow` list of `.claude/settings.json` (same placeholders). A command that is not allowed asks for permission, and a headless executor cannot answer: the run blocks.

## Layers
{{e.g. api/ → services/ → repositories/ → models/}}

## Local conventions
{{naming, error handling, i18n files location}}
