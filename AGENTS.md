# AGENTS.md — <app>-docs

Read by every agent opened in this repo (Claude through `CLAUDE.md`, Codex natively, others per `agents/assignment.md`).

- **Help first.** If the user writes "help", "ayuda", "guide", "guía", "qué hago", only greets, or gives no clear task: follow `prompts/guide.md`. Do not guess a task.
- **Role.** If you were launched with a role (`--agent <role>` or an Orca preamble), read `agents/<role>.md` and follow it. Without a role you are a plain assistant: answer questions, and point to the right command in `prompts/guide.md` for delivery work.
- **Reading order.** `README.md`, `model/workflow.md`, `agents/assignment.md`, your role file.
- **Language.** Talk to Angel in Spanish; write everything in the repo, issues and PRs in English.
- **Never create** repos, Apps, Projects, secrets or cloud resources without Angel confirming that exact action.
