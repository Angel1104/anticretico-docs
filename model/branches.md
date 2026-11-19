# Branches and environments

Each epic takes its own snapshot of `main` when it starts. Nothing inside the epic branches from `main` again, so code that others merge meanwhile does not leak in.

```
main (SHA X) ─► epic/<KEY-1>              cut by the Tech Lead in each repo the epic touches → its dev
                  ├─ task/<KEY-1>-a        from epic/<KEY-1>; ticket-worker sub-worktree
                  ├─ task/<KEY-1>-b
                  └─ fix/<KEY-1>-dev-n     dev bugs, from the epic
main (SHA Y) ─► epic/<KEY-2> ...           another epic in parallel, its own snapshot
main ◄─ epic/<KEY-1>                       Tech Lead merge after dev passes → stage
  ├─ fix/<KEY-1>-stage-n                   stage bugs, from main
  ├─ bug/<issue>                           production bugs P1–P3, from main
  └─ spike/<issue>                         experiments, from main, never merged
vX.Y.Z (prod tag) ─► hotfix/<issue>        P0 production bugs, from the live tag
main @ SHA verified on stage → tag vX.Y.Z  production
design/<issue> (<app>-docs)                Product agent design export, merged by the Tech Lead after /ui-approved
```

| Prefix | From | Cut by | Built by | Merges into |
|---|---|---|---|---|
| `epic/<KEY>` | `main` | Tech Lead | Executor | `main` |
| `task/<KEY>-<x>` | epic head | Tech Lead (parallel tickets only) | Ticket worker | epic, by the Executor |
| `fix/<KEY>-dev-<n>` | epic | Tech Lead | Executor | epic |
| `fix/<KEY>-stage-<n>` | `main` | Tech Lead | Executor | `main` |
| `bug/<issue>` | `main` | Tech Lead | Executor | `main` |
| `hotfix/<issue>` | current production tag | Tech Lead | Executor | tagged, then `main` |
| `spike/<issue>` | `main` | Tech Lead | Executor | never |
| `design/<issue>` | `main` (`<app>-docs`) | Product | Product | docs `main`, by the Tech Lead after approval |

## Rules

1. The Tech Lead cuts every branch above except `task/*` and `design/*` itself, in its own worktree `../wt/<repo>-<KEY>` (command in the runner adapter), and launches the executor inside it. It controls the exact base SHA.
2. An epic that touches several repos gets `epic/<KEY>` in each. One executor builds it, launched in the primary worktree with `--add-dir` to the others. One PR per repo; the Tech Lead merges them together, backend first.
3. Tickets are built in sequence in the epic worktree. Tickets the spec marks as parallel get a `task/*` worktree cut by the Tech Lead from the epic head (`git -C <repo> worktree add -b task/<KEY>-<x> <path> epic/<KEY>`), never from `main`. Agents never create or remove worktrees except the Tech Lead.
4. Tasks merge into the epic. The epic merges into `main` with a merge commit (no squash), so it can be reverted as a unit.
5. Before merging: if `main` moved since the snapshot, the executor merges `main` into the epic once and resolves conflicts; the reviewer reviews the sync (the ruleset dismisses stale approvals); dev is redeployed and the suite rerun.
6. Epics that touch the same files never run in parallel. Exception: shared registry files listed in `canon/architecture.md` (routes, i18n catalogues, module index…). Parallel epics may add entries to them; rule 5 resolves those conflicts by keeping both sides.
7. Only the Tech Lead identity merges to `main`, through the PR. Nobody pushes directly.
8. One tag ships everything in `main` up to its SHA. Tag only a SHA where every merged epic passed stage. If epic B merged after A and has not passed stage, tag the SHA before B.
9. Severity of a tag = highest severity among epics included since the previous tag.

## Environments

| Env | Deployed when | From |
|---|---|---|
| dev | The Tech Lead marks an epic ready, or a dev fix lands | `epic/<KEY>` (one preview per epic; if only one dev exists, a queue ordered by the Tech Lead) |
| stage | An epic or fix merges to `main`; during a P0, the hotfix branch until it is merged | `main` (or `hotfix/<issue>`) |
| prod | Tag `vX.Y.Z` | tag |

## Session table (posted by the Tech Lead at close)

See `templates/session-table.md`.
