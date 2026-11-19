# MVP

Status: draft — proposed 2026-11-19, awaiting Angel's `/approved`

Hackathon deadline: **2026-11-22** (3 days). Everything below runs on Stellar testnet.

## Functional (must ship, pitch demos it end-to-end)

| # | Feature | Why it is in the MVP | Size | Becomes epic |
|---|---|---|---|---|
| 1 | Property catalog with live state (`En fondeo → En trámite → Buscando inquilino → Alquilado → Finalizado`) and a per-property funding progress bar | Without a catalog there is nothing to invest in; the live state is the whole transparency pitch and the hook for the pilot | M | ANT-CATALOG |
| 2 | Wallet connect + USDC deposit into a Trustless Work escrow for a specific property | This is the "investor buys a fraction" moment — the business does not exist without it. Deposit must land in escrow, not on the SRL wallet, so the legal protection story works | M | ANT-INVEST |
| 3 | Admin panel: validate the "Inscrito en Derechos Reales" milestone and release escrow to the owner | This is the only moment where legal protection and on-chain state meet; the demo pivots on it | M | ANT-ADMIN |
| 4 | Monthly distribution button via Pollar to investor wallets | Proves the "small saver gets rent on-chain" loop; without a visible distribution the pitch is theoretical | M | ANT-DISTRIB |
| 5 | Stellar explorer link per transaction (deposit, release, distribution) | The transparency differentiator over Arrived/RealT/Lofty; cheap to implement, huge pitch value | S | ANT-EXPLORER |

## Visual-only (pitch assets, no backend)

| # | Feature | Why it is in the MVP | Size | Becomes epic |
|---|---|---|---|---|
| 6 | Owner panel mock: withdraw as cash, deploy to DeFi, or mixed — each with its risk disclosure copy | Shows the business model expansion to investors/judges without building rails for it | S | ANT-OWNER-MOCK |
| 7 | Rollover mock: at `Finalizado`, propose rolling the capital into another anticrético | Shows the LTV story and that we understand lifecycle; costs nothing | S | ANT-ROLLOVER-MOCK |

## Explicitly out

| Feature | Why not now |
|---|---|
| Secondary market for economic tokens | Needs liquidity, ASFI sandbox sign-off, and likely a different legal wrapper; out of hackathon scope |
| Mobile app (iOS/Android) | Web covers investors and admin for the pilot; mobile requires separate QA, review and store overhead we cannot afford in 3 days |
| Automatic KYC (third-party provider) | UIF RA 019/2025 compliance is satisfied by **manual** admin KYC for the pilot; a provider needs contracts, invoicing and legal review the hackathon cannot absorb |
| Fiat on-ramp from BOB to USDC | Users bring USDC. Fiat on-ramps require partnering with a VASP and formal BCB posture — out of pilot scope |
| Mainnet | Stellar testnet is enough to prove the loop; mainnet requires the SRL to be fully set up and tested, which is post-hackathon |
| Fixed-yield marketing | Prohibited by product principle in `canon/product.md`; not a feature, a non-negotiable rule |
