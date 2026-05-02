### code style

- write extremely easy to consume code, optimize for readability
- make code skimmable with clear names and early returns
- always strive for concise, simple solutions over clever ones
- if a problem can be solved in a simpler way, propose it

### universal rules

- no emojis in output or comments
- no em dashes: use hyphens or colons
- no legacy code preservation or fallbacks
- comments lowercase; function comments start uppercase
- no review/summary markdown files unless asked
- run linter, type checker, and build before completing any task

### workflow

- create persistent runnable snippets to test modules (not ephemeral strings)
- tests must pass before task completion
  - if tests are broken: separate PR to fix them first, then resume original task
- ask clarifying questions, then proceed autonomously
- ask for help only for: long scripts (>2min), sudo, or blockers
- if asked to do too much work at once, stop and state that clearly

### python

- use `uv` for all tooling (run, venv, pip install)
- type check: `uvx pyright`, lint: `ruff check`
- target: python 3.12

### rust

- toolchain: stable
- always build with `--release`

### tool preferences

- file search: `fd` (not `find`)
- code search: `rg`
- data: `jq` for JSON, `yq` for YAML/XML
- deterministic select: `fzf --filter 'term' | head -n 1`

### integrations

- **btca**: `btca ask -r <resource> -q "<question>"` (trigger: user says "use btca")
- **context7**: call `resolve-library-id` first, then `query-docs`
