# Decisions

## Locked (Angel, 2026-11-16)

| # | Decision |
|---|---|
| 1 | No Jira, no Confluence. GitHub and repos only |
| 2 | General model, reusable for any app |
| 3 | One docs repo per app: model + canon. Code starters are separate and out of scope |
| 4 | Angel approves UI and business before building |
| 5 | Each technical epic is one feature and ships on its own; the Tech Lead may run several in parallel |
| 6 | Each epic snapshots `main` at start; its tasks and fixes never branch from `main` |
| 7 | Epics are tested on dev; the Tech Lead merges to `main` without asking and repeats the tests on stage |
| 8 | Stage bugs: new branch from `main` |
| 9 | Production ships from a tag on what passed stage |
| 10 | Production smoke after every deploy, as a real user |
| 11 | Before shipping: migrations, dependencies and UI QA with screenshots |
| 12 | Pilot on a new app (sandbox), not Shipdrive |
| 13 | Agent-agnostic: any role can run on Claude, Codex (OpenAI) or Antigravity (Google); assignment in `agents/assignment.md`, never in prompts |
| 14 | Product and Tech Lead (discovery, design, hard decisions) always run on Claude |
| 15 | New app: discovery (questions, benchmark, MVP) → Angel approves → design (design system, screens, components) → Angel approves → only then architecture and build (`new-app.md`) |
| 16 | Design tool: Claude Design System artifacts, two per app (`<App>`, `<App> · Pantallas`), pulled into `design/` with `/design-sync` (free with the Claude plan; Figma is not used because it costs) |
| 17 | Existing app: the design system must exist before any UI feature; if it is messy, it is consolidated from what exists and gaps are asked from Angel (`ui.md`) |
| 18 | New app: before creating anything, the agent asks owner, visibility, plan, repos (mono or separate) and stack, always with a recommendation; runs a permissions preflight; creates nothing without confirmation |
| 19 | This template lives in the private repo `Angel1104/work-flows` (template repository), personal account, not comocom |
| 20 | Pilot repos: personal account (never comocom), public, so rulesets work without a paid plan |

## Proposed (accepted in discussion, revisit after the pilot)

- Backlog and tickets in GitHub Issues + Projects (`project.md`)
- Five agents; Opus for Product, Tech Lead, Reviewer and medium/high executors; Sonnet for low executors and QA; Haiku for release notes and triage
- Orca as runner, Claude Code headless as plan B; Grok Bot evaluated and not used for now
- Design exported from Claude Design to `design/` (`design/README.md`), the only design source agents read; approval via `/ui-approved` (features) and `/approved` (gates)
- P0–P3 bug priorities; P0 hotfix from the production tag
- Agents run with an absolute docs path `/Users/angel/Ventures/anticretico-docs` and `--add-dir`, never `../<app>-docs` (worktrees live in `../wt/`)
- The Tech Lead runs from the `<app>-docs` clone; the code repo settings serve executors only
- GitHub Apps: Tech Lead, Reviewer, Executor, and Product (or the Executor App limited to `design/*` in `<app>-docs`)
- An epic that spans repos has `epic/<KEY>` in each, one executor, one PR per repo, merged together
- Executors (not the Tech Lead) resolve merge conflicts when `main` is synced into an epic; the reviewer reviews the sync
- Shared registry files (routes, i18n, module index; listed in `canon/architecture.md`) may be touched by parallel epics. Pilot phase 2 tests exactly this. Any other shared file still forces sequence
- `/ui-approved` means UI approved **and** business questions answered; the Tech Lead verifies the answers before the spec
- Tag guard in CI: deploy fails if a medium/high tag was not created by Angel (a ruleset cannot see severity)
- The `intake` Action runs Product in "brief only" mode (no Claude Design in Actions); design happens in a Claude session
- `AGENTS.md` holds the code repo rules for every agent; `CLAUDE.md` only imports it. Commands live as plain-text prompts in `prompts/`
- Reviewer on a different vendor than the executor when possible
- Tickets run in sequence in the epic worktree; parallel tickets only through `task/*` worktrees cut by the Tech Lead (subagent `isolation: worktree` branches from `main`, verified)

## Open

| # | Question | Why it matters | Decides |
|---|---|---|---|
| 1 | Deploy platform for a new app, and permissions there | Dev per epic vs queue; `deploy.md` | Angel |
| 2 | ~~GitHub plan and org admin~~ Resolved: personal account, public pilot repos (decision 20) | — | — |
| 3 | Tech Lead, Reviewer and Executor identities (GitHub Apps or tokens) | Needed to enforce "reviewer ≠ author" and "only Tech Lead merges" | Angel |
| 4 | Business acceptance after release? | If before, a human step precedes the tag | Angel |
| 5 | QA login: fixed OTP in dev/stage, or a readable test inbox | No automated QA without it | Angel + backend |
| 6 | Payments in prod smoke: skip, or a minimal charge voided at once | Smoke cannot test payments without charging | Angel |
| 7 | Orca worker permissions per agent (Claude, Codex, Antigravity). Existing worktree adoption is solved: `--worktree branch:<b>` / `path:<p>` (Orca 1.4.239) | May force the Claude Code runner for some roles | Pilot |
| 8 | The Mac as the only Tech Lead host | If it sleeps, everything stops. Orca supports remote servers (`worker-start --on <server>`) | Pilot |
| 9 | Is Sonnet enough for low-severity executors | Cost vs rework | Pilot |
| 10 | Adopting in Shipdrive | Contradicts rules ratified there (Gate 1, human merges, doctrine in Confluence) | Angel + Carlos |
| 11 | Ruleset "restrict updates" with bypass only for the Tech Lead App, and whether a GitHub App's approval counts as the required review | The two main enforcement rules depend on it | Phase 0 |
| 12 | ~~Claude Code worktree and permission behaviour~~ **Resolved 2026-11-16** in a local sandbox: see the verified facts in `agents/runners/claude-code.md` | — | — |
| 13 | `anthropics/claude-code-action@v1` inputs | Product brief from the phone | Phase 0 |
| 14 | ~~Export from Claude Design~~ **Resolved 2026-11-16**: Design System artifacts are file-based; `read` with `paths` saved tokens, component READMEs, previews, bundle and types locally (Shipdrive system). Remaining: render each screen `preview.html` to PNG with Playwright for QA evidence | QA visual reference | Phase 0 |
| 15 | Which rules file Antigravity reads (`AGENTS.md`?) and how Codex/Antigravity permissions are configured | Agent-agnostic executors | Phase 0 |
| 16 | Free alternatives if Claude Design falls short: Penpot (open source), Google Stitch (free, has MCP), Pencil | Not needed now (14 resolved) | Angel |
