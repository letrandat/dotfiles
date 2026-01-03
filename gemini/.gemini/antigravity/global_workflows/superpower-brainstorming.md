---
description: You MUST use this before any creative work - creating features, building components, adding functionality, or modifying behavior. Explores user intent, requirements and design before implementation.
auto_execution_mode: 0
---

# Brainstorming Ideas Into Designs

## Overview

Help turn ideas into fully formed designs and specs through natural collaborative dialogue.

Start by understanding the current project context, then ask questions to refine the idea. Once you understand what you're building, present the design in small sections (200-300 words), checking after each section whether it looks right so far.

## The Process

**Understanding the idea:**

- Check out the current project state first (files, docs, recent commits)
- Ask questions to refine the idea - multiple questions together when they explore related concerns
- Prefer multiple choice questions when possible, but open-ended is fine too
- Focus on understanding: purpose, constraints, success criteria

**Exploring approaches:**

- Propose 2-3 different approaches with trade-offs
- Present options conversationally with your recommendation and reasoning
- Lead with your recommended option and explain why

**Presenting the design:**

- Once you believe you understand what you're building, present the design
- Break it into sections of 200-300 words
- Ask after each section whether it looks right so far
- Cover: architecture, components, data flow, error handling, testing
- Be ready to go back and clarify if something doesn't make sense

## After the Design

**Documentation:**

- Write the validated design to `docs/plans/YYYY-MM-DD-<topic>-design.md`
- Use elements-of-style:writing-clearly-and-concisely skill if available
- Commit the design document to git

**Implementation (if continuing):**

- Ask: "Ready to formalize this?"
- Option A (Simple): "Create Beads tasks directly?" -> Use `/dat-plan-to-beads`
- Option B (Rigorous): "Create OpenSpec Proposal?" -> Use `/openspec-from-design`

  - Then, once validated, use `/beads-from-openspec`

- Ask: "Ready to set up for implementation?"
- Use superpowers:using-git-worktrees to create isolated workspace
- Use superpowers:writing-plans to create detailed implementation plan

After completing this workflow, emit completion state:

<!-- WORKFLOW-STATE: brainstorming-complete -->
<!-- BEADS-EPIC: task-xyz -->

## Using Structured Questions (AskUserQuestion Pattern)

When interviewing users, structure questions for clarity and efficiency using the pattern pioneered by Claude's AskUserQuestion tool:

**Pattern Structure:**

- **Header**: Short category label (8-12 chars) for quick scanning (e.g., "Discovery", "Tech stack", "Migration doc")
- **Question**: Clear, specific question that ends with "?"
- **Options**: 2-4 choices, each with:
  - **Label**: Concise choice name (1-5 words)
  - **Description**: Explains implications or what this option means
- **MultiSelect**: Allow selecting multiple options when choices aren't mutually exclusive

**Why This Pattern Works:**

- **Categorization**: Headers help organize complex discussions
- **Clarity**: Label + description format makes trade-offs explicit
- **Efficiency**: Users can answer multiple related questions quickly
- **Informed decisions**: Descriptions explain consequences before choosing

**Example from This Proposal:**

```
Question: "Should .agent/workflows/ only contain brainstorming, or be completely empty?"
Header: "Agent cleanup"
Options:
  - Label: "Only superpower-brainstorming.md remains"
    Description: "Keep the Antigravity brainstorming workflow in .agent/workflows/"

  - Label: "Delete .agent/workflows/ directory entirely"
    Description: "Since everything moves to gemini, remove the directory"

  - Label: "Keep .agent/workflows/ but only for generated/dynamic workflows"
    Description: "Use it as a workspace for workflows created during runtime"
```

The user selected "Delete .agent/workflows/ directory entirely", which led to discovering this was the cleanest architectural approach.

**When to Use:**

- Exploring multiple valid approaches
- Clarifying architectural decisions
- Understanding user preferences on implementation details
- Any time trade-offs need to be evaluated

## Key Principles

- **Multiple choice preferred** - Easier to answer than open-ended when possible
- **YAGNI ruthlessly** - Remove unnecessary features from all designs
- **Explore alternatives** - Always propose 2-3 approaches before settling
- **Incremental validation** - Present design in sections, validate each
- **Be flexible** - Go back and clarify when something doesn't make sense
