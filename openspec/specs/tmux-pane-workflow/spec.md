# tmux-pane-workflow Specification

## Purpose

TBD - created by archiving change claude-primary-workspace. Update Purpose after archive.

## Requirements

### Requirement: Pane Toggle Keybind

The system SHALL provide a Cmd+L keybind that toggles between Claude (pane 1) and Neovim (pane 2) panes with automatic zoom.

#### Scenario: Toggle from Claude to Neovim (first time)

**Given** a tmux window with only pane 1 (Claude Code) currently zoomed
**When** the user presses Cmd+L
**Then** the system shall:

- Create pane 2 as a vertical split (right side) if it doesn't exist
- Use the same working directory as pane 1 (#{pane_current_path})
- Select pane 2
- Zoom pane 2
- Leave the new pane as an empty terminal (user manually launches nvim)

#### Scenario: Toggle from Claude to Neovim (pane exists)

**Given** a tmux window with panes 1 and 2, and pane 1 (Claude) is currently zoomed
**When** the user presses Cmd+L
**Then** the system shall:

- Select pane 2
- Zoom pane 2

#### Scenario: Toggle from Neovim back to Claude

**Given** a tmux window with panes 1 and 2, and pane 2 (Neovim) is currently zoomed
**When** the user presses Cmd+L
**Then** the system shall:

- Select pane 1
- Zoom pane 1

#### Scenario: Toggle when both panes visible (unzoomed)

**Given** a tmux window with panes 1 and 2, both visible and unzoomed
**And** focus is currently in pane 1
**When** the user presses Cmd+L
**Then** the system shall:

- Select pane 2
- Zoom pane 2

#### Scenario: Repeated toggling

**Given** a tmux window with panes 1 and 2
**When** the user presses Cmd+L multiple times in succession
**Then** the system shall alternate between pane 1 and pane 2, always zooming the target pane

### Requirement: Pane Visual Labeling

The system SHALL display visual labels in pane borders to identify each pane's purpose.

#### Scenario: Pane 1 border label

**Given** a tmux window with at least pane 1
**When** pane borders are visible (pane-border-status enabled)
**Then** pane 1's border shall display "1(ai)"

#### Scenario: Pane 2 border label

**Given** a tmux window with pane 2 created
**When** pane borders are visible
**Then** pane 2's border shall display "2(nvim)"

#### Scenario: Labels visible when unzoomed

**Given** a tmux window with panes 1 and 2 both visible (unzoomed)
**When** pane-border-status is set to "top" or "bottom"
**Then** both panes shall show their respective labels in borders

#### Scenario: Labels hidden when zoomed

**Given** a tmux window with pane 1 zoomed
**When** the pane fills the entire window
**Then** pane borders shall not be visible (standard tmux zoom behavior)

### Requirement: Lazy Pane Creation

The system SHALL defer creation of pane 2 (Neovim) until the user first presses Cmd+L, minimizing resource usage.

#### Scenario: Initial session state

**Given** a new tmux session or window
**When** the user starts Claude Code in the first pane
**Then** only pane 1 shall exist (no pane 2 created automatically)

#### Scenario: Pane 2 created on demand

**Given** a tmux window with only pane 1
**When** the user presses Cmd+L for the first time
**Then** the system shall create pane 2 as a 50/50 vertical split

#### Scenario: Empty terminal on creation

**Given** pane 2 is being created for the first time
**When** the split completes
**Then** pane 2 shall contain an empty shell prompt (not automatically launch nvim)

### Requirement: Error Recovery for Missing Panes

The system SHALL gracefully handle cases where panes are manually killed and auto-recover when possible.

#### Scenario: Pane 2 manually killed

**Given** a tmux window previously had panes 1 and 2, but pane 2 was manually killed (prefix b d)
**And** only pane 1 remains
**When** the user presses Cmd+L from pane 1
**Then** the system shall recreate pane 2 as if it never existed (same as first-time creation)

#### Scenario: Pane 1 manually killed (from pane 2)

**Given** a tmux window previously had panes 1 and 2, but pane 1 was manually killed
**And** only pane 2 remains (now becomes pane 1 due to renumbering)
**When** the user presses Cmd+L
**Then** the system shall create a new pane 2 (right split) and zoom to it

**Note**: Tmux renumbers panes when one is killed. If pane 1 is killed, pane 2 becomes pane 1. The toggle logic should still create a pane 2 in this case.

### Requirement: Strict 2-Pane Model

The system SHALL enforce a 2-pane maximum for this workflow, relying on tmux windows for additional tools.

#### Scenario: Toggle in window with 3+ panes

**Given** a tmux window with 3 or more panes (user manually created extras)
**When** the user presses Cmd+L from pane 1
**Then** the system shall:

- Select pane 2 (if it exists)
- Zoom pane 2
- **NOT** create a 4th pane or modify panes beyond 1 and 2

#### Scenario: Toggle from pane 3 in multi-pane setup

**Given** a tmux window with panes 1, 2, and 3
**And** the user is currently in pane 3
**When** the user presses Cmd+L
**Then** the system shall toggle to pane 1 or 2 (depending on last active), ignoring pane 3's existence

**Note**: The toggle logic targets pane indices 1 and 2 exclusively. Behavior from pane 3+ is best-effort (likely goes to pane 1).

### Requirement: Cross-Window Behavior

The system SHALL apply the 2-pane workflow logic to any tmux window, not just a designated "workspace" window.

#### Scenario: Cmd+L in empty window (edge case)

**Given** a tmux window with no panes (edge case, should not normally occur)
**When** the user presses Cmd+L
**Then** the system shall either:

- Do nothing (no-op)
- OR display a tmux error message

**Note**: Tmux windows always have at least 1 pane, so this is a theoretical edge case.

#### Scenario: Cmd+L in single-pane window

**Given** a tmux window with 1 pane (any arbitrary pane, not necessarily Claude)
**When** the user presses Cmd+L
**Then** the system shall:

- Create pane 2 as a vertical split (right side)
- Select pane 2
- Zoom pane 2

#### Scenario: Cmd+L in standard 2-pane window

**Given** a tmux window with exactly 2 panes
**When** the user presses Cmd+L
**Then** the system shall toggle between pane 1 and pane 2 as normal

#### Scenario: Cmd+L in 3+ pane window (no 3rd pane creation)

**Given** a tmux window with 3 or more panes
**When** the user presses Cmd+L
**Then** the system shall NOT create additional panes beyond the existing ones

### Requirement: Working Directory Inheritance

The system SHALL ensure newly created panes inherit the working directory of the source pane.

#### Scenario: Pane 2 inherits Claude's cwd

**Given** pane 1 (Claude) has working directory `/Users/dat/workspace/dotfiles`
**When** the user presses Cmd+L and pane 2 is created
**Then** pane 2's initial working directory shall be `/Users/dat/workspace/dotfiles`

**Implementation**: Use tmux's `#{pane_current_path}` in split-window command.

### Requirement: Ghostty Keybind Integration

The system SHALL configure Ghostty to send the appropriate tmux command sequence when Cmd+L is pressed.

#### Scenario: Ghostty sends tmux command on Cmd+L

**Given** Ghostty is configured with `keybind = super+l=text:\x02<sequence>`
**When** the user presses Cmd+L in Ghostty
**Then** Ghostty shall send the text sequence to the terminal (tmux)

#### Scenario: Cmd+L works regardless of which pane has focus

**Given** the user is in either pane 1 or pane 2
**When** Cmd+L is pressed
**Then** Ghostty sends the tmux command, and tmux routes to the correct handler

**Note**: Tmux receives the keybind, not the application inside the pane (e.g., Neovim).

### Requirement: Pane Split Ratio

The system SHALL create pane splits with a 50/50 ratio (equal width).

#### Scenario: Equal split width

**Given** a tmux window with pane 1 taking full width
**When** pane 2 is created via Cmd+L
**Then** the window shall be split into two equal-width panes (50% each)

**Implementation**: Use `split-window -h` without `-p` percentage flag (defaults to 50/50).

### Requirement: Configuration Inline Documentation

The system SHALL include clear inline comments in configuration files explaining the 2-pane workflow.

#### Scenario: Tmux config comments

**Given** the tmux.conf file
**When** a developer reads the pane toggle section
**Then** comments shall explain:

- Purpose: Claude-primary 2-pane model
- Pane assignments: 1=AI, 2=Neovim
- Usage: Cmd+L toggle behavior
- Edge cases: lazy creation, error recovery, cross-window

#### Scenario: Ghostty config comments

**Given** the Ghostty config file
**When** a developer reads the Cmd+L keybind
**Then** comments shall explain that Cmd+L toggles between AI and editor panes

### Requirement: No Interference with Existing Keybinds

The system SHALL NOT modify or conflict with existing tmux or Ghostty keybinds.

#### Scenario: Cmd+e still works (nvim-integrated Claude)

**Given** the existing Cmd+e keybind (`super+e=text:\x1be`)
**When** the user presses Cmd+e in a Neovim pane
**Then** Neovim's integrated Claude toggle shall activate (independent of pane workflow)

#### Scenario: Tmux prefix keybinds unchanged

**Given** existing tmux keybinds: `prefix w v` (split), `prefix ,` (choose-tree), `prefix h/l` (window nav)
**When** the user uses these keybinds
**Then** they shall function exactly as before (no regressions)

### Requirement: Pane Border Status Visibility

The system SHALL configure tmux to display pane borders with labels at the top of each pane.

#### Scenario: Border position

**Given** tmux pane-border-status is configured
**When** panes are visible
**Then** borders shall appear at the top of each pane (not bottom, not hidden)

**Implementation**: `set -g pane-border-status top`
