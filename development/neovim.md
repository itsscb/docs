---
tags:
  - development
  - editor
  - vim
  - neovim
  - software
---
# Setup

## [Script](https://raw.githubusercontent.com/itsscb/docs/master/development/neovim-setup.sh)
```
bash <(curls -s https://raw.githubusercontent.com/itsscb/docs/master/development/neovim-setup.sh)
```

## Manual
- Install **[neovim](https://neovim.io/)** <br> `sudo dnf install -y nvim`

### Configuration
#### Basics
- Install a **[Nerd Font](https://www.nerdfonts.com/font-downloads)** <br> `preferrably FiraCode`
- Create **optional** Backup <br> `mv ~/.config/nvim ~/.config/nvim.bak && mv ~/.local/share/nvim ~/.local/share/nvim.bak && mv ~/.local/state/nvim ~/.local/state/nvim.bak && mv ~/.cache/nvim ~/.cache/nvim.bak`
- Download **[AstroNvim Configuration](https://github.com/AstroNvim/AstroNvim)** <br> `git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim && rm -rf ~/.config/nvim/.git && nvim`
- Configure **[AstroVim Basic Setup](https://github.com/AstroNvim/AstroNvim#BasicSetup)** <br> **HINT**: Press `i` to install **DAP** (e. g. *codelldb*), *etc.* under the cursor
- **Custom Keybindings** should be added to the bottom of `~/.config/nvim/init.lua` (see *[[neovim#Configuration#Keybindings|Keybindings]])

#### Keybindings
Keybindings should be added to the bottom of `~/.config/nvim/init.lua`. 

Use the following syntax:
```
-- Custom Keybindings

local opts = { noremap = true }
local keymap = vim.api.nvim_set_keymap

    -- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts) -- left window
keymap("n", "<C-k>", "<C-w>k", opts) -- up window
keymap("n", "<C-j>", "<C-w>j", opts) -- down window
keymap("n", "<C-l>", "<C-w>l", opts) -- right window

```


### Rust
- Install [[Rust#rust-analyzer|rust-analyzer]]
- Add **[mrcjkb/rustaceanvim]()** to `~/.config/nvim/lua/plugins/user.lua` <br> ```{ 'mrcjkb/rustaceanvim', version = '^4', ft = { 'rust' },}```
- Install **codelldb** as **DAP** (see *[[neovim#Configuration#Basics|Configure AstroVim Basic Setup]]*)



