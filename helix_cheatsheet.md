# Helix Cheatsheet

## Core Basics

### Move the Cursor

- `h`: move left
- `j`: move down
- `k`: move up
- `l`: move right

### Modes

- `Normal` mode is the default mode for navigation and commands.
- `i`: enter `Insert` mode before the selection and start typing.
- `a`: append after the selection.
- `I`: enter `Insert` mode at the first non-whitespace character of the line.
- `A`: enter `Insert` mode at the end of the line.
- `v`: enter `Select` mode; press `v` again or `Esc` to return to `Normal` mode.
- `Esc`: return to `Normal` mode.
- `:`: enter `Command` mode.

### Command Mode

- `:q`: quit Helix
- `:q!`: quit without saving changes
- `:w`: save the current file
- `:wq`: save and quit

`:q` fails if there are unsaved changes.

### Word Motions

- `w`: move/select forward to the beginning of the next word
- `e`: move/select forward to the end of the current word
- `b`: move/select backward to the beginning of the current word
- `W`, `E`, `B`: use WORD motions, where only whitespace separates words
- Prefix a count to repeat a motion, for example `2w`, `3e`, or `2b`

### Character Motions

- `f`, `F`: extend selection up to and including a target character
- `t`, `T`: extend selection until a target character

### Search

- `/`: search forward in the file
- `?`: search backward in the file
- `n`: jump to the next search match
- `N`: jump to the previous search match

### Selection

- In `Normal` mode, the cursor acts like a one-character selection.
- In `Select` mode, movements extend the selection instead of replacing it.
- `x`: select the current line; repeat it or use a count to include more lines
- `X`: select the current line without extending to following lines; does nothing on an empty line
- `%`: select the whole file
- `;`: collapse selections back to cursors
- `Alt-;`: flip the selection direction

### Multi-Selection

- `C`: duplicate the cursor to the next suitable line
- `Alt-C`: duplicate the cursor to the previous suitable line
- `s`: select all regex matches inside the current selection
- `,`: keep only the primary cursor or selection
- `Alt-s`: split selections on newlines into one selection per line

### Alignment

- `&`: align the heads of the current selections
- Alignment moves the selection head, not the anchor

### Editing

- `d`: delete the current selection
- `c`: change the current selection, deleting it and entering `Insert` mode
- `r`: replace the selected characters
- `R`: replace the current selection with yanked text
- `y`: yank (copy) the current selection
- `p`: paste yanked text
- `Space+y`: yank to the system clipboard
- `Space+p`: paste from the system clipboard
- `J`: join lines in the current selection
- `>`: indent selected lines
- `<`: unindent selected lines
- `Ctrl-a`: increment the selected number
- `Ctrl-x`: decrement the selected number
- `o`: open a new line below the cursor and enter `Insert` mode
- `O`: open a new line above the cursor and enter `Insert` mode

By default, Helix does not use the system clipboard for plain `y` and `p`.

### Registers

- `"`: select a different register

### Macros

- `Q`: start or stop recording a macro to the selected register
- `q`: replay a macro from the selected register
- The default macro register is `@`

### Repeat

- `.`: repeat the last insertion
- `Alt-.`: repeat the last `f` or `t` selection

### History

- `u`: undo
- `U`: redo
