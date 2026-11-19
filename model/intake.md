# Intake: how work enters

One door, same in the terminal (any agent) and on the phone: state the intent in one word. Each command is a plain-text prompt in `prompts/`, usable by any agent; Claude also has them as slash commands. If intent is missing, the agent asks "backlog, now or spike?" and never guesses.

| Command | What happens | Reaches prod |
|---|---|---|
| `/new-app <idea>` | A new app: discovery, MVP and design, each approved by Angel, before any architecture (`new-app.md`) | After both gates |
| `/idea <text>` | Request issue in the Project (Inbox, `intent:backlog`). Nobody works on it yet | Not until promoted |
| `/feature <text>` | Request issue with `intent:now`. The `intake` Action posts the brief and business questions; if there is UI, the design follows in a Claude session (`ui.md`) | Yes, normal flow |
| `/spike <text>` | Request with `intent:spike`; the Tech Lead cuts `spike/<issue>` from `main` and an executor runs the smallest experiment, then reports | Never merges to `main` |
| `/bug <text>` | Straight to the Tech Lead. If it changes something visible, UI approval is requested | Yes |
| `/status` | Tech Lead returns the table of work in flight | — |
| `/guide` or "ayuda" | Where the app stands, the recommended next step, the menu (`prompts/guide.md`) | — |

Promoting a backlog idea = adding the label `intent:now` (removing `intent:backlog`).

## Which agent opens

Tech Lead and Product always run on Claude: `claude --agent tech-lead` / `claude --agent product` from the `<app>-docs` clone, or an Orca worker with `--agent claude`. The `intake` Action runs the Product agent in "brief only" mode. A plain `claude` is not an agent: it is Claude Code with the repo rules.

## From the phone

Issue forms in `<app>-docs` (`.github/ISSUE_TEMPLATE/`), used from the GitHub mobile app. Issue forms cannot set labels from a dropdown, so the `intake` workflow reads the "What do we do?" answer and adds the matching `intent:*` label. Whenever a request has `intent:now` (from the form, `/feature` or a promotion), the same workflow runs the Product agent once in "brief only" mode (guarded by the label `product:started`), so it works with the Mac off. Claude Design is not available there: the design is done in a Claude session and its screens come back on the same issue; Angel approves with `/ui-approved` from the phone.

## Product brief (before any UI)

The Product agent challenges the idea first:

1. Problem and who has it
2. What is lost if we do not build it
3. The cheapest alternative (sometimes no feature is needed)
4. Estimated size and severity
5. Risks and collisions with existing modules
6. Recommendation: now, backlog or discard, with the reason

It helps think; Angel decides. Its quality depends on `canon/product.md`.
