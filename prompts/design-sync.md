# design-sync

Claude only (needs the Artifact tool). Pull the app's two Design System artifacts into `design/`.

1. Read `design/links.md` for the two URLs.
2. `list` with `scope: "files"` on each; `read` with `paths` every file under `project/` (not `artifact-type/`, `index.html`, `SKILL.md`, generated `api/` cards).
3. Copy them into `design/system/` and `design/screens/`, keeping the paths below `project/`.
4. Update `design/links.md` with the version ids and today's date.
5. Commit on `design/<issue>` (or `design/sync-<date>`) and report the diff in one table: files added, changed, removed.

Never edit the files in `design/` by hand: change the artifact, then sync.
