# Workflow

Each technical epic is one feature and goes from request to production on its own, owned end to end by an AI Tech Lead. The Tech Lead may run several epics in parallel or one after another; none waits for the others.

A new app first goes through discovery and design (`new-app.md`). Then every feature follows the flow below.

## Roles

| Role | Holder | Owns |
|---|---|---|
| Angel (Engineering Lead) | Human | Business and UI decisions; production tag for medium/high severity; emergencies |
| Product agent | AI, always Claude | Discovery, MVP proposal, design system, screens in Claude Design, briefs, business questions. Never decides business |
| Tech Lead | AI, always Claude | Specs, severity, branches, executors, merges, dev and stage testing, low-severity tags, session table |
| Executor (one per epic) | AI | Builds the epic, its fixes and conflict resolution; one ticket-worker subagent per ticket |
| Reviewer | AI, separate session | Reviews each epic PR against its spec |
| QA web | AI, separate session | Acceptance cases on dev and stage; smoke on prod |

## Where Angel steps in

| When | What |
|---|---|
| New app | Approves the MVP, then the design system and screens (`/approved`) |
| Before building | Answers business questions and approves the design (`/ui-approved`) |
| Before production | Creates the production tag when severity is medium or high |
| Only when called | Business or UI questions labelled `needs:angel`; production emergencies |

Everything else is the Tech Lead's: branches, merges to `main`, dev and stage testing, bug fixes, technical questions, the low-severity tag.

## Flow of one epic

| # | Step | Who |
|---|---|---|
| 1 | Request arrives (`/feature`, issue form) | Angel or anyone |
| 2 | Brief, business questions, screens in Claude Design exported to `design/`; label `needs:angel` | Product agent |
| 3 | Business answered, then `/ui-approved` | Angel |
| 4 | Spec (`specs/<KEY>.md`), severity, tickets as sub-issues | Tech Lead |
| 5 | `epic/<KEY>` from `main`, own worktree, executor launched | Tech Lead |
| 6 | One subagent per ticket in sub-worktrees from the epic; tests first | Executor |
| 7 | PR `epic/<KEY>` → `main`, reviewed in a separate session | Reviewer |
| 8 | Deploy to dev, every acceptance case with screenshots | QA web |
| 9 | Merge to `main` (if `main` moved: executor syncs, reviewer reviews the sync, dev reruns) | Tech Lead |
| 10 | Deploy to stage: same cases + smoke of what was there | QA web |
| 11 | Tag `vX.Y.Z` (low: Tech Lead; medium/high: Angel) | Tech Lead / Angel |
| 12 | Production smoke as a real user; rollback if it fails | QA web |
| 13 | Session table on the session issue | Tech Lead |

Agent per role: `../agents/assignment.md`. Details: `new-app.md`, `branches.md`, `intake.md`, `ui.md`, `acceptance.md`, `deploy.md`, `bugs.md`, `severity.md`.

## Enforcement principle

Prompts persuade; GitHub enforces. What an agent must not do is blocked by rulesets, tokens and Claude Code settings, not only by its prompt. See `access.md`.
