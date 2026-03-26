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
- The path of the canonical language
- The path of the target language
- Optional: The exclusion paths of the canonical language
- Optional: The exclusion paths of the target language

## Activities

Perform the following sequence

### 1 - Validate inputs

All non-optional inputs should be processed and validated.

### 2 - git diff

Perform a git diff restricted to the subdirectory of the canonical language.

To do so, run script: `./scripts/git-diff.sh`

The script signature is:

```sh
CANONICAL_EXCLUSION_PATHS="<excl-path-1>:<excl-path-2>" \
  ./scripts/git-diff.sh <last-translation-commit> <canonical-lang-path> [file ...]
```

Where `CANONICAL_EXCLUSION_PATHS` is a colon-separated list of paths to exclude
(e.g. other language subdirectories that live under the canonical language path).

Example command 1:

```sh
CANONICAL_EXCLUSION_PATHS=".gitbook/cn:.gitbook/ko:.gitbook/jp" \
  ./scripts/git-diff.sh c12b45f .gitbook/
```

### 3 - Validation 2nd pass

If the git diff is empty, output an error message saying that there is nothing to translate, and exit.

### 4 - Translate

- Find the corresponding lines for the git diff within the target language.
- For each line that has a diff in the canonical language, make an equivalent diff for the target language
- The format should be a git diff patch file
  - Validate that the patch file is of the right format by performing a dry run
    - Command: `git apply --check ${PATCH_FILE}`
  - If the dry run fails, use its output to locate and fix errors in the diff file and retry
  - Maximum number of retries is 3; after which you should stop and throw an error, asking the user for manual intervention

Avoid the following:
- Do not translate technical terms or other terminology which should remain in the canonical language even in translations
- Do not translate code examples
- Do not translate URLs or file names
- Do not invent or assume - if the canonical language is ambiguous or confusing note it and skip

Example input 1:

- canonical language: (unspecified)
- target language: `cn`
- list of pages to translate: (unspecified)
- canonical language path: `.gitbook/`
- canonical language exclusion paths: `.gitbook/cn`, `.gitbook/ko`, `.gitbook/jp`
- target language path: `.gitbook/cn`
- target language exclusion paths: (unspecified)

```diff
diff --git a/.gitbook/developers-ai/mcp.mdx b/.gitbook/developers-ai/mcp.mdx
index 119f49e..425b19f 100644
--- a/.gitbook/developers-ai/mcp.mdx
+++ b/.gitbook/developers-ai/mcp.mdx
@@ -94,9 +94,34 @@ Once connected, you can ask your AI tool to perform queries and transactions on Injective.
 
 A list of all the available tools is available at
 [`github.com/InjectiveLabs/mcp-server`](https://github.com/InjectiveLabs/mcp-server?tab=readme-ov-file#tools).
+Alternatively, your MCP client can list all available tools and their descriptions.
```

Example output 1:

```diff
--- a/.gitbook/cn/developers-ai/mcp.mdx
+++ b/.gitbook/cn/developers-ai/mcp.mdx
@@ -94,9 +94,34 @@ 连接后，你可以让 AI 工具在 Injective 上执行查询和交易。

 所有可用工具的列表请参见
 [`github.com/InjectiveLabs/mcp-server`](https://github.com/InjectiveLabs/mcp-server?tab=readme-ov-file#tools)。
+或者，您也可以使用 MCP 客户端查看所有可用工具及其描述。
```

### 5 - Translation self-check

For various reasons (e.g. need clarification or decisions), if some parts of the translation need to be skipped, do the following:
- Output messages for the user that describe each issue (one message per issue)
- Give the user 3 options:
  - Cancel --> Exit immediately
  - Ignore --> Continue to the next step
  - Clarify or make changes --> Ask the user for further inputs, and update the translations accordingly (repeat the previous translate step, but only for specific areas), and finally repeat this translation self-check step.

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
