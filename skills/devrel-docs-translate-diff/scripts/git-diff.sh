#!/bin/sh
# Usage: git-diff.sh <last-translation-commit> [canonical-lang-dir] [file ...]
#
# Generates a unified diff of changes to canonical language docs since the
# last translation commit. Output is written to stdout so the caller (or the
# AI agent) can pipe / redirect it to a patch file.
#
# Arguments:
#   last-translation-commit  Required. The git commit hash at which the last
#                            translation was performed.
#   canonical-lang-dir       Optional. Path to the canonical-language docs
#                            directory relative to the repo root.
#                            Defaults to "en".
#   file ...                 Optional. One or more paths (relative to the repo
#                            root) to restrict the diff to specific pages.
#                            When omitted, every file under canonical-lang-dir
#                            is included.

set -e

LAST_TRANSLATION_COMMIT="${1}"
CANONICAL_LANG_DIR="${2:-en}"
shift 2 2>/dev/null || shift "$#"   # remaining args are optional file paths

# ── Validate required input ──────────────────────────────────────────────────

if [ -z "${LAST_TRANSLATION_COMMIT}" ]; then
  echo "error: last-translation-commit is required" >&2
  echo "usage: $0 <last-translation-commit> [canonical-lang-dir] [file ...]" >&2
  exit 1
fi

# ── Validate commit exists ───────────────────────────────────────────────────

if ! git cat-file -e "${LAST_TRANSLATION_COMMIT}^{commit}" 2>/dev/null; then
  echo "error: commit '${LAST_TRANSLATION_COMMIT}' does not exist in git history" >&2
  exit 1
fi

# ── Validate canonical language directory ────────────────────────────────────

if [ ! -d "${CANONICAL_LANG_DIR}" ]; then
  echo "error: canonical language directory '${CANONICAL_LANG_DIR}' does not exist" >&2
  exit 1
fi

# ── Build file path arguments ────────────────────────────────────────────────

if [ "$#" -gt 0 ]; then
  # Specific files were requested — use them directly
  FILE_PATHS="$*"
else
  # No specific files — diff the whole canonical language directory
  FILE_PATHS="${CANONICAL_LANG_DIR}"
fi

# ── Run git diff ─────────────────────────────────────────────────────────────

# shellcheck disable=SC2086
git diff "${LAST_TRANSLATION_COMMIT}" HEAD -- ${FILE_PATHS}
