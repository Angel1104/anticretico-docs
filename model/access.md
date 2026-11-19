# Access

## Identities

Each agent acts through its own GitHub identity (GitHub App, or fine-grained token as fallback), passed as `GH_TOKEN` by the runner. Never Angel's personal `gh` login: PRs and merges must show which agent did them.

| Identity | Used by | Can |
|---|---|---|
| Tech Lead App | Tech Lead | Merge PRs to `main` (only identity allowed), push non-`main` branches, push `v*` tags, run deploy workflows, issues, Project |
| Reviewer App | Reviewer | PR reviews (counts as the required approval) |
| Executor App | Executors, ticket workers | Push non-`main` branches, open PRs, comment |
| Product App (or the Executor App limited by ruleset to `design/*`) | Product | Push `design/*` in `<app>-docs`, comment, label |
| `GITHUB_TOKEN` | Workflows (`intake`, `approvals`) | Labels and comments in `<app>-docs` |

## Per agent

| Agent | Has | Does not have |
|---|---|---|
| Product | `<app>-docs` (read; push `design/*`), Claude Design, issue comments and labels, web research | Business decisions, code repos, epic branches |
| Tech Lead | All repos (read), issues, Project, push to `epic/*` `fix/*` `bug/*` `hotfix/*` `spike/*`, push to `<app>-docs` `main` (specs), merge to `main`, dev/stage deploy and prod rollback workflows, session launcher (runner adapter), `v*` tag for low severity | Product code edits, prod tag for medium/high, `terraform apply`, Angel's personal accounts |
| Executor | The branch it was given and its `task/*`, local tests, comments on its tickets and PR, opening PRs | Merge to `main`, tags, deploys, CI config, secrets beyond `.env.dev` |
| Ticket worker | Its `task/*`, tests | Everything else |
| Reviewer | Repos (read), PR review | Writing code, reviewing its own work |
| QA web | Browser on dev and stage; on prod only the smoke, with the prod test account | Production beyond the smoke, real customer data, secrets, repos |

Every agent, whatever its vendor: "You have no access to Angel's email, Outlook, calendar or personal accounts." When something is missing: comment `[BLOCKED]` on the issue, add the label `blocked` and stop. Never look for another way in.

## What enforces it

| Rule | Mechanism |
|---|---|
| Only the Tech Lead merges to `main` | Ruleset on `main`: restrict updates, bypass only for the Tech Lead App (verify in phase 0) |
| Nothing enters `main` without green checks and review | Required status checks + 1 required approval, stale approvals dismissed. Only the Reviewer App reviews; verify in phase 0 that an App's approval counts (Apps cannot be CODEOWNERS) |
| Executors do not merge or tag | Executor App lacks bypass; `deny` rules in the code repo `.claude/settings.json` |
| Prod for medium/high severity is Angel's | Tag ruleset on `v*` (Angel + Tech Lead App) **plus** the tag guard in CI: a ruleset cannot see severity, so the deploy job fails if the tag is medium/high and the tagger is not Angel (`severity.md`) |
| QA touches prod only for the smoke | One prod test account, no admin |
| Headless runs do only what is listed | `allow` lists per repo; anything else asks, and a headless run cannot answer |

Claude Code settings are per repo, not per agent: the `<app>-docs` settings serve the Tech Lead (and Product locally), the code repo settings serve executors. The identity's GitHub permissions are what separates them. Settings `deny` rules are a second line, not the guard: `main` is protected by the ruleset.

No "allow everything" mode: routine actions allowed, forbidden ones denied, the rest asks.

## Permissions checklist (to fill)

Filled from `scripts/preflight.sh` (read-only) at phases 0 and 3 of `model/new-app.md`. Each `no` names who can grant it.

| Permission | For | Have it? |
|---|---|---|
| Create repos in the GitHub org | `<app>-docs` and code repos | {{yes/no}} |
| Create GitHub Apps | Tech Lead, Reviewer and Executor identities | {{yes/no}} |
| Repo admin | Rulesets, required checks | {{yes/no}} |
| Org Projects | Backlog | {{yes/no}} |
| GitHub plan | Which rules exist on private repos | {{Free/Team/Enterprise}} |
| Cloud account per environment | Deploy | {{platform}} |
| Service account with workload identity federation (no JSON keys) | Deploy from Actions without long-lived secrets | {{yes/no}} |
| Claude plan for Claude Code | Running agents | {{plan}} |
| Anthropic API key as repo secret in `<app>-docs` | Product agent in the `intake` Action | {{yes/no}} |
| OpenAI (Codex) and Google (Antigravity) accounts | Non-Claude roles in `agents/assignment.md` | {{yes/no}} |
| Fixed-OTP test accounts (dev, stage) + prod test account | QA and smoke | {{yes/no}} |
| Orca on the Mac | Launching agents | yes |
