# AGENTS.md

This file provides default instructions for coding agents working in this environment.

Repo-specific `AGENTS.md` files override this baseline. When multiple project instructions apply, prefer the most local file relevant to the files being changed.

## Core Approach

- Understand the task and the codebase before editing.
- Prefer the smallest change that correctly solves the problem.
- Match the repository's existing style, structure, and tooling.
- Preserve current behavior unless the requested change requires otherwise.
- State assumptions clearly when they materially affect the result.

## First Steps In Any Repository

1. Read the nearest relevant `AGENTS.md` files.
2. Inspect the repo layout and key project files before making changes.
3. Check the current git status before editing.
4. Identify the project's existing test, build, lint, and formatting commands.
5. Confirm which files are actually in scope; avoid broad refactors unless requested.

## Code Changes

- Reuse existing helpers, patterns, and libraries before introducing new ones.
- Keep diffs focused and easy to review.
- Do not rename, move, or reorganize files unless there is a clear payoff.
- Avoid adding dependencies unless necessary and justified by the task.
- Write clear code first; add comments only where intent is not obvious.
- When changing interfaces, update all affected call sites, tests, and docs.
- For user-facing behavior changes, update documentation or examples if the repo maintains them.

## File Handling

- Prefer fast search tools such as `rg` and `rg --files`.
- Read files in manageable chunks; do not assume file contents.
- Avoid rewriting entire files when a targeted edit is sufficient.
- Treat generated files, lockfiles, and vendored code as special-case files; edit them only when required.
- Never overwrite or discard user changes you do not understand.

## Validation

- Run the smallest meaningful validation that covers the change.
- Expand validation when the change affects multiple layers or shared code.
- If tests already fail, distinguish pre-existing failures from regressions caused by the change.
- If validation cannot be run, say exactly what was not verified and why.
- Do not claim success without some form of verification when verification is possible.

## Git And Safety

- Do not use destructive git commands unless explicitly requested.
- Do not revert unrelated changes in a dirty worktree.
- Keep commits focused if the user asks for commits.
- Avoid amending or force-pushing unless explicitly requested.
- Surface security, data-loss, or migration risks clearly.

## Communication

- Give short progress updates during longer tasks.
- Be concise and factual.
- Summarize what changed, how it was validated, and any remaining risks.
- Reference concrete files and commands when useful.
- Ask questions only when a necessary decision cannot be made safely from context.

## Practical Heuristics

- Use the package manager and toolchain already chosen by the repository.
- Prefer existing CI, scripts, or task runners over inventing new commands.
- Follow the established test style and fixture patterns.
- For frontend work, preserve the project's visual language unless a redesign is requested.
- For backend or data work, be explicit about schema, compatibility, and rollout implications.

## Default Output Expectations

When finishing a task, provide:

1. A short summary of the change.
2. The validation performed.
3. Any notable assumptions, limitations, or follow-up work.
