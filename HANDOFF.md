# Handoff — agent delivery model, pilot setup

Date: 2026-11-16 · Owner: Angel Flores (Engineering Lead, comocom) · Previous session: Claude (Cowork), design of the model.

## Task

Set up a pilot of this delivery model on a NEW, small, real app (not Shipdrive). Phase 0 = build the rails by hand with Angel. Agents run from phase 1.

## Read in this order

1. `README.md`
2. `model/decisions.md` (locked decisions + open questions)
3. `model/workflow.md`, `model/branches.md`
4. `agents/tech-lead.md`, `agents/executor.md`
5. The rest of `model/` and `agents/` on demand

## Locked decisions (do not reopen without Angel)

- No Jira, no Confluence. GitHub + repos only.
- One docs repo per app (`<app>-docs`): model + canon. Code starters are out of scope.
- Each technical epic is one feature and ships on its own. The Tech Lead may run several in parallel.
- Each epic branches from `main` once at start; its tasks and dev fixes branch from the epic, never from `main`.
- Decisions taken in the review of 2026-11-16 are listed in `model/decisions.md`, "Proposed".
- The Tech Lead merges to `main` without asking, after review + dev QA. Stage repeats the same tests.
- Stage bugs: new branch from `main`. P0 production bugs: hotfix from the current production tag.
- Production = tag `vX.Y.Z` on a `main` SHA where everything merged passed stage. Low severity: Tech Lead tags. Medium/high: Angel tags.
- Smoke test on production after every deploy, as a real user, with a prod test account.
- Angel decides at two points: UI + business approval before building, and the production tag for medium/high. Otherwise only when called (`needs:angel`) or in emergencies.
- Language: conversation in Spanish; everything in repos in English.
- Agent-agnostic (Claude, Codex, Antigravity); Product and Tech Lead always Claude.
- New app: discovery → MVP approved → design in Claude Design → design approved → architecture and build.

## Phase 0 checklist (pilot)

- [ ] Run `scripts/preflight.sh --owner <owner>` and fix what fails.
- [ ] Pick the pilot idea and run `/new-app` with it (phase 0: owner, visibility, plan; phase 3: repos and stack, each with a recommendation): discovery, MVP approval, design system and screens in Claude Design, design approval (`model/new-app.md`). The MVP must give 3–5 small features, two of them parallel and touching shared files (routes, i18n), OTP login, a DB with at least one migration, two locales.
- [x] Where repos live: personal account `Angel1104`, pilot repos public (decisions 19–20). Template: `Angel1104/work-flows` (private).
- [ ] Pilot idea: the dating app is real and already started; this flow will be used there later. Pick the pilot (open).
- [ ] Decide the deploy platform. Prefer one with a preview environment per branch (one dev per epic).
- [ ] Create repos: `<app>-docs` (from this template), `<app>-backend`, `<app>-web`.
- [ ] Create the GitHub Project as in `model/project.md` (issue types, fields, views, labels from `.github/labels.json`).
- [ ] Rulesets: `main` (merge only by Tech Lead identity, required checks, required review by reviewer identity); tags `v*` (Angel + Tech Lead bot).
- [ ] Identities: GitHub Apps (or fine-grained tokens) for Tech Lead, Reviewer and Executor (`model/access.md`).
- [ ] Clone `<app>-docs` and the code repos side by side; replace `{{DOCS}}` everywhere with the absolute path of the docs clone.
- [ ] Copy `code-repo-kit/` into each code repo; fill `REPO.md`; copy its commands into the `allow` list of `.claude/settings.json`.
- [ ] `<app>-docs` secrets/variables: `ANTHROPIC_API_KEY`, `APPROVER_LOGIN`. Create labels from `.github/labels.json`.
- [ ] Fill `canon/architecture.md`, including the shared registry files.
- [ ] Fill `canon/` minimum: product, architecture, stack, environments, smoke.
- [ ] CI per code repo: tests, migration detection, dependency review, severity script and tag guard (`model/severity.md`), deploy dev/stage/prod (`workflow_dispatch` with a ref/tag input, used for dev, P0 stage and rollback), prod smoke.
- [ ] Test accounts with fixed OTP in dev and stage; one prod test account (no admin, test tenant).
- [ ] Playwright set up for QA and smoke.
- [ ] Verify Orca: install, enable orchestration, check how it adopts an existing worktree, how worker permissions behave and how `--add-dir` is passed. If it fails, use `agents/runners/claude-code.md`.
- [ ] Fill `agents/assignment.md` (phase 1: Claude in every role).
- [ ] Verify the platform assumptions in `model/decisions.md`, open #11, #13, #15 (#12 and #14 resolved 2026-11-16) (rulesets and App reviews; Claude Code worktree settings and permission matching; claude-code-action).

## Pilot phases

| Phase | What | Proves |
|---|---|---|
| 0b | `/new-app` discovery + design on the pilot idea | Gates before build work |
| 1 | One epic end to end, Claude in every role | The flow closes |
| 2 | Two epics in parallel that collide on purpose, only in shared registry files (routes, i18n) | Branching, `main` sync and conflict resolution, dev per epic; first mixed vendors (e.g. Codex executor, Claude reviewer) |
| 3 | Planted bug in stage + failing prod smoke | Fix paths and rollback |

Metrics: tokens and time per epic and agent; escalations to Angel; PRs rejected by the reviewer and why; merge conflicts; declared vs recalculated severity; stage bugs not seen in dev; Orca failures.

## Open questions for Angel

See `model/decisions.md`, section "Open".
