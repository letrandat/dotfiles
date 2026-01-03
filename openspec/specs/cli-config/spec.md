# cli-config Specification

## Purpose

TBD - created by archiving change allow-safe-commands. Update Purpose after archive.

## Requirements

### Requirement: Safe Command Auto-Approval

The Gemini CLI MUST be configured to execute specified "safe" shell commands without requiring user confirmation.

#### Scenario: Listing files

Given the project is configured with `ls` in the allowed list
When the agent executes `run_shell_command(command="ls -la")`
Then the command runs immediately without a confirmation prompt

#### Scenario: Checking git status

Given the project is configured with `git` in the allowed list
When the agent executes `run_shell_command(command="git status")`
Then the command runs immediately without a confirmation prompt

#### Scenario: Dangerous commands still prompt

Given `rm` is NOT in the allowed list
When the agent executes `run_shell_command(command="rm file.txt")`
Then the CLI prompts the user for confirmation
