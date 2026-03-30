cue() {
  local subcmd="${1:-}"

  case "$subcmd" in

    plan)
      local tool="${2:-claude}"
      mkdir -p specs
      if [[ ! -f specs/task.md ]]; then
        cat > specs/task.md << 'EOF'
## Goal


## Acceptance Criteria
- [ ]

## Validation
- [ ]
EOF
      fi
      local prompt="PLANNING ONLY. DO NOT IMPLEMENT.

1. Ask what I want to build
2. Search codebase for existing patterns first
3. Interview with detailed questions (1-4 at a time)
4. Generate specs/task.md
5. When done: \"Planning complete. Run cue go to implement.\""
      case "$tool" in
        opencode) opc "$prompt" ;;
        codex)    cdx "$prompt" ;;
        claude|*) cld "$prompt" ;;
      esac
      ;;

    go)
      [[ -f specs/task.md ]] || { echo "specs/task.md not found, run \`cue plan\` first"; return 1; }
      local tool="${2:-codex}"
      mkdir -p specs
      local task instructions
      task="$(cat specs/task.md)"
      read -r -d '' instructions << 'EOF'

1. This is an unattended orchestration session. Never ask a human to perform follow-up actions.
2. Only stop early for a true blocker (missing required auth/permissions/secrets). If blocked, record it in the workpad.
3. Final message must report completed actions and blockers only. Do not include "next steps for user".

Work only in the current repository. Do not touch any other path.

## Posture

- Start every task by opening specs/workpad.md and bringing it up to date before doing new implementation work.
- Spend extra effort up front on planning and verification design before implementation.
- Reproduce first: always confirm the current behavior/issue signal before changing code so the fix target is explicit.
- Use specs/workpad.md for all progress and handoff notes; do not create separate summary files.
- Treat any task-authored Validation section as non-negotiable: mirror it in the workpad and execute it before considering the work complete.
- When meaningful out-of-scope improvements are discovered, add them to TODO.md instead of expanding scope.
- Operate autonomously end-to-end unless blocked by missing requirements, secrets, or permissions.

## Execution

1. Find or create specs/workpad.md (reuse if it exists, never create a second one).
2. If arriving fresh, do not delay: begin reconciling the workpad immediately.
3. Immediately reconcile the workpad before new edits: check off items that are already done, expand the plan so it is comprehensive for current scope, and ensure Acceptance Criteria and Validation are current and still make sense.
4. Start work by writing or updating a hierarchical plan in the workpad.
5. Ensure the workpad includes a compact environment stamp at the top as a code fence: `<host>:<abs-workdir>`
6. Add explicit acceptance criteria and TODOs in checklist form.
7. Run a principal-style self-review of the plan and refine it before writing any code.
8. Before implementing, capture a concrete reproduction signal and record it in the workpad Notes.
9. Sync with latest origin before any code edits, then record the sync result in the workpad Notes.
10. Implement against the hierarchical TODOs and keep the workpad current:
    - Check off completed items immediately.
    - Add newly discovered items in the right section.
    - Update after each meaningful milestone.
11. Run all Validation items. Revert every temporary proof edit before finishing.

## Workpad template

Use this exact structure for specs/workpad.md:

---

## Codex Workpad

```text
<host>:<abs-workdir>
```

### Plan

- [ ] 1\. Parent task
  - [ ] 1.1 Child task

### Acceptance Criteria

- [ ] Criterion 1

### Validation

- [ ] targeted tests: `<command>`

### Notes

- <short progress note with timestamp>

### Confusions

- <only when something was confusing during execution>

---
EOF
      local prompt="You are working on this task:

${task}

Instructions:

${instructions}"
      echo "go: [$(git branch --show-current 2>/dev/null)]"
      case "$tool" in
        opencode) echo "warning: opencode has no sandbox"; opc "$prompt" ;;
        claude)   echo "warning: claude has no sandbox";   cld "$prompt" ;;
        codex|*)  codex --profile auto "$prompt" ;;
      esac
      ;;

    *)
      echo "usage: cue plan [claude|codex|opencode]"
      echo "       cue go   [claude|codex|opencode]"
      ;;

  esac
}
