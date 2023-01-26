# My dotFiles

**Sym link each file/folder in the dotFiles to the locations they are supposed to be located.**

## i3 Setup

## tmux Setup
Install tpm for pluggin use

## Alacritty Setup

## NeoVim Setup

### Step 1: Install Package Manager 
Install [Packer (package manager)](https://github.com/wbthomason/packer.nvim)

### Setp 2: Source Plugins
Inside nvim/lua/myFolder/packer.lua use `:so` to source the packer file.

### Step 3: Additional Installs
**Telescope Installs (not required):**
- [Ripgrep](https://github.com/BurntSushi/ripgrep) (would install this anyway): 
``` 
sudo pacman -S ripgrep 
```
- [fd](https://github.com/sharkdp/fd#installation):
```
sudo pacman -S fd
```

## Polybar Setup

## TODOs
- Install a native telescope sorter (either [fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim) or [fzy-native](https://github.com/nvim-telescope/telescope-fzy-native.nvim))
