# Branching & PR Workflow

A clear, repeatable way to ship work with clean history and CI checks. Even if you work solo, use this flow—it looks professional and keeps mistakes out of `main`.

---

## TL;DR
1) **Sync** `main` → `git checkout main && git pull`
2) **Branch** per task → `git checkout -b feat/<area>-<slug>`
3) **Commit** small, meaningful changes → `git add -A && git commit -m "feat(area): message"`
4) **Push & PR** → `git push -u origin <branch>` → open PR (Draft first is fine)
5) **CI green** → fix lint/tests if needed
6) **Merge** (Squash & merge) → **Delete branch**
7) **Sync** again → start next task on a fresh branch

---

## Vocabulary
- **Branch**: a line of work separate from `main`.
- **PR (Pull Request)**: proposal to merge your branch into `main`. Runs CI and shows the diff.
- **CI (Continuous Integration)**: automated checks (lint, tests) on each PR/push.
- **Squash merge**: combines all branch commits into one tidy commit on `main`.

---

## Naming rules
Use **one issue = one branch = one PR**.

Prefixes:
- `feat/` (new feature), `fix/` (bugfix), `chore/` (setup, CI, config), `docs/`, `test/`

Scopes (pick one):
- `backend`, `mobile`, `cli`, `infra`, `docs`

Examples:
- `feat/backend-django-init`
- `chore/devcontainer`
- `fix/mobile-login-refresh`

Commit messages follow **Conventional Commits**:
```
feat(backend): add /api/health endpoint
fix(mobile): refresh access token on 401
chore(ci): add backend workflow
docs(readme): add quickstart
```

---

## Standard workflow (step-by-step)

### 0) Start clean
```bash
git checkout main
git pull
```

### 1) Create a branch for ONE task
```bash
git checkout -b feat/backend-django-init
```

### 2) Do the work and commit in small chunks
```bash
# edit files
git add -A
git commit -m "feat(backend): init Django project and health endpoint"
```

### 3) Push and open a PR
```bash
git push -u origin feat/backend-django-init
```
- On GitHub: click **“Compare & pull request”**.
- Make it a **Draft PR** until CI is green and you’re done.
- In the PR description: link the issue (e.g., `Closes #12`).

### 4) Let CI run; fix failures
- Format/lint/test locally, push again until **CI passes**.

### 5) Merge and clean up
- Prefer **Squash & merge** for a single clean commit on `main`.
- Delete the branch (GitHub button or locally).

### 6) Sync and start the next task
```bash
git checkout main && git pull
git branch -d feat/backend-django-init
git checkout -b feat/backend-add-drf
```

---

## Keeping your branch up-to-date with `main`

When `main` moves ahead while you’re still coding:

**Option A — Rebase (clean history, recommended if comfortable):**
```bash
git fetch origin
git checkout feat/backend-django-init
git rebase origin/main
# if conflicts: fix files → git add -A → git rebase --continue
git push --force-with-lease
```

**Option B — Merge (simpler, adds a merge commit):**
```bash
git fetch origin
git checkout feat/backend-django-init
git merge origin/main
git push
```

---

## Handling merge conflicts (quick recipe)
1) Git tells you which files conflict. Open them; look for `<<<<<<<`, `=======`, `>>>>>>>` markers.  
2) Decide the final content; **remove** the markers.  
3) `git add -A`  
4) If rebasing: `git rebase --continue`; if merging: `git commit`  
5) Push your branch again.

---

## PR checklist (copy into PR description if helpful)
- [ ] PR title uses conventional commits (`feat|fix|chore|docs|test(scope): message`)
- [ ] Scope touches **one area** (backend / mobile / cli / infra / docs)
- [ ] Code formatted & linted; CI is **green**
- [ ] Added/updated **tests** where sensible
- [ ] Updated **README/docs** if behavior changed
- [ ] Linked the Issue (e.g., `Closes #123`)
- [ ] Screenshots/GIFs for UI changes (if applicable)

---

## Examples mapped to tasks
- `[M1] Init Django project & core app` → branch: `feat/backend-django-init`, PR: `feat(backend): init Django project and health endpoint`
- `[M2] Docker-compose for Postgres + backend` → `feat/infra-compose-db`, PR: `feat(infra): docker-compose with Postgres`
- `[M3] JWT auth endpoints (login/refresh)` → `feat/backend-auth-jwt`, PR: `feat(backend): add SimpleJWT login/refresh`
- `[M6] Init Flutter app & flavors` → `feat/mobile-init`, PR: `feat(mobile): scaffold app and flavors`
- `[M7] Init Rust CLI crate` → `feat/cli-init`, PR: `feat(cli): initialize Rust crate`

---

## Tips
- Keep PRs small (≤ 300 lines of diff when possible).
- Open a **Draft PR** early to get CI feedback while you work.
- Use `git status` often; it tells you exactly what’s staged/unstaged.
- Commit messages should explain **why** when the code isn’t obvious.
- Delete branches after merge—your repo stays tidy.

---

## Appendix: GitHub CLI (`gh`) shortcuts (optional)
```bash
# create a PR from current branch
gh pr create -t "feat(backend): init Django project" -b "Closes #12"

# view PR status
gh pr view --web

# checkout a PR locally (useful when reviewing)
gh pr checkout <PR_NUMBER>
```
