# ADR 001 — Phase 2 design trade-offs (hackathon scope)

Date: 2026-11-19
Status: Accepted (Angel `/ui-approved` 2026-11-19)
Scope: Anticretico MVP, Stellar testnet, hackathon deadline 2026-11-22.

## Context

Phase 2 of `model/new-app.md` produced the Anticretico design system and 8 MVP screens directly in `design/` (path B decided 2026-11-19, no claude.ai artifact round-trip). Three trade-offs surfaced during review that needed Angel's call before Phase 3.

## Decisions

### 1. Catalog filters out of v0

**Decision.** The property catalog (`E1-02-Catalog`) ships **without filters** in the hackathon MVP. Filters by `Ciudad`, `Estado` and `Ticket mínimo` move to a post-pilot epic.

**Why.** The design system does not include a `Select` component. Adding one is a net new component with its own README, variants and accessibility surface, and it adds QA load the hackathon cannot absorb. A grid of 6–12 properties is browsable without filters; the pitch value is the live state and the funding bar, not the filtering UX.

**Follow-up.** Post-pilot epic `ANT-FILTERS` adds `Select` + a chips-row primitive + the three filters. Not blocking any current epic.

### 2. Four visual tones for five lifecycle states

**Decision.** `En fondeo` and `Buscando inquilino` share `color.state-info` (blue). The other three states keep their own tones: `En trámite` gold, `Alquilado` green, `Finalizado` muted.

**Why.** The five states are not equally important. The three tones that *must* be distinct in a glance are:
- `En trámite` (gold) — the brand-defining Derechos Reales moment
- `Alquilado` (green) — the money is flowing
- `Finalizado` (muted) — done, no action

`En fondeo` and `Buscando inquilino` share colour because they always appear in different contexts (fondeo → catalog + property detail before the lien; inquilino → owner panel + admin after release). No screen renders both at the same time, so colour collision is impossible in practice and the label disambiguates.

**Follow-up.** If post-pilot UX research shows users confusing the two in the admin inbox, split into 5 unique tones. Not blocking.

### 3. DeFi protocol pick for owner panel: Blend

**Decision.** The DeFi option on the owner panel deposits into **Blend** on Stellar testnet. Not Soroswap LP.

**Why.** Blend has a simpler lending-pool SDK surface than Soroswap LP (deposit → receive bToken → done, no LP math or impermanent loss modelling), and its testnet has been more stable in the weeks leading up to the hackathon. The feature's value for the pitch is "owner can keep capital productive on-chain", not a specific protocol's yield profile — a single clean integration demonstrates the model.

**Follow-up.** Post-pilot epic may add Soroswap LP as a second option if the SRL's treasury policy allows LP exposure. Not blocking.

## Consequences

- `design/screens/E1-catalog.md` updated to remove filter UI from v0.
- `design/screens/E5-owner.md` updated to reference Blend only.
- `design/system/components/StatePill/README.md` already reflects the shared `state-info` colour; this ADR documents the intent so future edits don't "fix" it silently.
- Phase 3 architecture can lock the Blend SDK as an epic dependency.

## Not revisited unless

- Post-pilot UX shows real user confusion on shared-colour states.
- Blend testnet is down on the morning of 2026-11-22 (the MVP already has a fallback: feature #6 degrades to `Retirar + Reinvertir`, see `canon/mvp.md`).
