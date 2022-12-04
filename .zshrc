export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(
    git
    tmux
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Make zsh git auto completion faster
__git_files()
{
    _wanted files expl 'local files' _files
}

# Install zsh plugins if not installed
zsh-setup()
{
    # zsh-syntax-highlighting
    echo "Installing zsh-syntax-highlighting..."
    SYNTAX_HIGHTLIGHTING_PATH=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    if [[ ! -d $SYNTAX_HIGHTLIGHTING_PATH ]]
    then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $SYNTAX_HIGHTLIGHTING_PATH
        echo "Installed zsh-syntax-highlighting"
    else
        echo "Already installed zsh-syntax-highlighting"
    fi

    # zsh-autosuggestions
    echo "Installing zsh-autosuggestions..."
    AUTOSUGGESTIONS_PATH=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    if [[ ! -d $AUTOSUGGESTIONS_PATH ]]
    then
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        echo "Installed zsh-autosuggestions"
    else
        echo "Already installed zsh-autosuggestions"
    fi
}

# Aliases
alias ls="ls --color=auto"
alias ll="ls -la"
alias resource="source ~/.zshrc"

alias ta='tmux attach'
alias tl='tmux list-sessions'
