# New app: discovery and design before anything else

A new app goes through two gates before any architecture or code. Always on Claude (`agents/assignment.md`), in a conversation with Angel (Claude Code terminal or an Orca worker). Start: `/new-app <idea>` (`prompts/new-app.md`). Phases 0 and 3 are run by the Tech Lead, phases 1 and 2 by the Product agent.

**Every question in this file is asked with a recommendation and its reason.** Angel decides; the agent never picks silently. Nothing is created (repos, Apps, Projects, secrets, cloud resources) without Angel confirming that exact action.

| Phase | The agent does | Output | Gate |
|---|---|---|---|
| 0. Bootstrap | Asks where the app lives (below), runs the preflight, creates `<app>-docs` from this template and its Project after Angel confirms | `<app>-docs` repo + Project; preflight report on the Request issue | **Angel confirms each creation** |
| 1. Discovery | Asks Angel in rounds (below). Researches 3–5 comparable apps. Recommends an MVP | `canon/product.md`, `canon/benchmark.md`, `canon/mvp.md` | **Angel approves the MVP** |
| 2. Design | Design system (`<App>` artifact), screen map and flows, MVP screens (`<App> · Pantallas`), then `/design-sync` | `design/` (contract in `design/README.md`) | **Angel approves the design** |
| 3. Architecture | Tech Lead: asks the technical questions (below) with a recommendation each, runs the preflight for the chosen platform, creates code repos and environments after Angel confirms; MVP features → epics | `canon/stack.md`, `architecture.md`, `environments.md`, `data-model.md`, ADRs, code repos, epics | **Angel approves the stack and confirms each creation** |
| 4. Build | Per epic, `model/workflow.md` | — | The usual gates |

Nothing of phase 3 starts before both gates are passed.

## Preflight (phases 0 and 3, and before every pilot phase)

`scripts/preflight.sh --owner <org-or-user> [--repo <owner/name>]`: read-only check of tools, git identity, `gh` login and token scopes, org role and plan, repo admin, cloud CLIs. The agent posts the result and, for each FAIL or WARN that matters for the decisions taken, says exactly what is missing and who can grant it (e.g. "org owner must approve GitHub App creation"). It then completes the checklist in `model/access.md`. A missing permission is asked for, never worked around.

## Phase 0 questions: where the app lives

| Question | Options | Default recommendation |
|---|---|---|
| Name | `<app>` short, lowercase | Proposed from the idea |
| Owner | Personal account, comocom org, another org | Org if the app is for a client or the company; personal for a private venture |
| Visibility | Private, public | Private (public only for open source; note: on GitHub Free, rulesets on private repos are not available) |
| GitHub plan | Free, Team, Enterprise | Team if private repos need rulesets (`model/access.md`) |
| Git identity | Personal or org email | Must match the owner (personal Gmail for personal repos, comocom email for the org) |

## Phase 3 questions: technology

| Question | Options | Default recommendation |
|---|---|---|
| Platforms | Web, iOS, Android, desktop | From the approved MVP |
| Repos | One code monorepo + `<app>-docs`, or separate repos per component (backend, web, mobile) + `<app>-docs` | Monorepo for a small app or a single team: one epic = one branch and one PR. Separate repos when components ship or scale independently |
| Backend | Language, framework | What the team already runs, unless the MVP needs something else |
| Web / mobile | Framework | React for web; React Native or Flutter if mobile and web share a team |
| Database | Postgres, Firestore, etc. | Postgres unless the data is document-shaped |
| Auth | OTP, OAuth, password | From the MVP; OTP needs fixed test codes for QA |
| Hosting and deploy | Cloud Run, Vercel, Fly, Firebase, etc. | One with a preview environment per branch (one dev per epic) |
| Environments | dev, stage, prod | All three; dev per epic if the platform allows |
| Third parties | Payments, email, maps, etc. | Test mode in dev and stage for each |
| Locales | Languages | From discovery |

Each answer is written to `canon/` and, when it is a real trade-off, to an ADR in `decisions/`. A gate is passed by Angel commenting `/approved` on the app's Request issue (or saying so in the session, recorded by the agent on the issue).

## Discovery rounds

One round at a time, 3–6 questions each, each with the agent's suggested answer and why. Never more than one round in a message.

| Round | Covers |
|---|---|
| 1. Problem | What problem, for whom, how they solve it today, why now |
| 2. Market | Comparable apps (the agent proposes them with what each does well and badly); what to copy, what to avoid, what makes us different |
| 3. Business | How it makes money, pricing model, who pays, unit economics in rough numbers |
| 4. Constraints | Countries and locales, legal (personal data, age, payments, content moderation), platforms (web, iOS, Android) |
| 5. MVP | Smallest set of features that proves the business; what is explicitly out |

The agent challenges: if an answer contradicts an earlier one or the benchmark, it says so. It helps think; Angel decides.

## Design phase

Follows `model/ui.md`, section "Design system", then the MVP screens. Uses only the approved MVP: no screen without a feature behind it.
