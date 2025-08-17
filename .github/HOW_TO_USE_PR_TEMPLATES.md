
# How to use the PR templates (M0–M8)

These live in `.github/PULL_REQUEST_TEMPLATE/` and help you create professional, focused PRs.

## GitHub UI
1. Push your feature branch.
2. Click **Compare & pull request**.
3. On the PR page, click **Choose a template** (or the ⋯ menu) and pick the milestone file, e.g. `M3_auth_jwt.md`.
4. Fill in the sections and checklists; remove lines that don’t apply.
5. Add labels: `area:*`, `type:*`, `milestone:M*`.

## GitHub CLI
```bash
gh pr create -t "feat(backend): add JWT login/refresh"   -F .github/PULL_REQUEST_TEMPLATE/M3_auth_jwt.md
```

## Tips
- One issue = one branch = one PR.
- Keep PRs small and let CI guide you.
- Prefer **Squash & merge**.
