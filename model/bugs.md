# Bugs

A bug follows the same path as an epic (branch, review, dev, `main`, stage, tag, smoke). What changes is where the branch comes from, which depends on where it was found. The Tech Lead cuts the branch; an executor builds the fix.

| Found in | Issue | Branch | Path |
|---|---|---|---|
| Dev, during an epic | Sub-issue of the epic, `bug:dev` | `fix/<KEY>-dev-n` from the epic | Executor fixes, QA reruns what failed. The epic does not merge until it passes |
| Stage | Sub-issue of the epic, `bug:stage` | `fix/<KEY>-stage-n` from `main` | PR to `main` with review, redeploy stage, rerun what failed + smoke. Blocks the tag that would include the epic |
| Production smoke | Standalone bug, `bug:prod`, P0 or P1 | Rollback first; then as a user bug | Automatic rollback unless a migration is involved (then Angel decides) |
| A user, Carlos or Angel, in prod | Standalone bug (`/bug` or form) | `bug/<issue>` from `main`, or `hotfix/<issue>` if P0 | By priority, below |

## Priority of a production bug

Set by the Tech Lead; Angel may change it.

| Priority | When | What happens |
|---|---|---|
| P0 | App down, data loss, a payment or login fails | Hotfix from the CURRENT PRODUCTION TAG, not from `main` (`main` may hold work that has not passed stage). The Tech Lead deploys `hotfix/<issue>` to stage (stage QA of other work pauses), QA reruns the failing case + smoke, Angel tags the hotfix SHA (`vX.Y.Z+1` patch), prod smoke, then the fix merges into `main` by PR and stage returns to `main`. Angel is notified when it opens |
| P1 | A main path breaks with no workaround | Goes in now, ahead of epics, normal path |
| P2 | A workaround exists | Ordered backlog; ships with the next work in that area |
| P3 | Cosmetic | Backlog |

## Rules for every bug

- The fix starts with a test that reproduces the bug and fails. That test stays forever.
- A bug that escaped dev or stage is added to `canon/failure-zones.md`, and to `canon/smoke.md` if it touches a critical path.
- If the app does what the spec says but the spec is wrong, it is not a bug: the Tech Lead turns it into a Request and it goes back to the Product agent, with UI approval.
- A bug report has: what happened, what was expected, steps, environment, version or tag, screenshot. If something is missing, the Tech Lead asks before opening a branch.
- The session table lists bugs with where they were found and how they were fixed.
