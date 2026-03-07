typeset -U PATH path FPATH fpath precmd_functions preexec_functions chpwd_functions

if [[ -f ~/.profile ]]; then
    source ~/.profile
fi

export ZSH="$HOME/.oh-my-zsh"

export VISUAL=vim
export EDITOR="$VISUAL"

ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(
    git
    tmux
    you-should-use
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# Make zsh git auto completion faster
__git_files()
{
    _wanted files expl 'local files' _files
}

# Aliases
alias ls="ls --color=auto"
alias ll="ls -la"
alias resource="source ~/.zshrc"

alias tmns='tmux new-session'
alias ta='tmux attach'
alias tl='tmux list-sessions'

alias config='/usr/bin/git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME/dotfiles'
