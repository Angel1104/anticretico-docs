# MVP

Status: **approved 2026-11-19**

Hackathon deadline: **2026-11-22** (3 days). Everything below runs on Stellar testnet.

All features are **functional end-to-end** — no visual-only mocks. Decided 2026-11-19: "un MVP funcional y dando todo, no solo un video."

## Features (all functional on testnet)

| # | Feature | What it must actually do | Size | Epic |
|---|---|---|---|---|
| 1 | Property catalog with live state (`En fondeo → En trámite → Buscando inquilino → Alquilado → Finalizado`) and per-property funding progress bar | Reads live state from DB; refreshes in real time when on-chain state changes | M | ANT-CATALOG |
| 2 | Wallet connect + USDC deposit into Trustless Work escrow for a specific property | Real testnet tx into Trustless Work escrow; receipt visible to investor | M | ANT-INVEST |
| 3 | Admin panel: validate "Inscrito en Derechos Reales" milestone and release escrow to owner | Admin button fires real Trustless Work release from escrow to the owner wallet | M | ANT-ADMIN |
| 4 | Monthly distribution via Pollar to investor wallets | Admin button fires a real Pollar distribution split across all token holders of the property | M | ANT-DISTRIB |
| 5 | Stellar explorer link per transaction (deposit, release, distribution) | Every tx surfaces a real link to the Stellar testnet explorer | S | ANT-EXPLORER |
| 6 | Owner panel: Retirar / Depositar en DeFi / Mixto, with a mandatory risk disclosure per option | Three buttons that execute real testnet txs: `Retirar` moves USDC from released escrow to owner wallet; `DeFi` deposits into a Stellar testnet protocol (Blend or Soroswap LP); `Mixto` is a slider that splits between the two. Each option shows its risk disclosure before signing. | M | ANT-OWNER |
| 7 | Rollover: at `Finalizado`, migrate holders into a new token series on another `En fondeo` property | Real composite tx — issue new series on target property, burn old series, batch-sign migration from admin for demo wallets (opt-in holder flow is post-pilot) | M | ANT-ROLLOVER |

## Confirmed fallbacks (Angel approved 2026-11-19)

- **DeFi backend risk.** If Blend/Soroswap testnet is unstable the Saturday of the hackathon, reduce feature #6 to two buttons: `Retirar` and `Reinvertir en otra anticrético` (which reuses #7's flow). 30-minute switch, no pitch impact.
- **Rollover in demo.** Demo holders are controlled wallets held by Llavero; migration is batch-signed from the admin panel. Opt-in holder signature flow is out of MVP and planned post-pilot.

## Explicitly out

| Feature | Why not now |
|---|---|
| Secondary market for economic tokens | Needs liquidity, ASFI sandbox sign-off, and likely a different legal wrapper; out of hackathon scope |
| Mobile app (iOS/Android) | Web covers investors and admin for the pilot; mobile requires separate QA, review and store overhead we cannot afford in 3 days |
| Automatic KYC (third-party provider) | UIF RA 019/2025 compliance is satisfied by **manual** admin KYC for the pilot; a provider needs contracts, invoicing and legal review the hackathon cannot absorb |
| Fiat on-ramp from BOB to USDC | Users bring USDC. Fiat on-ramps require partnering with a VASP and formal BCB posture — out of pilot scope |
| Mainnet | Stellar testnet is enough to prove the loop; mainnet requires the SRL to be fully set up and tested, which is post-hackathon |
| Fixed-yield marketing | Prohibited by product principle in `canon/product.md`; not a feature, a non-negotiable rule |
| Opt-in rollover signature flow per holder | Needed for real pilot but not for the 3-day demo (see "Confirmed fallbacks") |
