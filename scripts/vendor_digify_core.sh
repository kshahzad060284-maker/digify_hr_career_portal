#!/usr/bin/env bash
set -euo pipefail

# flutter pub get does not use git credential rewrites reliably for private
# packages. Clone with the PAT, point the app at _vendor/digify_core, then
# pub get (same pattern as grc_web/scripts/render_build.sh).

if [ -z "${DIGIFY_GITHUB_TOKEN:-}" ]; then
  echo "ERROR: DIGIFY_GITHUB_TOKEN is not set."
  exit 1
fi

http_code="$(curl -s -o /dev/null -w "%{http_code}" \
  -H "Authorization: Bearer ${DIGIFY_GITHUB_TOKEN}" \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/hananmalik21/digify_core")"

case "${http_code}" in
  200) echo "GitHub token can access digify_core." ;;
  401)
    echo "ERROR: GitHub token is invalid or expired (HTTP 401)."
    exit 1
    ;;
  404)
    echo "ERROR: Cannot access hananmalik21/digify_core (HTTP 404)."
    echo "Ensure the PAT has read access to the private Digify Core package."
    exit 1
    ;;
  *)
    echo "ERROR: Unexpected GitHub API response HTTP ${http_code} for digify_core."
    exit 1
    ;;
esac

AUTH="https://oauth2:${DIGIFY_GITHUB_TOKEN}@github.com/hananmalik21"

echo "Cloning private package into _vendor/..."
rm -rf _vendor
mkdir -p _vendor

git clone --depth 1 --branch main "${AUTH}/digify_core.git" _vendor/digify_core

if [ ! -f "_vendor/digify_core/pubspec.yaml" ]; then
  echo "ERROR: _vendor/digify_core/pubspec.yaml is missing after clone."
  exit 1
fi

cat > pubspec_overrides.yaml <<'EOF'
# Generated in CI — do not commit.
dependency_overrides:
  digify_core:
    path: _vendor/digify_core
EOF

python3 - <<'PY'
from pathlib import Path

pubspec = Path("pubspec.yaml")
text = pubspec.read_text(encoding="utf-8")
old = """  digify_core:
    git:
      url: https://github.com/hananmalik21/digify_core.git
      ref: main
"""
new = """  digify_core:
    path: _vendor/digify_core
"""
if old not in text:
    raise SystemExit("Could not find digify_core git dependency in pubspec.yaml")
pubspec.write_text(text.replace(old, new, 1), encoding="utf-8")
print("Rewrote pubspec.yaml to use path: _vendor/digify_core")
PY

echo "pubspec_overrides.yaml:"
cat pubspec_overrides.yaml

PUB_CACHE_DIR="${PUB_CACHE:-${HOME}/.pub-cache}"
rm -rf "${PUB_CACHE_DIR}/git" 2>/dev/null || true
