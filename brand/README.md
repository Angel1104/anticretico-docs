# Llavero brand assets

## Logo files

The production logo files live in the code repository at [`/public/`](https://github.com/Angel1104/anticretico/tree/main/public). Keep this manifest descriptive; update the source assets in the code repository.

## Color palette

These values mirror the application tokens in `design/system/tokens.json`.

| Color | Hex | Token |
|---|---|---|
| Cream | `#F4F5F7` | `color.bg` |
| Navy | `#1F2347` | `color.text-primary` |
| Magenta | `#D5486C` | `color.gold` |
| Mustard | `#E9B749` | `color.state-warning` |
| Lavender | `#B6AED6` | `color.state-info` |

The legacy `gold` token name remains for compatibility; its value is Llavero magenta.

## Typography

Inter is the primary typeface, with `system-ui`, `-apple-system` and `sans-serif` as fallbacks.

## Voice

- Use Spanish (`es-BO`) as the primary language and English (`en`) as the secondary UI language. Never mix languages inside a label.
- Keep copy short, concrete and free of financial jargon. Prefer “Fondeada” to “capitalised” and “Inscrita en Derechos Reales” to “legally recorded”.
- Never use “guaranteed”, “assured”, “fixed yield”, “rendimiento garantizado” or “renta fija”.
- Present every return as variable, and use the required `RiskDisclosure` component for risk copy rather than writing it ad hoc.
