# Deploy, smoke and rollback

## Who ships what

Dev and stage do not depend on severity: the Tech Lead always merges and tests. Severity only decides who creates the production tag.

| Tag severity | Epic → `main` (stage) | Production tag |
|---|---|---|
| Low | Tech Lead | Tech Lead, automatic after stage PASS |
| Medium | Tech Lead | Angel, with the session table |
| High | Tech Lead | Angel, with the session table |

Who may create `v*` tags is enforced by a tag ruleset (works on GitHub Team), and which severity each may tag by the tag guard in CI (`severity.md`): a ruleset cannot see severity. GitHub Environments required reviewers are NOT used: on Free, Pro and Team they exist only for public repositories.

Mobile: the production tag submits the build for store review.

## Production smoke

Every production deploy ends with a short walk-through as a real user, no exceptions, whatever the severity. Unit tests and stage QA do not test what was actually published: prod config, secrets, domains, third parties in live mode.

| What | How |
|---|---|
| Path | Critical paths in `canon/smoke.md`: sign in, the app's main action, and what this release touched. A few minutes |
| Who | Two layers: a Playwright script (fast, identical every time) and the QA agent looking as a user, with screenshots |
| Account | One prod test account, no admin, in a test tenant. Never real customer data or real payments |
| Pass | Tech Lead records it in the session table and closes |
| Fail, release has no migration | The Tech Lead rolls back at once (prod deploy workflow with the previous tag); Angel notified |
| Fail, release has a migration | Emergency: `needs:angel`, Angel decides (rolling back may not be safe for data) |
| Mobile | Runs when the store approves and publishes the build |

## Rollback

Redeploy the previous tag through the prod deploy workflow (`workflow_dispatch` with a `tag` input), run by the Tech Lead. Never rewrite history on `main`.

## CI cost

Dev deploys run when the Tech Lead marks an epic ready or a fix lands, not on every push to `epic/*` or `task/*`. Executors run local checks before pushing.

## To fill per app

Deploy platform, environments and URLs go to `canon/environments.md`. Pending decision in `decisions.md`.
