# AGENTS.md

This repo is built by AI agents under the delivery model in the `<app>-docs` repo, cloned at `{{DOCS}}` (absolute path). Every session has `{{DOCS}}` available (Claude: `--add-dir`; other agents: as their runner gives it). This file is read by every agent (Claude through `CLAUDE.md`, Codex natively, others per `{{DOCS}}/agents/assignment.md`). Never use a relative path to the docs repo: worktrees live elsewhere. The docs repo wins on process; this file wins on how to work in this code.

## Help
If the user writes "help", "ayuda", "guide", "guía", "qué hago", only greets, or gives no clear task: follow `{{DOCS}}/prompts/guide.md`. Do not guess a task.

## Session start
1. Read `REPO.md`, then `{{DOCS}}/README.md` and your agent file in `{{DOCS}}/agents/`.
2. If you work on an epic, read `{{DOCS}}/specs/<KEY>.md` and `{{DOCS}}/canon/modules.md` before any edit.

## Branches
- Work only on the branch you were given (`epic/*`, `task/*`, `fix/*`, `bug/*`, `hotfix/*`, `spike/*`). Never cut a branch from `main` yourself.
- Push only with `git push origin <your-branch>` (that exact form is allowed; other forms will ask and block a headless run).
- Never merge into `main`, never push to `main`, never create tags or releases, never deploy.

## How to work
- The spec says what; you decide how. "How do I do X" is not a question: decide.
- Reuse before you build: check `canon/modules.md`; add new modules there.
- Tests first: every acceptance case has a test written before the code and shown failing once. A test that cannot fail is a defect.
- Every user-facing text exists in every locale, through the localisation files, never hard-coded. A missing legal text or translation never blocks the build: use a clearly marked provisional value from configuration and list it in the result report.
- Build exactly the approved screens (`{{DOCS}}/design/screens/`) with the tokens and components in `{{DOCS}}/design/`. Deviation or a missing component = stop and report.
- Run local checks (`REPO.md`) before every push.

## Stop and report (comment on the ticket, then wait)
- A file outside the spec's list (shared registry files in `canon/architecture.md` excepted), a new dependency, or a migration the spec does not name
- The spec contradicts the code or the canon
- Anything you lack access to: `[BLOCKED]` comment + label `blocked`. Never look for another way in.

## Done
PR `epic/<KEY>` → `main` with `[RESULT REPORT]` (`{{DOCS}}/templates/result-report.md`).

## Access
You act as the Executor GitHub identity (`GH_TOKEN` set by the runner). You have no access to Angel's email, Outlook, calendar or personal accounts. Secrets: only `.env.dev`.
