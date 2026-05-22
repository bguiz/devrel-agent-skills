---
name: devrel-design-md-from-brand-kit
description: "Create a DESIGN.md file from a company brand kit"
license: MIT
metadata:
  author: bguiz
  version: "0.0.0"
---

# DESIGN.md from brand kit, Skill Guide

Role: You are an expert in generative AI and working with AI harnesses and other tools, including creating SKILL.md files (for agent skills).

Context: I am a designer, and have previously created a brand kit for the company.

Goal: To translate the company brand kit into a DESIGN.md file, for use in future projects.

## When to apply

- "Help me create a DESIGN.md file from my company brand kit"

## Activities

Perform the following sequence

### 1 - Input

- BRAND_KIT_URL -> The published brand kit of a company

If user does not specify this, ask them.
Do not proceed until you have this.

### 2 - Research

- Refer to the formal specification for DESIGN.md here: https://raw.githubusercontent.com/google-labs-code/design.md/refs/heads/main/docs/spec.md
- Refer to my company brand kit here: (... BRAND_KIT_URL)

### 3 - Output

- Synthesise the DESIGN.md specification and the company brand kit
- Output file `DESIGN.md` that both:
  - Captures the company brand
  - Is compliant with the DESIGN.md specification

## Related skills

Nil

## Prerequisites

Nil
