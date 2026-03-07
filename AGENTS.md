# AGENTS.md

Default instructions for coding agents working in this environment.

## Scope And Precedence

- More local `AGENTS.md` files override less local ones.
- Unless a more local file overrides a rule, applicable parent instructions still apply.
- Direct user instructions and any higher-priority runtime, platform, or tool instructions take precedence over any `AGENTS.md`. If they directly conflict with an applicable `AGENTS.md` rule, follow the higher-priority instruction and call out the conflict.

## Core Principles

- Understand the task and the relevant code or documents before editing.
- Prefer the smallest correct change.
- Match the existing style, structure, and tooling of the project.
- Preserve current behavior unless the task requires changing it.
- Prefer discovery over inference. Check the most likely authoritative sources first, trace relevant declarations, call sites, and configs when they affect the answer, and stop when additional digging is unlikely to change the answer.
- For implementation tasks, continue through code changes and validation when feasible instead of stopping at analysis or a plan.
- State material assumptions only after reasonable discovery. Distinguish verified facts, inferences, and remaining unknowns when that context matters.

## Working Style

- Reuse existing helpers, patterns, libraries, scripts, and conventions before adding new ones.
- Use the package manager, scripts, and toolchain already chosen by the project.
- Prefer existing CI, scripts, and task runners over inventing new commands.
- Add comments only when intent is not obvious; when you do, explain why, not what.
- Keep diffs focused and easy to review.
- Avoid renaming, moving, or reorganizing files unless there is a clear payoff.
- Avoid adding dependencies unless they are necessary and justified.
- Read files in manageable chunks and do not assume file contents.
- Prefer fast search tools such as `rg` and `rg --files`.
- Avoid rewriting entire files when a targeted edit is sufficient.
- Follow the established test style and fixture patterns unless the task requires changing them.
- Do not overwrite, discard, or revert changes you do not understand.

## Before Editing Code

Use only the setup needed to work safely.

1. Read the nearest relevant `AGENTS.md` files.
2. Confirm which files are in scope.
3. Inspect the relevant project layout, entry points, and authoritative sources such as existing code, configs, docs, and scripts.
4. Identify the existing test, build, lint, and formatting commands that may be relevant to the task.
5. If the directory is inside a git repository, check `git status` before editing and inspect any in-scope files that already have local changes.
6. Identify the likely blast radius and the smallest meaningful validation for the change; expand that plan after inspection if the impact is broader than first expected.

For review, analysis, or question-only tasks, skip edit-oriented setup that is not needed.
For mixed requests, separate discovery or review from implementation and do not edit until the needed context has been inspected.

## Task Guidance

### Implementation

- Update all affected call sites, tests, docs, examples, or configs when an interface or behavior changes.
- Treat generated files, lockfiles, and vendored code as special cases; edit them only when required.
- Preserve compatibility and documented rollout, deployment, or migration expectations unless the task says otherwise.
- Preserve the project's visual language for frontend changes unless a redesign is requested.
- Be explicit about schema, compatibility, and migration implications for backend or data changes.

### Review

- Prioritize bugs, regressions, missing tests, unclear assumptions, and maintenance risks.
- Lead with findings, ordered by severity, with concrete file references when possible.
- For each finding, explain why it matters and suggest a fix when practical.
- Keep summaries brief and separate from findings.
- If no issues are found, say so and note any residual risk or test gap.
- Do not make code changes during review unless the user explicitly asks for them.

### Questions, Explanations, And Docs

- Inspect the minimum context needed to answer correctly, tracing relevant declarations, call sites, and configs when they affect the answer.
- Prefer answers grounded in the actual code, configs, scripts, docs, tests, or recent history over filling gaps from memory.
- Do not make code changes unless the user asks for them.
- If uncertainty remains after reasonable discovery, state what was checked, why the gap remains, and distinguish verified facts, inferences, and unknowns.
- Keep explanations concrete and tied to the actual files or commands when useful.

## Validation

- Run the smallest meaningful check that covers the task.
- Use the existing test, build, lint, and formatting commands when they are relevant and available.
- Expand validation when shared code, interfaces, or multiple layers are affected.
- Distinguish pre-existing failures from regressions introduced by the work.
- If validation cannot be run, say exactly what was not verified and why.
- Do not claim success without some form of verification when verification is possible.

## Safety

- Do not use destructive git commands unless explicitly requested.
- Do not revert unrelated changes in a dirty worktree.
- Keep commits focused if the user asks for commits.
- Avoid amending or force-pushing unless explicitly requested.
- Surface security, privacy, data-loss, and migration risks clearly.

## Communication

- Give short progress updates during longer tasks.
- Be concise and factual.
- Ask questions only when a necessary decision cannot be made safely from context after reasonable discovery.
- Reference concrete files and commands when useful.

When finishing a task, provide:

1. A short summary of what changed or what was found.
2. The validation performed, or what could not be validated.
3. Any notable assumptions, limitations, risks, or follow-up work.
