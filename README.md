# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

## Installation

First, check out the .dotfiles repo in your $HOME directory using git

```bash
git clone https://github.com/mashurimansur/.dotfiles.git
cd .dotfiles
bash install.sh
```

then use GNU stow to create symlinks

```bash
stow {folder-name}
```