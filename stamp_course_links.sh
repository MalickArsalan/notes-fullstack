#!/usr/bin/env bash
set -euo pipefail
command -v gh >/dev/null || { echo "Install GitHub CLI: https://cli.github.com/"; exit 1; }

append_refs(){
  local title="$1"; local refs_md="$2"
  local num="$(gh issue list --search "in:title \"$title\"" --json number --limit 1 -q '.[0].number' || true)"
  [[ -z "${num:-}" ]] && { echo "Issue not found: $title"; return; }
  local body="$(gh issue view "$num" --json body -q .body || echo "")"
  if grep -q "### References & resources" <<<"$body"; then echo "Already stamped: #$num"; return; fi
  printf "%s

### References & resources
%s
" "$body" "$refs_md" > /tmp/issue_body.$$
  gh issue edit "$num" -F /tmp/issue_body.$$
  rm -f /tmp/issue_body.$$
  echo "Stamped: #$num"
}

# generate calls from JSON
python - << 'PY' | bash
import json
m=json.load(open('course_issue_mapping.json'))
for t,refs in m.items():
    md="\n".join(f"- [{x[0]}]({x[1]})" for x in refs)
    print(f"append_refs '{t}' '{md}'")
PY
