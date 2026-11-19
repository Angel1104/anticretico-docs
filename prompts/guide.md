# guide

Triggered by `/guide`, or when the user's message is "help", "ayuda", "guide", "guía", "qué hago", a greeting with no task, or anything without a clear intent. Works the same in any agent. Answer in the user's language. Read-only: change nothing.

## 1. Detect where we are (silently, then report in one line each)

| Check | How |
|---|---|
| Which repo | `<app>-docs` (has `model/` and `agents/`), a code repo (has `AGENTS.md` + `REPO.md`), or neither |
| Which agent you are | Claude, Codex, Antigravity, other; and the role if one was given (`--agent`, Orca preamble) |
| Phase of the app | No `<app>-docs` → before phase 0. `canon/mvp.md` not approved → discovery. `design/` not approved → design. No `canon/stack.md` filled → architecture. Otherwise → build |
| Pending for Angel | `gh issue list --label needs:angel` and `--label blocked` (skip if `gh` is not available) |
| Work in flight | `gh issue list --label intent:now --state open`, open PRs from `epic/*` |

## 2. Recommend the next step first

One sentence: "Te recomiendo: `<command>` porque <reason from the state above>". If something waits for Angel, that goes first.

## 3. Show the menu

| Quiero… | Comando (Claude) | En cualquier agente, escribe | Agente recomendado |
|---|---|---|---|
| Ver dónde estamos y qué sigue | `/guide` | "ayuda" | Cualquiera |
| Empezar una app nueva | `/new-app <idea>` | "sigue prompts/new-app.md con: <idea>" | Claude (siempre) |
| Guardar una idea sin trabajarla | `/idea <texto>` | "sigue prompts/idea.md con: <texto>" | Cualquiera |
| Hacer una feature ahora | `/feature <texto>` | "sigue prompts/feature.md con: <texto>" | Claude (diseño) |
| Probar algo rápido sin tocar main | `/spike <texto>` | "sigue prompts/spike.md con: <texto>" | Claude (Tech Lead) |
| Reportar un bug | `/bug <texto>` | "sigue prompts/bug.md con: <texto>" | Cualquiera |
| Ver el trabajo en curso | `/status` | "sigue prompts/status.md" | Claude (Tech Lead) |
| Traer el diseño de Claude Design al repo | `/design-sync` | — (solo Claude) | Claude |
| Revisar permisos y herramientas | — | "corre scripts/preflight.sh" | Cualquiera |

## 4. How to open each role

| Role | Claude Code terminal | Orca |
|---|---|---|
| Tech Lead | `claude --agent tech-lead` in `<app>-docs` | Claude worker in `<app>-docs` |
| Product | `claude --agent product` in `<app>-docs` | Claude worker in `<app>-docs` |
| Executor, Reviewer, QA | Launched by the Tech Lead, not by hand | Launched by the Tech Lead with the agent in `agents/assignment.md` |

Plain `claude` / `codex` / Antigravity without a role = a normal assistant that follows the repo rules; use it for questions, not for delivery work.

## 5. Approvals Angel gives (on the GitHub issue, also from the phone)

| Comment | Means |
|---|---|
| `/approved` | A gate of a new app (MVP, design, design system) |
| `/ui-approved` | A feature's design approved and its business questions answered |
| Production tag `vX.Y.Z` | Release of medium/high severity |

End with: "¿Qué quieres hacer?" Keep the whole answer under one screen; omit sections 4–5 if the user only asked what to do next.
