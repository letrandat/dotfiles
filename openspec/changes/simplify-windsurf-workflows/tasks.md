# Implementation Tasks

## 1. Prepare Gemini Package Structure

- [ ] 1.1 Create directory: `gemini/.gemini/antigravity/global_workflow/`
- [ ] 1.2 Verify directory created successfully

## 2. Move ALL Workflows to Gemini (Preserve Git History)

- [ ] 2.1 Move 15 dat-* workflows using `git mv .agent/workflows/dat-*.md gemini/.gemini/antigravity/global_workflow/`
- [ ] 2.2 Move 3 openspec workflows: `git mv .agent/workflows/openspec-*.md gemini/.gemini/antigravity/global_workflow/`
- [ ] 2.3 Move git-worktree: `git mv .agent/workflows/git-worktree.md gemini/.gemini/antigravity/global_workflow/`
- [ ] 2.4 Move sample_workflow: `git mv .agent/workflows/sample_workflow.md gemini/.gemini/antigravity/global_workflow/`
- [ ] 2.5 Move superpower-brainstorming: `git mv .agent/workflows/superpower-brainstorming.md gemini/.gemini/antigravity/global_workflow/`
- [ ] 2.6 Verify all 21 workflows moved: `ls gemini/.gemini/antigravity/global_workflow/ | wc -l` should show 21
- [ ] 2.7 Verify git history preserved: `git log --follow gemini/.gemini/antigravity/global_workflow/dat-beads.md`

## 3. Remove Unused Superpower Workflows

- [ ] 3.1 List all remaining superpower-* files in .agent/workflows/: `ls .agent/workflows/superpower-*.md`
- [ ] 3.2 Delete unused superpower workflows (12 files): `git rm .agent/workflows/superpower-*.md`
- [ ] 3.3 Verify only moved/deleted workflows, no orphans: `ls .agent/workflows/` should be empty

## 4. Delete .agent/workflows/ Directory

- [ ] 4.1 Verify directory is empty: `ls -la .agent/workflows/`
- [ ] 4.2 Remove directory: `git rm -r .agent/workflows/`
- [ ] 4.3 Verify deletion: `.agent/workflows/` should not exist

## 5. Enhance Brainstorming Workflow with AskUserQuestion Pattern

- [ ] 5.1 Edit `gemini/.gemini/antigravity/global_workflow/superpower-brainstorming.md`
- [ ] 5.2 Remove line 19: "- Ask questions one at a time to refine the idea"
- [ ] 5.3 Remove line 21: "- Only one question per message - if a topic needs more exploration, break it into multiple questions"
- [ ] 5.4 In Key Principles section, remove: "- **One question at a time** - Don't overwhelm with multiple questions"
- [ ] 5.5 Add new section after "The Process" titled "## Using Structured Questions (AskUserQuestion Pattern)"
- [ ] 5.6 Add example from this proposal interview (see design.md for template)
- [ ] 5.7 Add conceptual explanation of why the pattern works
- [ ] 5.8 Verify auto_execution_mode: 0 remains unchanged
- [ ] 5.9 Lint modified file: `markdownlint gemini/.gemini/antigravity/global_workflow/superpower-brainstorming.md`
- [ ] 5.10 Validate YAML frontmatter is correct

## 6. Remove Sync Scripts

- [ ] 6.1 Delete superpowers-sync: `git rm bin/.local/dotfiles-bin/superpowers-sync`
- [ ] 6.2 Delete claude-plugins-sync: `git rm bin/.local/dotfiles-bin/claude-plugins-sync`
- [ ] 6.3 Search for references in documentation: `rg -i "superpowers-sync|claude-plugins-sync" docs/ CLAUDE.md README.md`
- [ ] 6.4 Remove any references found from CLAUDE.md or documentation
- [ ] 6.5 Verify scripts removed: `ls bin/.local/dotfiles-bin/ | grep sync` should return nothing

## 7. Update Setup Script

- [ ] 7.1 Edit `setup.sh`
- [ ] 7.2 Remove line: `link_app_support "Antigravity" "Antigravity"`
- [ ] 7.3 Remove cleanup lines: `cleanup_legacy "$HOME/.config/Antigravity/User/settings.json"`
- [ ] 7.4 Remove cleanup line: `cleanup_legacy "$HOME/.config/Antigravity/User/keybindings.json"`
- [ ] 7.5 Verify `gemini` exists in PACKAGES array
- [ ] 7.6 Verify `antigravity` still exists in PACKAGES array (for settings.json/keybindings.json)
- [ ] 7.7 Test shell syntax: `bash -n setup.sh`

## 8. Remove Rewrite Workflow

- [ ] 8.1 Delete rewrite.md: `rm ~/.gemini/antigravity/global_workflows/rewrite.md`
- [ ] 8.2 Verify deletion: `ls ~/.gemini/antigravity/global_workflows/` should not show rewrite.md

## 9. Stow Gemini Package

- [ ] 9.1 Restow gemini package: `stow -R gemini`
- [ ] 9.2 Verify workflows symlinked: `ls -la ~/.gemini/antigravity/global_workflow/`
- [ ] 9.3 Verify symlinks point to dotfiles: `readlink ~/.gemini/antigravity/global_workflow/dat-beads.md`
- [ ] 9.4 Count workflows deployed: `ls ~/.gemini/antigravity/global_workflow/ | wc -l` should show 21

## 10. Validation

- [ ] 10.1 Run OpenSpec validation: `openspec validate simplify-windsurf-workflows --strict`
- [ ] 10.2 Lint all workflows: `markdownlint gemini/.gemini/antigravity/global_workflow/*.md`
- [ ] 10.3 Validate YAML frontmatter in all workflow files
- [ ] 10.4 Verify .agent/workflows/ deleted: `ls .agent/workflows/` should error
- [ ] 10.5 Verify 21 workflows in gemini package: `ls gemini/.gemini/antigravity/global_workflow/ | wc -l`
- [ ] 10.6 Verify 21 workflows stowed: `ls ~/.gemini/antigravity/global_workflow/ | wc -l`
- [ ] 10.7 Verify sync scripts removed: `ls bin/.local/dotfiles-bin/ | grep sync`
- [ ] 10.8 Verify rewrite.md removed: `ls ~/.gemini/antigravity/global_workflows/rewrite.md` should error
- [ ] 10.9 **Test Antigravity workflow discovery**: Open Antigravity and verify all 21 workflows appear in workflow list
- [ ] 10.10 **Verify Windsurf untouched**: `git status codeium/.codeium/windsurf/global_workflows/` should show no changes
- [ ] 10.11 Check git history preserved: `git log --follow gemini/.gemini/antigravity/global_workflow/dat-beads.md` shows history
- [ ] 10.12 Final commit message review: Ensure it lists all moved files and removed scripts

## 11. Documentation Update

- [ ] 11.1 Update CLAUDE.md to remove references to sync scripts
- [ ] 11.2 Add note about workflow location: "Antigravity workflows managed in gemini/.gemini/antigravity/global_workflow/"
- [ ] 11.3 Document manual workflow sync process if needed in future (copy files from gemini to desired location)
