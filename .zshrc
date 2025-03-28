if [ -f ~/.profile ]; then
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
    zsh-syntax-highlighting
    zsh-autosuggestions
    you-should-use
)

source $ZSH/oh-my-zsh.sh

cprint() {
    if [[ $- == *i* ]]; then
        echo $*
    fi
}

cgit() {
    if [[ $- == *i* ]]; then
        git $*
    fi
}

# Make zsh git auto completion faster
__git_files()
{
    _wanted files expl 'local files' _files
}

# Install zsh plugins if not installed
setup-zsh()
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
        git clone https://github.com/zsh-users/zsh-autosuggestions.git $AUTOSUGGESTIONS_PATH
        echo "Installed zsh-autosuggestions"
    else
        echo "Already installed zsh-autosuggestions"
    fi

    # you-should-use
    echo "Installing you-should-use"
    YOUSHOULDUSE_PATH=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
    if [[ ! -d $YOUSHOULDUSE_PATH ]]
    then
        git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
        echo "Installed you-should-use"
    else
        echo "Already installed you-should-use"
    fi
}

# Make dirs for neovim
setup-nvim-dirs()
{
    NVIM_META_DIR_PATH=~/.vim
    NVIM_BACKUP_DIR_PATH=$NVIM_META_DIR_PATH/backup
    NVIM_SWAP_DIR_PATH=$NVIM_META_DIR_PATH/swap
    NVIM_UNDO_DIR_PATH=$NVIM_META_DIR_PATH/undo
    NVIM_DIR_PATHS=($NVIM_META_DIR_PATH $NVIM_BACKUP_DIR_PATH $NVIM_SWAP_DIR_PATH $NVIM_UNDO_DIR_PATH)

    for i in "${NVIM_DIR_PATHS[@]}"
    do
        if [[ ! -d $i ]]
        then
            mkdir $i
        else
            echo "$i already exists"
        fi
    done
}

# Set up tmux plugins
setup-tpm()
{
    tpm_folder=~/.tmux/plugins/tpm
    if [[ ! -d $tpm_folder ]]; then
        cprint "Tmux Plugin Manager not found. Installing it now..."
        mkdir -p $tpm_folder
        cgit clone https://github.com/tmux-plugins/tpm $tpm_folder > /dev/null 2>&1
    else
        cgit -C $tpm_folder pull > /dev/null 2>&1
    fi
}

# Aliases
alias ls="ls --color=auto"
alias ll="ls -la"
alias resource="source ~/.zshrc"

alias tmns='tmux new-session'
alias ta='tmux attach'
alias tl='tmux list-sessions'

alias config='/usr/bin/git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME/dotfiles'

echo "Available functions: setup-zsh, setup-tpm, setup-nvim-dirs"
