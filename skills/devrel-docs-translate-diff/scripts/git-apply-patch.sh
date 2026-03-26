#!/bin/sh
# Usage: git-apply-patch.sh <patch-file>
#
# Applies a translation patch file produced by the AI agent to the working
# tree. Performs a dry-run first; if the patch does not apply cleanly it falls
# back to --reject so that conflicts are written to .rej files rather than
# silently failing.
#
# Arguments:
#   patch-file  Required. Path to the unified-diff patch file to apply.

set -e

PATCH_FILE="${1}"

# ── Validate required input ──────────────────────────────────────────────────

if [ -z "${PATCH_FILE}" ]; then
  echo "error: patch-file is required" >&2
  echo "usage: $0 <patch-file>" >&2
  exit 1
fi

if [ ! -f "${PATCH_FILE}" ]; then
  echo "error: patch file '${PATCH_FILE}' does not exist" >&2
  exit 1
fi

# ── Dry-run to detect conflicts ──────────────────────────────────────────────

if git apply --check "${PATCH_FILE}" 2>/dev/null; then
  # Patch applies cleanly — go ahead
  git apply "${PATCH_FILE}"
  echo "patch applied successfully"
else
  # Patch has conflicts — apply with --reject so .rej files are created for
  # each hunk that cannot be applied, allowing manual resolution
  echo "warning: patch does not apply cleanly; applying with --reject" >&2
  echo "         resolve any *.rej files, then stage and commit the result" >&2
  git apply --reject "${PATCH_FILE}" || true

  # Report which .rej files were created so the user knows what to fix
  REJ_FILES=$(find . -name "*.rej" 2>/dev/null)
  if [ -n "${REJ_FILES}" ]; then
    echo "" >&2
    echo "the following conflict files require manual resolution:" >&2
    echo "${REJ_FILES}" | while IFS= read -r f; do
      echo "  ${f}" >&2
    done
  fi

  exit 1
fi
