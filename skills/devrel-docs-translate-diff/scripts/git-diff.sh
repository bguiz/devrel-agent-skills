#!/bin/sh
# Usage: git-diff.sh <last-translation-commit> <canonical-lang-path> [file ...]
#
# Generates a unified diff of changes to canonical language docs since the
# last translation commit, restricted to the canonical language path and
# excluding any configured exclusion paths (e.g. other language subdirs).
#
# Arguments:
#   last-translation-commit  Required. The git commit hash at which the last
#                            translation was performed.
#   canonical-lang-path      Required. Path to the canonical-language docs
#                            directory relative to the repo root (e.g. ".gitbook/").
#   file ...                 Optional. Paths relative to the repo root to
#                            restrict the diff to specific pages. When omitted,
#                            every file under canonical-lang-path is included
#                            (subject to exclusions).
#
# Environment variables:
#   CANONICAL_EXCLUSION_PATHS  Optional. Colon-separated list of paths to
#                              exclude from the diff (e.g. other language
#                              subdirectories that live under canonical-lang-path).
#                              Example: ".gitbook/cn:.gitbook/ko:.gitbook/jp"

set -e

LAST_TRANSLATION_COMMIT="${1}"
CANONICAL_LANG_PATH="${2}"
shift 2 2>/dev/null || shift "$#"   # remaining positional args are optional file paths

# ── Validate required inputs ─────────────────────────────────────────────────

if [ -z "${LAST_TRANSLATION_COMMIT}" ]; then
  echo "error: last-translation-commit is required" >&2
  echo "usage: $0 <last-translation-commit> <canonical-lang-path> [file ...]" >&2
  exit 1
fi

if [ -z "${CANONICAL_LANG_PATH}" ]; then
  echo "error: canonical-lang-path is required" >&2
  echo "usage: $0 <last-translation-commit> <canonical-lang-path> [file ...]" >&2
  exit 1
fi

# ── Validate commit exists ────────────────────────────────────────────────────

if ! git cat-file -e "${LAST_TRANSLATION_COMMIT}^{commit}" 2>/dev/null; then
  echo "error: commit '${LAST_TRANSLATION_COMMIT}' does not exist in git history" >&2
  exit 1
fi

# ── Validate canonical language path exists ───────────────────────────────────

if [ ! -d "${CANONICAL_LANG_PATH}" ]; then
  echo "error: canonical language path '${CANONICAL_LANG_PATH}' does not exist" >&2
  exit 1
fi

# ── Build pathspec arguments ──────────────────────────────────────────────────

if [ "$#" -gt 0 ]; then
  # Specific files were requested — use them as the base pathspec
  PATHSPECS="$*"
else
  # No specific files — diff the whole canonical language path
  PATHSPECS="${CANONICAL_LANG_PATH}"
fi

# Append exclusion pathspecs using git's ":(exclude)" magic signature
EXCLUDE_PATHSPECS=""
if [ -n "${CANONICAL_EXCLUSION_PATHS}" ]; then
  # Split colon-separated list and build exclusion args
  OLD_IFS="${IFS}"
  IFS=":"
  for excl_path in ${CANONICAL_EXCLUSION_PATHS}; do
    EXCLUDE_PATHSPECS="${EXCLUDE_PATHSPECS} :(exclude)${excl_path}"
  done
  IFS="${OLD_IFS}"
fi

# ── Run git diff ──────────────────────────────────────────────────────────────

# shellcheck disable=SC2086
git diff "${LAST_TRANSLATION_COMMIT}" HEAD -- ${PATHSPECS} ${EXCLUDE_PATHSPECS}
