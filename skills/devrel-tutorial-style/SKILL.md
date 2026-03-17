---
name: devrel-dev-tutorial-style
description: Audit and report adherence to developer tutorial standards
activates_on: ["*.md", "*.mdx", "*.txt"]
uses: ["devrel-docs-style"]
license: MIT
metadata:
  author: bguiz
  version: "0.0.0"
---

# Developer Tutorial Style, Skill Guide

Developer tutorials are extremely important for a technology,
as they are a guided way to show/teach a developer how to build using your technology,
and a key way to allow developers to try/discover the technology for themselves .

This skill helps to validate consistency and quality of developer tutorials.

## When to apply

- When assessing the quality of existing developer tutorials
- When adding or modifying new developer tutorials

See for detailed list of user stories: `./references/user-stories.md`
Their associated sample prompts: `./references/sample-prompts.md`

## Activities

Perform the following sequence

### 1 - Check section layout

These bullet points should each be H2 headings for each section.
Their sub-bullet points describe what should be in each section.

- (no heading)
  - Include a bullet point list of 3-5 items for "what we will learn"
- Prerequisites
  - Software or dev tools that are needed before proceeding
  - Commands to check if they exist, and are the correct version
  - Links to installation instructions
- Get started
  - Link to the accompanying code repo
  - Instructions to make a copy of the repo, e.g. git clone, at the starting point i relevant
- (...title of instructions step N)
  - Specific instructions for each step in the tutorial
  - Each step should have up to 3 instructions
  - If there are more steps, consider splitting into more sections
- (...title of info step N)
  - Description of key concepts without any specific instructions
  - Required for 1 or more of the steps in the tutorial
  - Minimise repetition from main dev docs, instead quote/summarise from it, with link to the relevant dev docs page
- Next steps
  - Congratulate the reader for completing the tutorial
  - Include a bullet point list of 3-5 items for "what we have learnt", based on on "what we will learn" in intro with variations allowed
  - If this is a series, link to the next tutorial in the same series (chronological order)
  - If completing this tutorial imparts skills or knowledge that now "unlocks" other tutorials, link to those

Note that between "get started" and "next steps" sections:
- there should be at least 3 instructions steps
- info steps are optional
- there should not be 2 or more consecutive info steps
- there can be as many consecutive instructions steps as needed

### 2 - Check that all components are present

- Is there a code repo that accompanies the written tutorial, and is it linked?
- Is there a demo video that accompanies the written tutorial, and is it linked?

### 3 - Check each section for potential developer friction points

- If an instruction contains a command or other developer tool that was not listed in the pre-requisites
- If an instruction is not possible unless their order is changed
- If an instruction has overly complex description, commands, code modifications
- If the total length of the tutorial is too long, aim for
  - < 5 mins read time
  - < 20 mins time to follow along 
  - If above these limits, consider splitting tutorial into multiple ones in a series

### 4 - Check adherence to dev docs style

Invoke the `devrel-docs-style` skill.

### 5 - Compile a report

Use the following report format: See `./assets/dev-tutorial-report-template.md`

## Related skills

- devrel-docs-style

If the above skills are not available, install them using:

```shell
npx skills add bguiz/devrel-agent-skills --skill devrel-docs-style
```

## Prerequisites

Nil
