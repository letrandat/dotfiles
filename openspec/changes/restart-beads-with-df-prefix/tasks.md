# Implementation Tasks

## 1. Clean Existing Setup

- [x] 1.1 Remove `.beads` directory: `rm -rf .beads`

## 2. Initialize Fresh

- [x] 2.1 Initialize with df- prefix: `bd init -p df`
- [x] 2.2 Set sync branch to default: `bd config set sync.branch beads-sync`

## 3. Validation

- [x] 3.1 Verify configuration: `bd config list`
- [x] 3.2 Create test issue: `bd create "Test issue"`
- [x] 3.3 Verify df- prefix: `bd list` → confirmed `df-g2s`
- [x] 3.4 Close test issue: `bd close df-g2s`
- [x] 3.5 Check daemon status: `bd daemon --status` → new daemon PID 2375
