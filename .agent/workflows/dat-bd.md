---
name: dat-bd
description: Beads task management using OSS contributor pattern
---

# Beads Task Management

## Overview

This project uses beads for task tracking.

## Creating Tasks with Rich Descriptions

**Always provide detailed task descriptions:**

```bash
# Use --description or -d flag for the task body (like Jira description)
bd create "Implement user authentication" -p 1 --description "$(cat <<'EOF'
## Context
Currently no auth system exists. Need to add JWT-based authentication.

## Scope
- User registration endpoint
- Login/logout endpoints
- JWT token generation and validation
- Middleware for protected routes

## Success Criteria
- Users can register and login
- Protected routes require valid JWT
- Tests pass
EOF
)"

# Or add description after creation
bd create "Task title" -p 1
bd update task-abc --description "Detailed description here..."
```

**Task structure (like Jira):**

- **Title**: Short summary (bd create "Title")
- **Description**: Full task body (--description flag)
- **Comments**: Updates/discussion (bd comment)

## Updating Task Progress

**When implementation plan changes significantly:**

```bash
# Use comments for progress updates
bd comment task-abc "$(cat <<'EOF'
## Progress Update
- Completed user registration endpoint
- Discovered we need password hashing (adding bcrypt)
- Updated scope: now includes email verification
EOF
)"
```

## Task Completion Policy

⚠️ **CRITICAL: Do NOT auto-close tasks**

**Problem:** Agents often think tasks are complete when they're not (tests fail, edge cases missed, user requirements not met).

**Rules:**

1. **NEVER** use `bd close` without asking first
2. When you think a task is done:
   - Report what you completed
   - Ask: "Should I close task task-abc?"
   - Wait for user confirmation
3. Only after user says "yes" or "close it": `bd close task-abc`

**Example:**

```
Agent: "I've implemented user authentication with JWT. All tests pass.
        Should I close task task-abc?"
User: "Yes, close it"
Agent: [runs bd close task-abc]
```

## Common Commands

```bash
# View tasks
bd list              # All tasks
bd ready             # Ready to work
bd show task-abc     # Task details

# Create with description
bd create "Title" -p 1 --description "Detailed description"

# Add/update description
bd update task-abc --description "Updated description"

# Add comments (for updates/discussion)
bd comment task-abc "Additional context or progress update"

# Update status (allowed)
bd update task-abc --status in_progress

# Close task (ASK FIRST!)
bd close task-abc --reason "Completed: implemented auth with tests"
```

## When to Use bd

**DO use bd when:**

- User explicitly asks to create/manage tasks
- User references task IDs (task-abc, dotfiles-xyz)
- User asks "what's ready?" or "show my tasks"

**DON'T use bd when:**

- Just implementing features (don't auto-create tasks)
- User hasn't mentioned task management
