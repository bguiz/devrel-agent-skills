# Detect Breaking Changes - Detect Relevant Items Report

## Summary

- X total items found
- Breakdown:
  - (... category): N items
  - (... more categories)
- Files involved:
  - (... glob or file path within repo)
  - (... more files or globs)

## Items by category

### (... category)

(... describe item, and reason for inclusion/ relevance)

```diff
- (... current line)
+ (... proposed replacement line)
```

(... optional: insert more diffs)

(... insert more issues)

(... insert more categories)

----

> Detection performed by `devrel-detect-breaking-changes` for:
> - Git repo: `${REPO_URL}`
> - Git tag previous: `${PREV_TAG}`
> - Git tag next: `${EXT_TAG}`
