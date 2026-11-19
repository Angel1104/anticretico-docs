# <app>-docs — Agent delivery model (template)

This repository is the single source of truth for how an app is built with AI agents, and for what the app is. It is agent-agnostic: Claude, Codex or Antigravity, per `agents/assignment.md`. A new app starts with `model/new-app.md`.
Copy it as `<app>-docs` for each new app. Agents read this repo; they do not read Jira or Confluence.

| Folder | What lives there |
|---|---|
| `model/` | How we work: flow, branches, intake, UI, acceptance, deploy, bugs, severity, GitHub Project, access, decisions |
| `agents/` | One prompt + access manifest per agent (incl. the `ticket-worker` subagent); `runners/` holds the tool-specific adapters (Orca, Claude Code) |
| `canon/` | What the app is: product, benchmark, MVP, architecture, stack, data, integrations, environments, modules, failure zones, smoke |
| `design/` | Design system and approved screens, exported from Claude Design: the only design source agents read |
| `prompts/` | `/guide`, `/new-app`, `/design-sync`, `/idea`, `/feature`, `/spike`, `/bug`, `/status` as plain text, for any agent |
| `specs/` | One spec per technical epic: `specs/<KEY>.md` |
| `decisions/` | Architecture decisions: `ADR-NNN.md` |
| `scripts/` | `preflight.sh`: read-only check of tools, GitHub permissions and cloud CLIs |
| `templates/` | Spec, read-back, result report, QA report, session table |
| `AGENTS.md`, `CLAUDE.md` | Rules for any agent opened in this repo (help first, roles, language) |
| `code-repo-kit/` | Files to copy into each code repo (`AGENTS.md`, `CLAUDE.md`, `REPO.md`, `.claude/`, `.worktreeinclude`) |
| `.github/` | Issue forms (idea, bug), labels, `intake` and `approvals` workflows |
| `.claude/commands/` | Claude slash-command shortcuts to `prompts/` |

## Not sure what to use?

Open any agent here (Claude, Codex, Antigravity) and write **ayuda**, or `/guide` in Claude. It tells you where the app stands, what to do next and which command and agent to use (`prompts/guide.md`).

## Reading order for agents

1. `README.md` (this file)
2. `model/workflow.md`
3. `agents/assignment.md`, then your own file in `agents/`
4. `model/branches.md`, then the rest of `model/` as needed
5. `canon/` for the app, `specs/<KEY>.md` for the work at hand

## Placeholders

`<app>`, `<KEY>`, `{{...}}` are filled when the template is adopted. See `HANDOFF.md`, phase 0.

`{{DOCS}}` is the absolute path of the `<app>-docs` clone. Agents always reach this repo through it (`--add-dir {{DOCS}}`), never through a relative path: worktrees live in `../wt/`.

## Related (human-facing, Spanish)

- Design doc: https://claude.ai/artifact/Vty6La5q3D4DRFdsquA8eg
- Deck: https://claude.ai/artifact/JgSdLMuJgWffqTr4kow8hL
