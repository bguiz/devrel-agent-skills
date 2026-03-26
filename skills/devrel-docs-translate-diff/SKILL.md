---
name: devrel-docs-translate-diff
description: Generate precise translation diffs for localised versions of dev docs when the canonical version is updated, rather than re-translating entire pages.
activates_on: ["*.md", "*.mdx", "*.txt"]
uses: ["devrel-docs-style"]
license: MIT
metadata:
  author: bguiz
  version: "0.0.0"
---

# Translate Documentation Diffs, Skill Guide

Developer documentation sites may contain multiple languages when published,
but originally authored in a single language, known as the *canonical language*.
Thus each time the documentation is updated in the canonical language,
the other languages need to be updated,
and this skill helps you to do that.

## When to apply

- Whenever dev docs in the canonical language have been updated

## Inputs

- The git commit hash at which the last translation from the canonical language was performed
- The target language for translation
- Optional: The list of pages to translate. If unspecified will use all files from the diff between the last translation git commit and the latest git commit
- Optional: The canonical language. If unspecified will set to English.

## Activities

Perform the following sequence

### 1 - Validate inputs

All non-optional inputs should be processed and validated.

### 2 - git diff

Perform a git diff restricted to the subdirectory of the canonical language.

To do so, run script: `./scripts/git-diff.sh`

### 3 - Validation 2nd pass

If the git diff is empty, output an error message saying that there is nothing to translate, and exit.

### 4 - Translate

- Find the corresponding lines for the git diff within the target language.
- For each line that has a diff in the canonical language, make an equivalent diff for the target language
- The format should be a git diff patch file

Avoid the following:
- Do not translate technical terms or other terminology which should remain in the canonical language even in translations
- Do not translate code examples
- Do not invent or assume - if the canonical language is ambiguous or confusing note it and skip

### 5 - Translation self-check

For various reasons (e.g. need clarification or decisions), if some parts of the translation need to be skipped, do the following:
- Output messages for the user that describe each issue (one message per issue)
- Give the user 3 options:
  - Cancel --> Exit immediately
  - Ignore --> Continue to the next step
  - Clarify or make changes --> Ask the user for their further inputs, and update the translations accordingly (repeat previous step, but only for specific areas), and finally re-run this step.

### 6 - Apply translation from patch file

Apply the git diff patch file from the previous step.

To do so, run script: `./scripts/git-apply-patch.sh`

### 7 - Next steps for user

Tell the user to:
- Push the current git branch
- Create a PR
- Review the translations
- Merge the PR

## Related skills

Nil

## Prerequisites

Nil
