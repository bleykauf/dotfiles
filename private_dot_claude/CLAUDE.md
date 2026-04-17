# Claude Code Instructions

## Python Tooling
- Use `uv` for package management (`uv add`, `uv run`, etc.)
- Never suggest `pip install` directly — use `uv add` instead
- Assume a virtual environment managed by `uv`
- Use `ruff` for formatting and linting (`uv run ruff format`, `uv run ruff check`)

## Testing
- Use `pytest` for all tests
- Run tests with `uv run pytest`

## Explanations
- Explain key decisions when writing or refactoring code — why a particular approach was chosen, not just what it does
- Skip obvious narration; focus on non-trivial choices
