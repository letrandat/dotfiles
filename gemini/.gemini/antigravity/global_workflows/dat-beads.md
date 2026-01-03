---
name: dat-bd
description: Beads task management using redirect pattern
---

# Beads Task Management

## Overview

This project uses beads for task tracking.

## Creating Tasks with Rich Descriptions

**Always provide detailed task descriptions:**

```bash
# Use --description or -d flag for the task body (like Jira description)
bd create "Implement user authentication" -p 1 --description "$(
  cat <<'EOF'
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
bd comment task-abc "$(
  cat <<'EOF'
## Progress Update
- Completed user registration endpoint
- Discovered we need password hashing (adding bcrypt)
- Updated scope: now includes email verification
EOF
)"
```

## Task Completion Policy

**Policy:** Agents are authorized to close tasks when success criteria are met, but must explicitly report this to the user.

**Process:**

1. Verify all success criteria are met.
2. Run relevant verification steps (tests, manual checks in browser).
3. Close the task with a summary of work done: `bd close task-abc --reason "Completed: <summary>"`
4. **Report completion to the user** in the chat, summarizing what was done.

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

# Close task
# IMPORTANT: Always report completion to the user after closing
bd close task-abc --reason "Completed: implemented auth with tests"
```
