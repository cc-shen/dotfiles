local exec = vim.api.nvim_exec -- execute Vimscript
local set = vim.opt -- global options
local cmd = vim.cmd -- execute Vim commands
local fn = vim.fn -- functions
local g = vim.g -- global variables

g.did_install_default_menus = 1 -- no default menu
set.shortmess:append 'sI' -- disable nvim intro

set.termguicolors = true
cmd.colorscheme 'catppuccin-frappe'

set.wrap = false
set.number = true
set.relativenumber = true
set.cursorline = true
set.scrolloff = 8
set.sidescrolloff = 8

set.autoindent = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true

set.mouse = 'a'
set.mousemodel = 'popup'

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
set.whichwrap:append '<>[]hl'

set.timeout = true
set.timeoutlen = 500
set.updatetime = 500

set.confirm = true
set.splitbelow = true
set.splitright = true

set.ignorecase = true
set.smartcase = true
set.wildignorecase = true
set.wildmode = 'list:longest'

set.list = true
set.listchars = {
    nbsp = '⦸', -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
    extends = '»', -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
    precedes = '«', -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
    tab = '▷─', -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
    trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
    space = ' '
}
set.fillchars = {
    diff = '∙', -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
    eob = ' ', -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
    fold = '·', -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
    vert = ' ' -- remove ugly vertical lines on window division
}

set.jumpoptions = 'view'

set.history = 63
set.laststatus = 2

set.shell = 'zsh'
set.clipboard = 'unnamedplus'

local prefix = fn.expand('~/.vim')
set.backupdir = { prefix .. '/backup//' }
set.directory = { prefix .. '/swap//' }
set.undodir = { prefix .. '/undo//' }
set.backup = true
set.writebackup = false
set.undofile = true
set.swapfile = true

g.mapleader = ','
g.maplocalleader = ','
