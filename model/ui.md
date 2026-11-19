# UI and design

Tool: Claude **Design System** artifacts on claude.ai, two per app: `<App>` (system) and `<App> · Pantallas` (screens), the pattern Shipdrive already uses. The source of truth for agents is not the tool but its copy in the repo, `design/`, pulled with `/design-sync` (contract in `design/README.md`). Any agent (Claude, Codex, Antigravity) builds from `design/`; none needs Claude Design to build.

## Design system: required before any UI work

| Situation | What happens |
|---|---|
| New app | Created in the design phase of `model/new-app.md` |
| Existing app with no `design/` or a messy one | One-time **consolidation** before the next UI feature: the Product agent starts from the Design System artifacts that already exist (for Shipdrive: `Shipdrive`, `Shipdrive · Pantallas`, `Shipdrive Corporate Identity`), fills them from the code (the type supports building from a codebase) and other sources, lists gaps and asks Angel for each missing piece, then `/design-sync`. Angel approves with `/approved` |
| Existing app with `design/` | Use it. New components or tokens are proposed in the feature's design and added to `design/` on approval |

## Feature with UI

| Step | What happens |
|---|---|
| 1 | The Product agent writes the brief and numbered business questions on the Request issue |
| 2 | It designs the screens as cards `E<epic>-<nn>-<name>` in `<App> · Pantallas`, using only the system's components, runs `/design-sync` on branch `design/<issue>` in `<app>-docs`, and posts the artifact link and the list of screens on the issue |
| 3 | Angel answers the questions and comments `/ui-approved` (= design approved and business answered). The workflow adds `ui:approved` and removes `needs:angel` |
| 4 | The Tech Lead checks every question has an answer, merges `design/<issue>` into the docs `main`, and links the screens in `specs/<KEY>.md` |
| 5 | Those screens are the reference: QA compares against them; a departure returns to Angel |

If the design changes after approval, the Product agent removes `ui:approved` and asks again.

A feature without UI skips steps 2–5.

Executors build exactly the approved screens with the design system's tokens and components. A deviation, or a component that does not exist in `design/system/components/`, is a stop-and-report, not a decision.
