---
description: Scaffolds a new OpenSpec change from an existing design document with strict requirement extraction
---

# OpenSpec from Design

## Overview

Converst a Design Document or context into a structured, **verification-ready** OpenSpec Proposal.
This workflow acts as a **Technical Analyst**, extracting explicit requirements from the design source so that the resulting specs are self-contained.

## Steps

### 1. Analyze & Extract

1. **Identify Input**: Locate the design document (e.g., `docs/plans/foo.md`) or review the current context.
2. **Deep Read**: Read the content.
3. **Extraction**:
   - Identify **Intent** (The "Why").
   - Identify **Constraints** (The "Must Haves").
   - Identify **Verification Points** (How to test).

### 2. Delegate to Proposal

Invoke the `/openspec-proposal` workflow with specific instructions:

> "Create an OpenSpec proposal.
> **Source Context**: [Content of Design Doc] > **Constraint**: Generate **self-contained specs**.
> Do not write 'refer to design doc'.
> Instead, **COPY** the specific tables, rules, and logic into the corresponding `specs/*.md` files.
> Every spec must be verifiable on its own."

### 3. Review & Refine

1. **Validation**: Run `openspec validate <id> --strict`.
2. **Quality Check**:
   - Open `specs/subdir/spec.md`.
   - Does it describe _what_ to build explicitly?
   - If it just says "See design", **REJECT IT** and refine the spec file manually to include the details.
3. **Prompt User**:
   - "I have scaffolded the specs. Please review `specs/` to ensure all design constraints are captured explicitly."

### 4. Handoff

Once validated, stop. Do not implement.
Instruct the user: "Ready for implementation. Run `/dat-spec-to-tasks` to generate work items."
