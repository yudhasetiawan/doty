# My Personal Dotfiles

A [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) inspired dotfiles.

> **NOTE:** Currently, only supports managing your [zsh](https://www.zsh.org) configuration.

## Installation

**Warning:** If you want to give these doty a try, you should first fork this repository, review the code, and remove things you don't want or need.
Don't blindly use my settings unless you know what that entails. Use at your own risk!

## Features

- **Zsh Configuration**: Enhanced shell experience with custom aliases, functions, and prompt
- **Git Configuration**: Optimized git settings and aliases with comprehensive .gitconfig, .gitattributes, and .gitignore templates
- **Neovim Configuration**: Modern Neovim setup with plugin management, LSP configurations, and Lua-based settings
- **Vim Configuration**: Advanced vim configuration with bundled plugins and comprehensive Solarized colorscheme support
- **Solarized Configuration**: Dedicated Solarized theme configuration with light and dark variants
- **Tmux Configuration**: Productive terminal multiplexer setup with custom doty theme and TPM (Tmux Plugin Manager)
- **Terminal Color Schemes**: Extensive collection of color schemes for various terminals including Alacritty, Kitty, iTerm2, WezTerm, Ghostty, Windows Terminal, XFCE Terminal, Konsole, Terminal.app, MobaXterm, RoyalTS, and many more (over 300+ themes including popular ones like Dracula, Nord, Gruvbox, Catppuccin, Solarized, TokyoNight, Monokai variants, Ayu, and many others)
- **Zellij Configuration**: Modern terminal workspace management with custom layouts and themes
- **Plugin Management**: Easy-to-manage plugins for various tools
- **Theme Support**: Customizable themes for different tools with support for multiple terminal emulators
- **Shell Integration**: Support for various shells with customizable prompts and configurations
- **Environment Configuration**: Various environment settings for optimal development workflow

### Basic Installation

Doty is installed by running one of the following commands in your terminal.
You can install this via the command-line with either `curl`, `wget` or another similar tool.

| Method   | Command                                                                                        |
| :------- | :--------------------------------------------------------------------------------------------- |
| **curl** | `sh -c "$(curl -fsSL https://raw.githubusercontent.com/yudhasetiawan/doty/main/scripts/doty)"` |
| **wget** | `sh -c "$(wget -O- https://raw.githubusercontent.com/yudhasetiawan/doty/main/scripts/doty)"`   |

_Note that any previous `.zshrc` will be moved to `~/.doty/.backups`. After installation, you can move the configuration you want to preserve into the new `.zshrc`._

### Using Git and load the configuration

You can clone the repository wherever you want. (I like to keep it in `~/Development/doty`, with `~/.doty` as a symlink.)

```bash
git clone https://github.com/yudhasetiawan/doty.git && cd doty
```

Currently, there is no installation script. So you'll need to install it manually:

- Load zsh modules

```bash
echo 'source "${HOME}/.doty/doty"' >> ${HOME}/.zshrc
```

- Load tmux modules

```bash
echo "run \"${HOME}/.doty/config/tmux/doty/doty\"" >> ${HOME}/.tmux.conf
```

- Load vim plugins

```bash
cat <<EOT >> ${HOME}/.config/nvim/init.lua
vim.opt.rtp:prepend(os.getenv("DOTY_DIRECTORY") .. "/config/nvim/after")
vim.opt.rtp:prepend(os.getenv("DOTY_DIRECTORY") .. "/config/nvim")

require("doty")
EOT
```

- Git configurations

```bash
git config --global --add --path core.excludesfile "${HOME}/.doty/config/git/gitignore"
git config --global --add --path core.attributesfile "${HOME}/.doty/config/git/gitattributes"
git config --global --includes --path include.path "${HOME}/.doty/config/git/.gitconfig"
```

- Symlink configurations

```bash
ln -f -s "${HOME}/.doty/config/curlrc.symlink" "${HOME}/.curlrc"
ln -f -s "${HOME}/.doty/config/editorconfig.symlink" "${HOME}/.editorconfig"
ln -f -s "${HOME}/.doty/config/inputrc.symlink" "${HOME}/.inputrc"
ln -f -s "${HOME}/.doty/config/wgetrc.symlink" "${HOME}/.wgetrc"
```

### Git-free install

To install these dotfiles without Git:

```bash
cd; curl -#L https://github.com/yudhasetiawan/doty/tarball/main | tar -xzv --strip-components 1 --exclude={README.md,NOTES.md}
```

## Directory Structure

```
├── README.md          # This file
├── defaults.txt       # Default settings
├── NOTES.md           # Additional notes
├── Brewfile           # Homebrew dependencies
├── Makefile           # Make targets for various tasks
├── doty               # Main entry point for the dotfiles
├── config/            # Configuration files for various tools
│   ├── color-schemes/ # Extensive collection of terminal color schemes (300+ themes)
│   ├── git/           # Git configuration files
│   ├── nvim/          # Neovim configuration
│   ├── vim/           # Vim configuration and bundles
│   ├── tmux/          # Tmux configuration with custom doty theme
│   ├── zellij/        # Zellij terminal multiplexer configuration
│   ├── symlink/       # Files to be symlinked to home directory
│   └── ...            # Other tool configurations
├── plugins/           # Third-party plugins
├── themes/            # Custom themes
├── scripts/           # Utility scripts
└── libraries/         # Helper libraries
```
