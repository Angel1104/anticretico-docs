# GitHub Project

One organisation Project per app ("<App> Delivery"), with the app's repos linked: `<app>-docs`, backend, web, mobile. Up to 50,000 items per project.

## Issues

Organisation issue types: Request, Epic, Task, Bug, Session. Tasks and bugs of an epic are its sub-issues.

| Issue | Lives in |
|---|---|
| Request (business need, approved UI) | `<app>-docs` |
| Epic (one feature) | `<app>-docs`, linked to its request |
| Task (one per subagent) | Code repo where the change goes, sub-issue of the epic |
| Bug | Sub-issue of the epic (dev/stage) or standalone (prod) |
| Session (Tech Lead run) | `<app>-docs`; lists its epics and holds the session table |

The issue only holds state and conversation. The "what" lives in `specs/<KEY>.md`.

## Fields

| Field | Values | Set by |
|---|---|---|
| Status | Inbox → Triage → Needs Angel → Ready → In progress → In review → Dev QA → Stage QA → Ready for prod → Done | Tech Lead and workflows |
| Severity | Low / Medium / High | Tech Lead (and the diff script) |
| Priority | P0 / P1 / P2 / P3 | Tech Lead; Angel may override |
| Intent | Backlog / Now / Spike / Bug | Whoever creates the issue |
| Found in | Dev / Stage / Prod-smoke / User | QA or reporter (bugs only) |
| Release | Tag that shipped it (`v1.4.0`) | Tech Lead when tagging |
| Parent | The epic (native sub-issue field) | Automatic |

## Views

| View | Shows |
|---|---|
| Board | Board by Status: day to day |
| Needs Angel | Only `needs:angel`: the one view Angel must check |
| Bugs | Table of type Bug grouped by Priority |
| In flight | Table grouped by epic, with tasks and bugs |
| Releases | Table grouped by Release |
| Ideas | Intent = Backlog, status Inbox |

## Labels

See `.github/labels.json`: `intent:*`, `needs:angel`, `blocked`, `sev:*`, `bug:dev`, `bug:stage`, `bug:prod`, `ui:approved`, `product:started`, `accepted`.

Labels are the source of truth wherever a label and a field say the same thing (`sev:*` ↔ Severity, `needs:angel` ↔ Status "Needs Angel", `intent:*` ↔ Intent): workflows and scripts read labels. The Tech Lead mirrors them into the fields.

## Automation

Built-in workflows move closed items to Done and auto-add new issues from each repo. Auto-add limits: 1 workflow on Free, 5 on Pro or Team, one repository per workflow; it does not add existing items. On Free, the Tech Lead adds items with `gh project item-add`.

Labels added by a workflow with `GITHUB_TOKEN` do not trigger other workflows. A workflow that must react to such a label (e.g. `ui:approved`) needs an App token, or the reaction goes in the same workflow (as `intake` does).

## Why issues and not backlog files

The Tech Lead starts every session with no memory. With `gh issue list` and `gh project item-list` it rebuilds the full state in seconds without reading long documents.
