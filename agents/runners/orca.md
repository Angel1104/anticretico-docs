# Runner adapter: Orca

Status: recommended for mixed vendors (Claude, Codex, Antigravity). Checked against Orca 1.4.239. Commands not yet run in this flow.

- CLI: `/Applications/Orca.app/Contents/Resources/bin/orca` (not on `PATH` by default; add it, or use the full path). Below: `orca`.
- Before a session, load the version-matched guide: `orca skills get orchestration` (and `--reference references/<file>.md` when it says so). It wins over this file.
- Worktrees (always `git -C`, never `cd && git`), `--add-dir {{DOCS}}`, `GH_TOKEN` per identity and the allow lists work as in `claude-code.md`, including its verified facts.
- The coordinator is the Tech Lead (always Claude). Workers take their agent and model from `agents/assignment.md`.

| Action | Command |
|---|---|
| Check runtime, open a Run | `orca status --json` · `orca orchestration run-create --objective "<session>" --json` |
| Planned tasks with dependencies | `orca orchestration task-create --spec "<self-contained spec>" --task-title "<KEY>" [--deps '["<task_id>"]'] --json` |
| Launch an executor in the epic worktree the Tech Lead cut | `orca orchestration worker-start --task <task_id> --worktree branch:epic/<KEY> --agent <claude\|codex\|antigravity> --model <id> --effort <level> --json` (`path:../wt/<repo>-<KEY>` also works) |
| Let Orca create the epic worktree instead | `orca orchestration worker-start --task <task_id> --worktree new-top-level --repo <selector> --base-branch origin/main --name <repo>-<KEY> --agent ... --json` |
| Ticket worker (parallel tickets only, any agent) | The Tech Lead cuts the task worktree with `git -C` (as in `claude-code.md`), then `worker-start --task <task_id> --worktree path:<task worktree> --agent <id> --json`. `new-child` is not used: its base was not verified |
| Worker asks the Tech Lead | The `ask` command in the worker's injected preamble (blocking) |
| Worker signals done | `worker_done` from the preamble, once, with `--outcome succeeded\|failed` |
| Tech Lead waits | `orca orchestration check --wait --types "worker_done,escalation,question" --timeout-ms 900000 --json` · answer with `reply --id <message_id>` · then `check --ack <delivery_id> ...` |
| Human gate | Decision gates (`references/messaging-and-gates.md`); `needs:angel` on the issue stays the visible signal |
| Release a settled worker | `orca orchestration worker-release --dispatch <dispatch_id> --json` |
| Remote host (Mac off) | `worker-start --on <saved-environment>`; see `references/placement-and-remote.md` |

Task specs must name: target, change, constraints, ownership, observable acceptance (Orca's task-spec contract). Build them from `specs/<KEY>.md`.

Rules from the guide that matter here:
- If `worker-start` exits non-zero, do not relaunch: read `failedStage` and load `references/recovery-and-cleanup.md`.
- An empty or timed-out wait is a checkpoint, not a failure. Never stop, retry or release without proof.
- Workers of non-Claude agents read `AGENTS.md` in the code repo and their role file through the spec; `.claude/` does not apply to them.

To verify in the pilot: worker permission prompts per agent; `--model` ids for Codex and Antigravity; nesting depth with Tech Lead → executor → ticket worker.
