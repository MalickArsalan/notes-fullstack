# Contributing Guide

This repo is organized as a **monorepo** with three main codebases:
- `backend/` — Django + DRF (Python)
- `mobile/` — Flutter (Dart)
- `cli/` — Rust CLI

Use this guide for day‑to‑day workflow, commit/PR standards, and local checks.

---

## 1) Workflow

1. Create a branch from `main`:
   - `feat/<area>-<short-slug>` (e.g., `feat/backend-django-init`)
   - `fix/<area>-<short-slug>` (e.g., `fix/mobile-login-crash`)
2. Open a **Draft PR** early; push commits as you work.
3. Keep PRs small and focused; link the Issue: `Closes #123`.
4. Ensure **CI is green** (format, lint, tests) before requesting review.
5. Squash‑merge to `main` when approved.

---

## 2) Conventional commits

Use one of: `feat`, `fix`, `docs`, `chore`, `test`, `refactor`, `perf`

Examples:
- `feat(backend): add /api/health endpoint`
- `fix(mobile): handle 401 by refreshing token`
- `chore(cli): bump clap to 4.x`
- `test(backend): add notes permissions tests`

---

## 3) Local commands

### Backend (Python/Django)
```bash
cd backend
python -m venv venv && source venv/bin/activate   # Windows: .\venv\Scripts\Activate.ps1
pip install -r requirements-dev.txt

# format & lint
black . && isort . && flake8 .
# tests
pytest -q
```

### Mobile (Flutter)
```bash
cd mobile
flutter pub get
# format & analyze
flutter format . && flutter analyze
# tests
flutter test -r expanded
```

### CLI (Rust)
```bash
cd cli
# format & lint
cargo fmt --all
cargo clippy -- -D warnings
# tests
cargo test --all
```

---

## 4) Pull request checklist

- [ ] PR title uses conventional commits (scope optional)
- [ ] Affects **one** area (backend / mobile / cli / infra / docs)
- [ ] Added/updated tests where sensible
- [ ] Ran local format/lint/test commands for that area
- [ ] Updated docs or `README.md` if behavior changed
- [ ] Linked the Issue (e.g., `Closes #123`)
- [ ] Screenshots/GIFs for UI changes (if applicable)

---

## 5) CI overview

GitHub Actions run automatically on PRs/pushes:
- **backend**: `black --check`, `isort --check-only`, `flake8`, `pytest`
- **mobile**: `flutter analyze`, `flutter test`
- **cli**: `cargo fmt --check`, `cargo clippy -D warnings`, `cargo test`

Fix any failures locally and push again.

---

## 6) Branch scopes (areas)

Use one of these scopes in commit/PR titles when helpful:
- `backend`, `mobile`, `cli`, `infra`, `docs`

---

## 7) Code style quick notes

- Keep functions/classes small and focused.
- Prefer explicit naming over comments.
- Avoid dead code; delete unused files and imports.
- Tests should be deterministic and fast.
- Document non-obvious decisions in `docs/` (short notes are fine).

---

## 8) Getting help

Open a draft PR early and push work-in-progress commits. Use the PR description to ask questions and list open issues.
