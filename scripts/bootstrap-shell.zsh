#!/usr/bin/env zsh

emulate -L zsh
setopt err_return no_unset pipe_fail

clone_git_repo()
{
    local repo_name="$1"
    local repo_url="$2"
    local repo_path="$3"
    local -a repo_entries

    if command git -C "$repo_path" rev-parse --is-inside-work-tree > /dev/null 2>&1
    then
        print -r -- "$repo_name is already installed"
        return 0
    fi

    if [[ -e "$repo_path" ]]
    then
        repo_entries=("$repo_path"/*(ND))
        if [[ ! -d "$repo_path" || ${#repo_entries} -ne 0 ]]
        then
            print -u2 -- "$repo_name install path exists but is not a git repo: $repo_path"
            return 1
        fi
    else
        command mkdir -p -- "${repo_path:h}"
    fi

    print -r -- "Installing $repo_name..."
    command git clone -- "$repo_url" "$repo_path"
    print -r -- "Installed $repo_name"
}

setup_zsh_plugins()
{
    local custom_plugins_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

    clone_git_repo \
        "zsh-syntax-highlighting" \
        "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
        "$custom_plugins_dir/zsh-syntax-highlighting"

    clone_git_repo \
        "zsh-autosuggestions" \
        "https://github.com/zsh-users/zsh-autosuggestions.git" \
        "$custom_plugins_dir/zsh-autosuggestions"

    clone_git_repo \
        "you-should-use" \
        "https://github.com/MichaelAquilina/zsh-you-should-use.git" \
        "$custom_plugins_dir/you-should-use"
}

setup_tpm()
{
    local tpm_folder="$HOME/.tmux/plugins/tpm"

    if command git -C "$tpm_folder" rev-parse --is-inside-work-tree > /dev/null 2>&1
    then
        print -r -- "Updating Tmux Plugin Manager..."
        command git -C "$tpm_folder" pull --ff-only
    else
        clone_git_repo \
            "Tmux Plugin Manager" \
            "https://github.com/tmux-plugins/tpm" \
            "$tpm_folder"
    fi
}

main()
{
    local zsh_root="${ZSH:-$HOME/.oh-my-zsh}"

    if ! command -v git > /dev/null 2>&1
    then
        print -u2 -- "git is required"
        return 1
    fi

    if [[ ! -d "$zsh_root" ]]
    then
        print -u2 -- "oh-my-zsh is not installed at $zsh_root"
        return 1
    fi

    setup_zsh_plugins
    setup_tpm
}

main "$@"
