# Learning Plan — Fullstack Notes (Django · DRF · JWT · Flutter · Rust)

This plan maps directly to your GitHub Issues (M0–M8). Aim for **90–120 min/day**.

---

## Week 0 — GitHub & Project Hygiene (M0)
**Goal:** Comfortable with Issues, PRs, labels, CI.
- Install GitHub CLI (`gh`) and authenticate.
- Run `bootstrap_github.sh` to create labels + issues.
- Read `README.md` and `CONTRIBUTING.md`.
- OPTIONAL: Open in VS Code Dev Container.

**Outcome:** Project board ready; you understand PR flow and CI.

---

## Week 1 — Django Fundamentals (M1 start)
**Goal:** Create a Django project you can run & test.
- `django-admin startproject core .` and `python manage.py startapp api`.
- Add `/api/health` endpoint and a pytest to verify it.
- Read: settings, apps, URLs, views, admin.

**Outcome:** Local server + passing test in CI.

**Checklist**
- [ ] Project created (`core`) + app (`api`)
- [ ] `/api/health` returns `{"status":"up"}`
- [ ] `pytest` green locally and in CI

---

## Week 2 — DRF Core (M1 continue)
**Goal:** Turn Django into a REST API.
- Install DRF and configure `REST_FRAMEWORK` (pagination, permissions).
- Create a demo serializer & ViewSet, register with router.
- Keep the health test; add one API test.

**Outcome:** Basics of serializers, viewsets, routers.

**Checklist**
- [ ] DRF installed and configured
- [ ] 1 demo endpoint with serializer
- [ ] API test passes

---

## Week 3 — JWT Auth (M3)
**Goal:** Secure endpoints with access/refresh tokens.
- Install & configure **SimpleJWT**.
- Add `/api/token/` and `/api/token/refresh/`.
- Protect one endpoint; write tests for authorized vs unauthorized.

**Outcome:** You can log in, refresh tokens, and protect routes.

**Checklist**
- [ ] SimpleJWT wired
- [ ] Auth flow verified via tests/Postman
- [ ] DRF permissions applied

---

## Week 4 — Postgres & Docker (M2)
**Goal:** Run Postgres via Docker and connect Django.
- `docker-compose up` Postgres
- Split settings (dev/prod) and use env vars (`.env` or system env).
- Migrate and run against Postgres.

**Outcome:** Reproducible DB setup and settings hygiene.

**Checklist**
- [ ] Compose file runs DB
- [ ] Django connects using env vars
- [ ] Migrations applied against Postgres

---

## Week 5 — Notes Domain + Quality (M4/M5)
**Goal:** Ship a real feature with tests and API docs.
- Create `Note` model (title, content, owner, timestamps).
- Implement CRUD with viewsets/routers; owner-only permissions.
- Add pagination, ordering, and search.
- Add pytest coverage: model, permissions, endpoints.
- Generate OpenAPI schema (drf-spectacular) + Swagger/ReDoc.

**Outcome:** Production-like endpoints + docs.

**Checklist**
- [ ] Note model & migration
- [ ] Owner-only CRUD
- [ ] Pagination/ordering/search
- [ ] OpenAPI + Swagger/ReDoc exposed

---

## Week 6–7 — Flutter App (M6)
**Goal:** Mobile client for the same API.
- Initialize Flutter app + flavors (dev/prod).
- Add networking (Dio), models (auth/notes), token storage.
- Implement login + Notes list/detail + CRUD + optimistic updates.
- Add state management (Riverpod or Bloc). Add widget/unit tests.
- CI: analyze/test/build.

**Outcome:** A working Flutter client with tests and CI.

---

## Week 8 — Rust CLI (M7)
**Goal:** Scriptable client for the API.
- Add `reqwest`, `serde`, `clap`, `anyhow`.
- Implement `login`, `notes list/get/add/edit/delete`.
- Keep `fmt`, `clippy`, and tests green in CI.

**Outcome:** CLI that mirrors mobile features.

---

## Week 9 — Production polish & Release (M8)
**Goal:** Make it presentable and reproducible.
- Dockerfiles (backend, Flutter CI image, CLI).
- Harden backend settings (CORS/CSRF, gunicorn, static).
- Seed data & admin polish.
- README diagrams + short demo GIFs.
- Tag **v0.1.0** and create a GitHub release.

**Outcome:** Recruiter-ready project.

---

## Daily Habit (15–20 min)
- Skim docs of the tool you’re using this week.
- Write/adjust one small test.
- Format/lint and push.

## Practice Checklist
- [ ] Explain DRF serializers vs. models
- [ ] Explain JWT access vs. refresh token
- [ ] Add a new endpoint and wire a Flutter screen
- [ ] Write a Rust CLI subcommand
