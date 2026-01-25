## oh-my-zsh

Tired of looking up <https://ohmyz.sh/#install> everytime, so the command is just

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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
