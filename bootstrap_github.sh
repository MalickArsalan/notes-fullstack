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
  local title="$1";
  local body="$2"; shift 2

  gh issue create -t "$title" -b "$body" "$@" || true
}

echo "==> Bootstrapping GitHub labels and issues..."

  # M0 — Repo & Tooling
create_issue "[M0] Scaffold monorepo structure" $'# Acceptance\n- Root layout with backend/mobile/cli/infra/docs/.github\n- README with quickstart\n' -l area:infra -l type:chore -l milestone:M0
create_issue "[M0] GitHub templates & CODEOWNERS" $'# Acceptance\n- PR & Issue templates\n- CODEOWNERS configured\n' -l area:docs -l type:chore -l milestone:M0
create_issue "[M0] Devcontainer & Editorconfig" $'# Acceptance\n- .devcontainer with Python/Node/Rust\n- .editorconfig present\n' -l area:infra -l type:chore -l milestone:M0
create_issue "[M0] Pre-commit & linters" $'# Acceptance\n- black/isort/flake8\n- cargo fmt/clippy\n- flutter analyze\n' -l area:infra -l type:chore -l milestone:M0

# M1 — Backend scaffold
create_issue "[M1] Init Django project & core app" $'# Acceptance\n- Django project boots locally\n- Core app created\n' -l area:backend -l type:feat -l milestone:M1
create_issue "[M1] Add DRF & base settings" $'# Acceptance\n- DRF installed & configured\n- Pagination + default permissions set\n' -l area:backend -l type:feat -l milestone:M1
create_issue "[M1] Healthcheck endpoint /api/health" $'# Acceptance\n- GET /api/health returns status up\n- Covered by unit test\n' -l area:backend -l type:feat -l type:test -l milestone:M1

# M2 — Postgres & Docker
create_issue "[M2] Docker-compose for Postgres + backend" $'# Acceptance\n- docker-compose up brings DB & backend\n- .env handling for DB creds\n' -l area:infra -l type:feat -l milestone:M2
create_issue "[M2] Settings split & env management" $'# Acceptance\n- dev/prod settings split\n- python-dotenv or env vars loaded\n' -l area:backend -l type:chore -l milestone:M2

# M3 — Auth: JWT
create_issue "[M3] JWT auth endpoints (login/refresh)" $'# Acceptance\n- SimpleJWT configured\n- /api/token/ & /api/token/refresh/\n' -l area:backend -l type:feat -l milestone:M3
create_issue "[M3] User model & admin" $'# Acceptance\n- Custom user (optional) or default\n- Admin enabled for user mgmt\n' -l area:backend -l type:feat -l milestone:M3

# M4 — Notes domain
create_issue "[M4] Note model & migrations" $'# Acceptance\n- fields: id, title, content, owner, timestamps\n- Migration applied\n' -l area:backend -l type:feat -l milestone:M4
create_issue "[M4] Notes API (ViewSet + Router)" $'# Acceptance\n- CRUD endpoints\n- Serializer & permissions stub\n' -l area:backend -l type:feat -l milestone:M4
create_issue "[M4] Pagination, ordering, search filters" $'# Acceptance\n- DRF pagination & ordering configured\n- Search by title/content\n' -l area:backend -l type:feat -l milestone:M4
create_issue "[M4] Owner-only object permissions" $'# Acceptance\n- Only owner can read/write their notes\n- Unit tests\n' -l area:backend -l type:feat -l type:test -l milestone:M4

# M5 — Quality & OpenAPI
create_issue "[M5] Pytest suite (auth + notes)" $'# Acceptance\n- Pytest configured\n- Tests for auth and notes\n' -l area:backend -l type:test -l milestone:M5
create_issue "[M5] Backend CI (lint & test)" $'# Acceptance\n- GH Actions: black/isort/flake8/pytest\n' -l area:infra -l type:chore -l milestone:M5
create_issue "[M5] OpenAPI schema + Swagger/ReDoc" $'# Acceptance\n- drf-spectacular generates /schema\n- Swagger/ReDoc served\n' -l area:backend -l type:docs -l milestone:M5

# M6 — Flutter app
create_issue "[M6] Init Flutter app & flavors" $'# Acceptance\n- Flutter project created\n- dev/prod flavors (flavor config)\n' -l area:mobile -l type:feat -l milestone:M6
create_issue "[M6] Theming, routing, folder-by-feature" $'# Acceptance\n- Router (go_router or Navigator 2.0)\n- Theming scaffold\n' -l area:mobile -l type:chore -l milestone:M6
create_issue "[M6] API client & DTOs (auth/notes)" $'# Acceptance\n- Dio/http client\n- Models for auth/notes\n' -l area:mobile -l type:feat -l milestone:M6
create_issue "[M6] JWT auth flow (login/refresh, storage)" $'# Acceptance\n- Login UI\n- Secure token storage & refresh\n' -l area:mobile -l type:feat -l milestone:M6
create_issue "[M6] Notes list & detail screens" $'# Acceptance\n- List + detail views\n- Wire to API\n' -l area:mobile -l type:feat -l milestone:M6
create_issue "[M6] Notes create/edit/delete (+optimistic)" $'# Acceptance\n- Forms with validation\n- Optimistic update UX\n' -l area:mobile -l type:feat -l milestone:M6
create_issue "[M6] Error handling & interceptors" $'# Acceptance\n- Global error handler\n- Retry/backoff for 5xx\n' -l area:mobile -l type:feat -l milestone:M6
create_issue "[M6] State management (Riverpod/Bloc)" $'# Acceptance\n- Pick one\n- Wire lists/forms/auth\n' -l area:mobile -l type:feat -l milestone:M6
create_issue "[M6] Unit & widget tests + analyze" $'# Acceptance\n- flutter test passes\n- analyze is clean\n' -l area:mobile -l type:test -l milestone:M6
create_issue "[M6] Mobile CI (analyze/test/build)" $'# Acceptance\n- GH Actions for analyze/test/build\n' -l area:infra -l type:chore -l milestone:M6

# M7 — Rust CLI
create_issue "[M7] Init Rust CLI crate" $'# Acceptance\n- cargo new\n- hello world runs\n' -l area:cli -l type:feat -l milestone:M7
create_issue "[M7] CLI auth (JWT) + config" $'# Acceptance\n- Login via API\n- Token persistence\n' -l area:cli -l type:feat -l milestone:M7
create_issue "[M7] Notes commands (list/get/add/edit/del)" $'# Acceptance\n- CLI subcommands implemented\n- Happy-path tests\n' -l area:cli -l type:feat -l type:test -l milestone:M7
create_issue "[M7] CLI CI (fmt/clippy/test)" $'# Acceptance\n- cargo fmt --check\n- cargo clippy -D warnings\n- cargo test\n' -l area:infra -l type:chore -l milestone:M7

# M8 — Production hardening
create_issue "[M8] Dockerfiles for backend/mobile/cli" $'# Acceptance\n- Dockerfile for backend (gunicorn)\n- CI image for Flutter\n- CLI container\n' -l area:infra -l type:feat -l milestone:M8
create_issue "[M8] Backend prod settings (CORS, security)" $'# Acceptance\n- CORS/CSRF settings\n- whitenoise/static files\n' -l area:backend -l type:chore -l milestone:M8
create_issue "[M8] Seed data & admin polish" $'# Acceptance\n- Seed script\n- Admin list/display tweaks\n' -l area:backend -l type:chore -l milestone:M8
create_issue "[M8] README diagrams & demo GIFs" $'# Acceptance\n- Updated README with diagrams\n- Quickstart & screenshots\n' -l area:docs -l type:docs -l milestone:M8
create_issue "[M8] Prepare v0.1.0 release" $'# Acceptance\n- Tag & changelog\n- gh release create\n' -l area:infra -l type:chore -l milestone:M8

echo "==> Done. Open your Issues tab."