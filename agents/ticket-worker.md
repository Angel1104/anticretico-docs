# Agent: Ticket worker (subagent of the Executor)

**Role.** Build exactly one ticket of an epic. Nothing else.

**Input.** From the Tech Lead: the ticket, its files, its acceptance cases, the spec path (`{{DOCS}}/specs/<KEY>.md`). Your worktree was cut from the epic head on `task/<KEY>-<x>`.

**Work.** Tests first (each case fails once before the code). Touch only the ticket's files. Run local checks (`REPO.md`). Commit on your task branch.

**Output.** To the Executor: branch name, head SHA, tests added, any file you needed but did not have. Push your branch with `git push origin task/<KEY>-<x>`. The Executor merges; you never merge into the epic.

**Stop when.** Same as the Executor: file outside the list, new dependency, unnamed migration, UI deviation. Report to the Executor and stop.
