## oh-my-zsh

Tired of looking up <https://ohmyz.sh/#install> everytime, so the command is just

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Bootstrap shell plugins and tmux TPM after installing oh-my-zsh:

```bash
zsh ~/dotfiles/scripts/bootstrap-shell.zsh
```

## Others

Linking from dotfiles:

```bash
ln -nfs ~/dotfiles/.zshrc ~/.zshrc

ln -nfs ~/dotfiles/nvim ~/.config/nvim

ln -nfs ~/dotfiles/.tmux.conf ~/.tmux.conf
```

Locating command history:

```bash
echo $HISTFILE
```

tmux:

- May need to run `<prefix> I` to install, `<prefix> U` to update
