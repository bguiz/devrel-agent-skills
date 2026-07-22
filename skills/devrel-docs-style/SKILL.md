---
name: devrel-dev-docs-style
description: Audit and report adherence to developer documentation standards
license: MIT
metadata:
  author: bguiz, theletterf
  version: "0.0.3"
  activates_on: ["*.md", "*.mdx", "*.txt"]
  uses: []
---

# Developer Documentation Style, Skill Guide

Developer documentation (dev docs) is extremely important for a technology, as it is:
- often the 1st contact point for developer
- also the most frequent contact point when developers search for "how to do X" with a technology

This skill helps to validate consistency and quality of developer documentation.

## When to apply

- When assessing the quality of existing dev docs
- When adding or modifying new dev docs

See for detailed list of user stories: `./references/user-stories.md`
Their associated sample prompts: `./references/sample-prompts.md`

## Activities

Perform the following sequence

### 1 - Identify inputs

- Which type of English should be used?
  - Has the user specified the use of American English?
  - Otherwise default to British English.
  - Do *not* attempt to infer or guess this.
- Which files should be checked?
  - If this is a Github PR
    - Check all files that have been added or modified in the PR
    - Ignore any deleted files
  - If this skill is invoked manually
    - Any input arguments (e.g. `${ARGS}`) should be considered as either file names or file path globs
    - Check the explicitly specified files and files that match the glob

### 2 - Voice and tone

- Active voice - Prefer active over passive.
- Present tense - Write in present tense.
- Second person - Use "you/your/yours." Never use "I/me/my." Use "we" sparingly.
- No "please" - Avoid "please" in instructions.
- Contractions - Don't mix contractions with spelled-out equivalents in the same context. Avoid ambiguous contractions ("there'd," "it'll," "they'd").
- Concise sentences - Maximum 2 conjunctions per sentence. Split into multiple sentences.
- Informational tone - Be direct, neutral, and scannable. May use some friendly tones in tutorials.
- Latin abbreviations - Permitted. "e.g." and "for example" are both OK.

### 3 - Spelling

Based on the chosen type of English, do one of the following.

#### British English

- Identify any spelling errors
- Use -ise/-yse verbs, -our nouns, -ence nouns, -ogue nouns (organise, colour, licence, dialogue).

#### American English

- Identify any spelling errors
- Use -ize/-yze verbs, -or nouns, -ense nouns, -og nouns (organize, color, license, dialog).

### 4 - Grammar

- Oxford comma - Always use in lists of three or more.
- Abbreviations - Spell out on first use. Pluralize without apostrophes (APIs, SDKs, OSes).
- Capitalization - Sentence-style for headings. Capitalize proper nouns and product names only. Don't capitalize all words. Don't capitalize spelled-out acronyms unless proper nouns. Match UI capitalization.
- Hyphens: Compound adjectives before nouns (real-time results), two vowels together (re-enable), self-/ex-/all- prefixes. No hyphen for predicate adjectives ("up to date") or adverbs ending in -ly ("newly installed").
- Gerunds - Use in top-level task titles. Use action verbs in lower-level titles. Avoid gerunds in prepositional phrases ("how to configure" not "on configuring").
- Noun vs. verb compounds - backup/back up, login/log in, setup/set up, startup/start up.

### 5 - Formatting

- Inline code - Use monospaced font. In markdown, use single backticks.
- Multiline code - Use monospaced font in a dedicated code block. In markdown, use triple backticks and specify the language for syntax highlighting.
- Double quotation marks - Use to introduce unfamiliar term on first use. Use when quoting some text from elsewhere (UI, earlier instruction, error message, etc).
- Single quotation marks - Use only when there needs to be a quotation within another quotation, and only when absolutely needed. By default, avoid using them.
- Bold - Use for emphasis of terms.
- Italics - Use for emphasis of thoughts/ideas.
- Numbers - For 1 to 9 in as one to nine, e.g. `seven`. For 10 and above as numerals, e.g. `11`. For 1000 and above use commas per power of 1000, e.g. `1,234,567`.
- Unordered lists - Must have 2 or more items. Don't use periods unless they are full sentences. Paragraph preceding should end with a colon.
- Ordered lists - Same rules as unordered lists, plus: Use only when items must be in specified sequence.
- Paragraphs - Maximum 7 sentences.
- Headings - Use H1, H2, H3, and H4 headings. Avoid H5, and H6 headings. In markdown, use an empty line after the heading.
- Links - Avoid bare URLs. Avoid link text similar to "click here".

### 6 - Word choice

Replace poor phrase choices with preferred phrase choices,
in the list following this pattern:
poor phrase choice (qualifier) -> preferred phrase 1/ preferred phrase 2 (qualifier)

- abort/ kill/ terminate -> cancel/ stop/ exit
- boot -> start/ run
- mentioned above/ mentioned below -> (find another way to reference than by position on page)
- begin -> start
- blacklist -> blocklist
- whitelist -> allowlist
- cannot -> unable
- click -> press/ select (unless specifically referring to mouse-only actions)
- type -> input/ enter (when referring to entering text into a text field, etc.)
- execute -> run/ start
- hack -> workaround/ tip
- wrong -> incorrect
- launch -> open/ run
- utilize -> use
- see -> view/ look

### 7 - Generative AI writing styles

- Identify patterns
  - Read the input text carefully
  - Scan for the signs in `./references/gen-ai-writing-tells.md`
- Suggest edits
  - Use natural alternatives
  - Preserve meaning, the core message remains intact
  - Match the intended tone/ voice (formal, casual, technical, etc.)
- 2nd pass:
  - Think: "What makes the text seem AI generated?"
  - Think: "How to make it not seem AI generated?"
  - Update the list of suggested edits
- 3rd pass:
  - Think: "Does this sound natural when read aloud?"
  - Think: "Does this use specific details, instead of vague claims?"
  - Think: "Does the tone stay consistent throughout?"
  - Think: "Does the language sound simple or or overly complex/ academic?"
  - Update the list of suggested edits

### 8 - Compile a report

You now have a list of issues identified in the following categories:
Voice and tone, spelling, grammar, formatting, word choice, generative AI writing tells.
However, they are present in the order that they were discovered.
Rearrange them:
1. 1st: group all issues present in the same source file together
2. 2nd: arrange the issues in order of line number (per source file)
3. 3rd: merge issues the occur within same paragraph (same or adjacent line numbers) into a single issue
   - Optionally, use multiple diffs within the same issue,
     only if this aides with clarity;
     otherwise default to a single diff.

Use the following report format: See `./assets/dev-docs-report-template.md`

Save the report to `${PROJ_ROOT}/.devrel-skills-outputs/devrel-docs-style--report-${ISO_TS}.md`
where `PROJ_ROOT` is the root directory of the the current project, and
where `ISO_TS` is the current timestamp produced by running this shell command `date -u +"%Y%m%d-%H%M%S"`.
For example `/path/to/proj/.devrel-skills-outputs/devrel-docs-style--report-20260326-132726.md`

## Related skills

Nil

## Prerequisites

Nil

## Credits

See `./references/credits.md`
