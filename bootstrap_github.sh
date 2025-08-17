#!/usr/bin/env bash
set -euo pipefail

# Bootstrap labels and issues for your repo using GitHub CLI.
# Usage:
#   1) cd <your cloned repo>
#   2) gh auth status || gh auth login
#   3) bash ./bootstrap_github.sh
#
# Notes:
# - Requires GitHub CLI: https://cli.github.com/
# - Designed to be idempotent-ish. Re-running won't break anything.
# - Use from Git Bash on Windows (or WSL).

# Require GitHub CLI
if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI (gh) is required: https://cli.github.com/" >&2
  exit 1
fi

# Create (or update) a label
create_label() {
  local name="$1"
  local color="$2"
  local desc="$3"
  gh label create "$name" --color "$color" --description "$desc" --force >/dev/null 2>&1 || true
}

# Milestone labels: M0..M8
for m in {0..8}; do
  create_label "milestone:M${m}" "6f42c1" "Milestone M${m}"
done

# Area labels
create_label "area:backend" "1f6feb" "Backend (Django/DRF)"
create_label "area:mobile"  "0e8a16" "Flutter app"
create_label "area:cli"     "8250df" "Rust CLI"
create_label "area:infra"   "d93f0b" "Infra"
create_label "area:docs"    "0366d6" "Docs"

# Type labels
create_label "type:feat"  "a2eeef" "Feature"
create_label "type:bug"   "d73a4a" "Bug"
create_label "type:chore" "c5def5" "Chore"
create_label "type:test"  "bfd4f2" "Testing"
create_label "type:docs"  "0075ca" "Docs"

# Create an issue with exactly three labels
create_issue() {
  local title="$1"
  local body="$2"
  local l1="$3"
  local l2="$4"
  local l3="$5"
  gh issue create -t "$title" -b "$body" -l "$l1" -l "$l2" -l "$l3" || true
}

# Issues
create_issue "[M0] Scaffold monorepo structure" \
  $'Acceptance:\n- Layout + README' \
  area:infra type:chore milestone:M0

create_issue "[M1] Init Django project & core app" \
  $'Acceptance:\n- Project boots' \
  area:backend type:feat milestone:M1