#!/usr/bin/env bash
# Read-only permission and tooling check before creating or running anything.
# Usage: scripts/preflight.sh [--owner <github-org-or-user>] [--repo <owner/name>]
# Prints one line per check: PASS / FAIL / WARN / INFO. Exit 1 if any FAIL.
set -u
OWNER=""; REPO=""
while [ $# -gt 0 ]; do
  case "$1" in
    --owner) OWNER="$2"; shift 2 ;;
    --repo) REPO="$2"; shift 2 ;;
    *) echo "unknown arg: $1"; exit 2 ;;
  esac
done
fails=0
out() { printf '%-5s %-38s %s\n' "$1" "$2" "$3"; [ "$1" = FAIL ] && fails=$((fails+1)); return 0; }
have() { command -v "$1" >/dev/null 2>&1; }

echo "== Tools"
for t in git gh node jq; do
  if have "$t"; then out PASS "$t" "$($t --version 2>&1 | head -1)"; else out FAIL "$t" "not installed"; fi
done
for t in claude codex; do
  if have "$t"; then out PASS "$t CLI" "$($t --version 2>&1 | head -1)"; else out WARN "$t CLI" "not installed (needed only if assigned a role)"; fi
done
if have antigravity || have agy; then out PASS "antigravity CLI" "found"; else out WARN "antigravity CLI" "not found on PATH (needed only if assigned a role)"; fi
ORCA_BIN="${ORCA_CLI_COMMAND:-}"
[ -z "$ORCA_BIN" ] && have orca && ORCA_BIN=orca
[ -z "$ORCA_BIN" ] && [ -x /Applications/Orca.app/Contents/Resources/bin/orca ] && ORCA_BIN=/Applications/Orca.app/Contents/Resources/bin/orca
if [ -n "$ORCA_BIN" ]; then out PASS "orca" "$("$ORCA_BIN" --version 2>&1 | head -1) ($ORCA_BIN)"; else out WARN "orca" "not found (Claude Code runner only)"; fi
if have npx && npx --no-install playwright --version >/dev/null 2>&1; then out PASS "playwright" "available"; else out WARN "playwright" "not installed here (needed for QA and smoke)"; fi

echo "== Git identity"
out INFO "git user.email" "$(git config --global user.email 2>/dev/null || echo unset) (check personal vs org email)"

echo "== GitHub auth"
if ! gh auth status >/dev/null 2>&1; then out FAIL "gh auth" "not logged in: gh auth login"; else
  ME=$(gh api user --jq .login 2>/dev/null)
  out PASS "gh auth" "logged in as $ME"
  scopes=$(gh auth status 2>&1 | grep -i 'token scopes' | head -1)
  for s in repo workflow read:org project; do
    if grep -q "'$s'" <<<"$scopes"; then out PASS "token scope $s" ""; else out FAIL "token scope $s" "gh auth refresh -s $s"; fi
  done
  if grep -q "'admin:org'" <<<"$scopes"; then out PASS "token scope admin:org" ""; else out WARN "token scope admin:org" "needed for org rulesets/Apps: gh auth refresh -s admin:org"; fi
fi

if [ -n "$OWNER" ] && [ -n "${ME:-}" ]; then
  echo "== Owner: $OWNER"
  type=$(gh api "users/$OWNER" --jq .type 2>/dev/null || echo "?")
  if [ "$type" = Organization ]; then
    role=$(gh api "orgs/$OWNER/memberships/$ME" --jq .role 2>/dev/null || echo none)
    case "$role" in
      admin) out PASS "org role" "owner/admin: can create repos, Apps, rulesets, Projects" ;;
      member) out WARN "org role" "member: repo creation depends on org settings; Apps and org rulesets need an owner" ;;
      *) out FAIL "org role" "not a member of $OWNER" ;;
    esac
    org=$(gh api "orgs/$OWNER" 2>/dev/null)
    plan=$(jq -r '.plan.name // "unknown (visible to owners only)"' <<<"$org" 2>/dev/null)
    out INFO "org plan" "$plan (free: no rulesets on private repos)"
    priv=$(jq -r '.members_can_create_private_repositories // "unknown"' <<<"$org" 2>/dev/null)
    pub=$(jq -r '.members_can_create_public_repositories // "unknown"' <<<"$org" 2>/dev/null)
    out INFO "members can create" "private=$priv public=$pub"
  elif [ "$type" = User ]; then
    [ "$OWNER" = "$ME" ] && out PASS "owner" "your personal account" || out FAIL "owner" "$OWNER is another user's account"
    out INFO "plan" "$(gh api user --jq '.plan.name // "unknown"' 2>/dev/null) (free: no rulesets on private repos)"
  else
    out FAIL "owner" "$OWNER not found"
  fi
fi

if [ -n "$REPO" ] && [ -n "${ME:-}" ]; then
  echo "== Repo: $REPO"
  perm=$(gh api "repos/$REPO" --jq '.permissions | if .admin then "admin" elif .maintain then "maintain" elif .push then "write" else "read" end' 2>/dev/null || echo none)
  case "$perm" in
    admin) out PASS "repo permission" "admin: rulesets, secrets, variables" ;;
    none) out FAIL "repo permission" "repo not found or no access" ;;
    *) out FAIL "repo permission" "$perm: admin needed for rulesets, secrets, variables" ;;
  esac
fi

echo "== Cloud CLIs (only the chosen platform matters)"
have gcloud && out INFO "gcloud" "account: $(gcloud config get-value account 2>/dev/null || echo none)"
have vercel && out INFO "vercel" "$(vercel whoami 2>/dev/null || echo 'not logged in')"
have flyctl && out INFO "flyctl" "$(flyctl auth whoami 2>/dev/null || echo 'not logged in')"
have firebase && out INFO "firebase" "installed"
have supabase && out INFO "supabase" "installed"

echo; [ "$fails" -eq 0 ] && echo "PREFLIGHT: no FAIL" || { echo "PREFLIGHT: $fails FAIL"; exit 1; }
