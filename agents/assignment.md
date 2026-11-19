# Agent assignment: role → agent → model

The model is agent-agnostic: any role below can run on Claude, Codex (OpenAI) or Antigravity (Google) unless marked fixed. Change a row, not the prompts. Prompts in `agents/` never name a vendor.

| Role | Agent | Model | Effort | Fixed? |
|---|---|---|---|---|
| Product (discovery, design, briefs) | claude | {{opus}} | high | **Yes: always Claude** (Angel, 2026-11-16) |
| Tech Lead | claude | {{opus}} | high | **Yes: always Claude** |
| Executor, low severity | {{claude / codex / antigravity}} | {{...}} | medium | No |
| Executor, medium/high severity | {{claude / codex / antigravity}} | {{...}} | high | No |
| Ticket worker | Same as its executor | — | — | — |
| Reviewer | {{a different vendor than the executor}} | {{...}} | high | No |
| QA web | {{claude / codex / antigravity}} | {{...}} | medium | No |

Rules:
- The Reviewer runs on a different vendor than the Executor of the PR when possible: an independent second opinion.
- Non-Claude agents run through the Orca runner (`agents/runners/orca.md`); the Claude Code runner runs Claude only.
- Pilot phase 1: Claude in every role. Mixed vendors from phase 2.

## What each agent reads

| Agent | Repo rules | Agent role file | Permissions |
|---|---|---|---|
| Claude | `CLAUDE.md` (imports `AGENTS.md`) | `.claude/agents/<role>.md` → `agents/<role>.md` | `.claude/settings.json` |
| Codex | `AGENTS.md` (native) | Prompt from the runner: "Read `/Users/angel/Ventures/anticretico-docs/agents/<role>.md`" | Codex config / sandbox ({{verify}}) |
| Antigravity | {{verify which file it reads}} | Prompt from the runner | {{verify}} |

In every case the real guard is GitHub (identities and rulesets, `model/access.md`), so it does not depend on the agent.
