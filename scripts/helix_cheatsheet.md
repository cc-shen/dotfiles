# Helix Cheatsheet

## Quick Start

### Mental Model

- Helix is selection-first: in `Normal` mode, the cursor acts like a one-character selection.
- In `Select` mode, movements extend the current selection instead of replacing it.

### Modes

- `Normal`: default mode for navigation and commands.
- `i` / `a`: enter `Insert` mode before or after the selection.
- `I` / `A`: enter `Insert` mode at the first non-whitespace character or end of the line.
- `v` / `Esc`: enter `Select` mode, or return to `Normal` mode.
- `:`: enter `Command` mode.

### Save and Quit

- `:w`: save the current file.
- `:q`: quit Helix.
- `:wq`: save and quit.
- `:q!`: quit without saving changes.

`:q` fails if there are unsaved changes.

## Navigation

### Basic Movement

- `h` / `l`: move left or right.
- `j` / `k`: move down or up.

### Counts

- Prefix a count to repeat a motion or command, for example `2w`, `3e`, or `2x`.

### Word and Character Motions

- `w` / `b`: move or select forward to the next word start, or backward to the current word start.
- `e`: move or select forward to the end of the current word.
- `W` / `B`: use WORD motions, where only whitespace separates words.
- `E`: move or select forward to the end of the current WORD.
- `f` / `F`: extend selection up to and including a target character.
- `t` / `T`: extend selection until a target character.

### Search and Jumps

- `/` / `?`: search forward or backward in the file.
- `n` / `N`: jump to the next or previous search match.
- `*`: set the search register to the primary selection.
- In `Select` mode, `n` and `N` add selections on search matches.
- `Ctrl-o` / `Ctrl-i`: go backward or forward in the jumplist.
- `Ctrl-s`: save the current position to the jumplist.
- `gw`: show 2-character jump labels.
  - Type the label characters to jump, or `Esc` to dismiss the labels.

## Selections

### Single Selection

- `x` / `X`: select the current line, or select it without extending to following lines.
- `%`: select the whole file.
- `;` / `Alt-;`: collapse selections back to cursors, or flip the selection direction.

### Multi-Selection

- `C` / `Alt-C`: duplicate the cursor to the next or previous suitable line.
- `s`: select all regex matches inside the current selection.
- `Alt-s`: split selections on newlines into one selection per line.
- `,`: keep only the primary cursor or selection.
- `&`: align the heads of the current selections.
  - Alignment moves the selection head, not the anchor.

## Editing

### Insert and Replace

- `d` / `c`: delete the current selection, or change it and enter `Insert` mode.
- `r` / `R`: replace selected characters, or replace the current selection with yanked text.
- `o` / `O`: open a new line below or above the cursor and enter `Insert` mode.

### Copy and Paste

- `y` / `p`: yank or paste using Helix's default register.
- `Space+y` / `Space+p`: yank to or paste from the system clipboard.

By default, plain `y` and `p` do not use the system clipboard.

### Layout and Numbers

- `J`: join lines in the current selection.
- `>` / `<`: indent or unindent selected lines.
- `Ctrl-a` / `Ctrl-x`: increment or decrement the selected number.

### Repeat and History

- `.` / `Alt-.`: repeat the last insertion, or repeat the last `f` or `t` selection.
- `u` / `U`: undo or redo.

## Registers and Macros

- `"`: select a different register.
- `Q` / `q`: start or stop recording a macro to the selected register, or replay a macro from it.
- The default macro register is `@`.
