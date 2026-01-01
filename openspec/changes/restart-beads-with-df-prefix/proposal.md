# Change: Initialize Dedicated Beads Instance with df- Prefix

## Why

Set up a dedicated beads instance for the dotfiles repository with the `df-` prefix, replacing the current redirect to the shared beads-planning location. This provides task management that lives directly within the dotfiles repo.

## What Changes

- Remove existing `.beads` directory (currently redirects to shared location)
- Initialize fresh beads instance with `df-` prefix
- Configure for local dotfiles task management

## Impact

- Affected specs: `task-management`
- Affected files: `.beads/` directory (removed and recreated)
- Dotfiles will have its own isolated task management
- Previous shared tasks remain in beads-planning (unaffected)
