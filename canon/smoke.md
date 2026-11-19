# Production smoke

Short walk-through as a real user after every production deploy. A few minutes. Prod test account only; no real customer data, no real payments.

| # | Step | Expected |
|---|---|---|
| 1 | Open {{prod URL}} and sign in with the smoke account | Home loads |
| 2 | {{main action}} | {{...}} |
| 3 | What this release touched (from the session table) | Per its acceptance cases |
