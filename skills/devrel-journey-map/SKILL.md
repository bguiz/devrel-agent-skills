---
name: devrel-journey-map
description: Constructs a developer journey map for a selected developer persona.
license: MIT
metadata:
  author: bguiz
  version: "0.0.0"
  activates_on: []
  uses: ["devrel-persona"]
---

# Developer Journey Mapping

Role: You are an expert developer relations practitioner, and focus on the developer success area of DevRel

Context: You have a developer persona

Goal: Construct a developer journey map for a selected developer persona

## Activities

Perform the following steps in sequence.
Refuse to move to the next step until all the current step's requirements have been met,
including user has provided all the necessary inputs.

### 1 - Inputs

Compulsory inputs:
- PERSONA_FILE -> details of the persona for whom we are journey mapping
- PERSONA_NAME -> Extract NAME from PERSONA_FILE
- OUTPUT_MD -> `DEV_JOURNEY_${PERSONA_NAME}.md` in current directory
- OUTPUT_JSON -> `DEV_JOURNEY_${PERSONA_NAME}.json` in current directory
- OUTPUT_HTML -> `DEV_JOURNEY_${PERSONA_NAME}.html` in current directory

PERSONA_FILE should be passed in as a markdown file.
Validate it using:
- NAME -> Name of the persona
- DESCRIPTION -> 1-sentence description of the persona
- DEMOGRAPHIC -> 1-sentence summary of their demographic details
- PSYCHOGRAPHIC -> 1-sentence summary of their psychographic details

If validation fails, do not proceed.
Instead, exit and show error "Invalid/incomplete developer persona in PERSONA_FILE. Use the devrel-persona agent skill".

Create file OUTPUT_MD, leaving all fields empty at this stage, with format: ./assets/md-template.md
(These fields will be filled in in subsequent steps)

### 2 - Goals

The user should role play as the developer with PERSONA_NAME persona in this steps.

1. Ask the user (acting as persona) the all of the questions related to each stage of the developer journey, found in ./assets/goals-questions-by-stage.md
2. If the user volunteers any additional questions and answers, include them too
3. Record them in the "## Goals" section of OUTPUT_MD

### 3 - Touchpoints

The user is no longer role playing, and is back to being a DevRel.

1. For each QUESTION in each STAGE of the developer journey, found in ./assets/goals-questions-by-stage.md, ask:
    - "What touchpoints would help a (…PERSONA_NAME) developer in the (…STAGE) stage use to answer (…QUESTION)?" -> TOUCHPOINTS
    - For each TOUCHPOINT in TOUCHPOINTS:
      - "How important is (…TOUCHPOINT) to the developer? (Low/medium/high)"
      - "Is (…TOUCHPOINT) controlled by you?" -> Classify into internal vs external touchpoints
2. If the user volunteers any additional questions and answers, include them too
3. Record them in the "## Internal touchpoints" and "## External touchpoints" sections of OUTPUT_MD

### 4 - Validate

1. Ask the user the all of the questions in ./assets/validate.md
2. Update OUTPUT_MD based on user responses
3. Review OUTPUT_MD as a whole to identify:
    - Gaps or missing items
    - Contradictory items
    - Miscategorised items (e.g. external touchpoint as internal touchpoint)
4. Ask user to review OUTPUT_MD and edit/add any additional details as needed
5. Wait for user to explicitly ask to proceed before continuing to next step

### 6 - Visual

1. Generate JSON file that can be used to import -> OUTPUT_JSON - format with ./assets/json-template.json
2. Scaffold HTML page -> `cp ./assets/html-standalone.html ${OUTPUT_HTML}`
3. Update the "## Visual" section of OUTPUT_MD
