# design/ — contract between design and build

The design lives in two Claude **Design System** artifacts per app (claude.ai). Both are file-based, so the Product agent (Claude) pulls their files into this folder with the Artifact tool (`read` with `paths`; verified 2026-11-16 on the Shipdrive system). Agents that build read only this folder; the artifact links are for humans.

| Artifact | Holds | Mirrored to |
|---|---|---|
| `<App>` (design system) | Tokens, brand book, components with guidelines, live previews, React bundle and types | `design/system/` |
| `<App> · Pantallas` (screens) | One card per screen, named `E<epic>-<nn>-<Screen-name>`, built with the system's components; one `.md` per epic | `design/screens/` |

Pattern taken from Shipdrive, which already works this way (`Shipdrive` + `Shipdrive · Pantallas`).

## Files (paths inside each artifact's `project/`)

| File | Holds | Rule for builders |
|---|---|---|
| `tokens.json` | Colors (per theme), typography, spacing, radius, shadow; each token with a usage note | Code uses tokens, never raw values. List format (not DTCG): convert per stack (CSS variables, Flutter theme…) with a script, never by hand |
| `README.md` | Brand book: principles, voice, rules | Read first |
| `components/<Name>/README.md` | Guidelines: when to use, variants, sizes, what the caller provides, what not to do | A component not listed here does not exist: stop and report |
| `components/<Name>/preview.html` | Live preview (React + bundle) | Visual reference |
| `components/bundle.js`, `bundle.css`, `index.d.ts` | Reference implementation and its types | Reference for web; other stacks rebuild from README + tokens |
| `design-system.json` | Index: title, namespace, last change | Not edited by hand |
| Screens: `components/E<epic>-<nn>-<name>/` | One approved screen (README + preview) | The approved reference for QA |

## links.md

| Artifact | URL | Version pulled | Pulled at |
|---|---|---|---|
| `<App>` | {{https://claude.ai/artifact/...}} | {{version id from the read}} | {{YYYY-MM-DD}} |
| `<App> · Pantallas` | {{...}} | {{...}} | {{...}} |

The version id comes from the `read` result. A pull is a normal commit on a `design/<issue>` branch: the diff shows exactly what changed in the design.
