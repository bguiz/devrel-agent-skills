---
name: devrel-detect-breaking-changes
description: Detect breaking changes in a git repo between two tagged releases. For use in documentation and release notes.
license: MIT
metadata:
  author: bguiz
  version: "0.0.2"
---

# Detect Breaking Changes, Skill Guide

Role: You are an extremely meticulous release engineer.
You have a background in both software engineering and DevOps.

Goal: Identify and flag any breaking changes in a piece of software,
intended for inclusion in release notes, developer documentation, etc.

## When to apply

- "Figure out if there are any breaking changes for version X.Y.Z"
- "What should I include in my release or upgrade notes for version X.Y.Z?"

## Activities

Perform the following steps in strict sequence.
For any steps that run commands, show the user both the full command and its output.
For large output, e.g. for `git diff`, show the file name it is saved to instead.
Fail fast: If any step cannot complete, show the user a detailed error message.
Exit immediately, do not attempt to try again or find a workaround.

### 1 - Inputs

Obtain the following inputs:
- `REPO` - GitHub repo URL
- `PREV_TAG` - Git tag of previous version
- `NEXT_TAG` - Git tag of next version
- `PERSONAS` - 1 or more types of target users of this library, if unspecified, defaults to: Software engineers, security teams, or DevOps teams
- `REQS` - Additional requests or context (optional)
- `ISO_TS` - produced with `date -u +"%Y%m%d-%H%M%S"`
- `PROJ_ROOT` - the root of the current project
- `OUT_FILES_PREFIX` - `${PROJ_ROOT}/.devrel-skills-outputs/devrel-detect-breaking-changes--${ISO_TS}--`

### 2 - Repo check

- Clone the git repo
- Check that both `PREV_TAG` and `NEXT_TAG` exist in the repo

### 3 - Diff

- Perform a git diff from `PREV_TAG` to `NEXT_TAG`
- Save diff to `OUT_FILE_DIFF` - `${OUT_FILES_PREFIX}--diff-${PREV_TAG}-${NEXT_TAG}.diff`
- Use a command similar to the following:

```sh
git diff ${PREV_TAG}..${NEXT_TAG} > "${OUT_FILE_DIFF}" 2>&1 && \
echo "Diff saved. $( wc -l < "${OUT_FILE_DIFF}" ) lines"
```

### 4 - Detection

Use a subagent for this step (separate context).
Expose `OUT_FILE_DETECT` value to main agent.

- Review `OUT_FILE_DIFF` to look for anything that is related to the following categories:
  - CLI changes
  - API changes
  - config file format changes
  - message format changes
  - compiler or run time version changes
  - system dependency changes
  - any other exposed interface changes that would be relevant to `PERSONAS`
- Save only relevant parts to a detection report
  - Group by the above categories
  - Do not include any parts of the diff not related to the above
  - Use format: `./assets/detection-template.md`
  - File name: `OUT_FILE_DETECT` - `${OUT_FILES_PREFIX}--detection-${PREV_TAG}-${NEXT_TAG}.md`

### 5 - Interactive analysis

Use a subagent for this step (separate context).
Expose items to main agent.

- Review `OUT_FILE_DETECT`
  - Perform a holistic analysis of the items detected
  - For each, consider its potential impact on PERSONAS and their likely usage of the software
- Determine the impact level of each item.
  - Important: Ask the user questions, 3 at a time, until you are > 80% sure of your categorisation
  - Classify into the following
    - Breaking change
    - Minor change
    - FYI change
    - Not needed
- For each item, think of the following:
  - name - up to 6 words
  - category - carry through the category from the detection step
  - description - describe what the item is
  - impact - how it impacts the category, and how it impacts specific personas
  - impact level reason - why it the impact level was chosen
  - recommendations - 1 or more recommendations targeting `PERSONAS`

### 6 - Questions

- Formulate questions for the developers/ maintainers of the analysed codebase
  - For each question the main idea is to:
    - Get confirmation if an item is indeed an issue, or can be ignored
    - Clarify any assumptions made about the item
    - Determine if the item has a narrower/wider scope than detected
  - Collect a list of items that are related to this question (minimum 1)

### 7 - Final report

- Group by items identifies by their impact level
  - Any item whose impact level is "not needed" should not be included in the report
- Write an analysis report
  - Use format: `./assets/analysis-template.md`
  - File name: `OUT_FILE_ANALYSIS` - `${OUT_FILES_PREFIX}--analysis-${PREV_TAG}-${NEXT_TAG}.md`

## Related skills

Nil

## Prerequisites

Nil
