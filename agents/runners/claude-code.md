# Runner adapter: Claude Code (headless)

Status: plan B, stable, no third party.

A headless run (`claude -p`) cannot answer permission prompts: every command an agent needs must be in the `allow` list of the repo's `.claude/settings.json`, in the exact form the agent uses.

Verified 2026-11-16 (Claude Code 2.1.128, local sandbox):

| Fact | Consequence |
|---|---|
| `Edit` and `Write` must be in `allow` for a headless run to write files | In the code repo kit settings |
| `cd <dir> && git ...` always asks (git hooks safety) | Always `git -C <repo> ...` |
| `--add-dir` takes several paths and swallows a prompt placed after it | Send the prompt on stdin |
| A subagent with `isolation: worktree` branches from the main checkout, not the epic; `worktree.baseRef` does not change it | Not used: the Tech Lead cuts task worktrees explicitly |
| `Bash(git worktree:*)` lets an agent remove worktrees | Executors only get `git worktree list`; `remove` and `prune` are denied |
| Prefix rules like `Bash(git push origin epic/:*)` match `git push origin epic/KEY` | Push rules work as written |

| Action | How |
|---|---|
| Cut the epic worktree (per repo) | `git -C <repo> fetch origin` · `git -C <repo> worktree add -b epic/<KEY> <wt>/<repo>-<KEY> origin/main` · `git -C <wt>/<repo>-<KEY> push origin epic/<KEY>` |
| Cut a task worktree (parallel tickets only) | `git -C <repo> worktree add -b task/<KEY>-<x> <wt>/<repo>-<KEY>-<x> epic/<KEY>` |
| Launch an executor | `cd <wt>/<repo>-<KEY> && claude -p --agent executor --model <sonnet\|opus> --add-dir {{DOCS}} [<wt>/<other-repo>-<KEY>] < <prompt file>` (prompt on stdin; `GH_TOKEN` set in the session environment, not inline) |
| Launch a ticket worker (parallel tickets only) | Same, in `<wt>/<repo>-<KEY>-<x>` with `--agent ticket-worker` |
| Executor asks the Tech Lead | Comment `[QUESTION]` on the ticket; the Tech Lead reads it with `gh issue view` |
| Executor signals done | `[RESULT REPORT]` comment on the PR; process exits |
| Human gate | Label `needs:angel` on the issue; the Tech Lead waits for Angel's comment |
| Tickets | Sequential in the epic worktree by default; parallel only through task worktrees cut by the Tech Lead |

Notes:
- Worktrees are named `<repo>-<KEY>` (`<repo>-<KEY>-<x>` for tasks) because all code repos share `<wt>`.
- The Tech Lead removes worktrees after merge with `git -C <repo> worktree remove <path>`.
- `claude -p` runs leave their worktrees; clean them with `git worktree remove` after merge.
