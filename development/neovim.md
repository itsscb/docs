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

#### Plugins
##### [mattn/emmet](https://github.com/mattn/emmet-vim)
`~/.config/nvim/lua/plugins/emmet.lua`

```
return {
  {
    'mattn/emmet-vim',
      setup = function ()
        -- Emmet plugin configuration
        vim.g.user_emmet_leader_key = ','  -- Change leader key (optional)

        -- Key mappings for triggering Emmet actions
        vim.api.nvim_set_keymap('i', '<C-y>,', '<C-y>,', { silent = true, noremap = true })
        vim.api.nvim_set_keymap('i', '<C-y>l', '<C-y>l', { silent = true, noremap = true })

        print('Emmet plugin loaded successfully!')
      end
  }
}
```

##### tailwindcss
`~/.config/nvim/lua/plugins/tailwindcss.lua`

```
return {
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = 'html', -- Install the HTML parser
        highlight = {
          enable = true -- Enable treesitter-based syntax highlighting
        }
      }
    end
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('nvim-treesitter.configs').setup {
        context_commentstring = {
          enable = true
        }
      }
      local lspconfig = require('lspconfig')
      lspconfig.tailwindcss.setup{}
      local opts = { noremap = true }
      local keymap = vim.api.nvim_set_keymap

      keymap("i", "<C-space>", "<Plug>(ts-autotag-trigger)", opts)
      keymap("n", "<leader>/", "<Plug>(ts-context-commentstring)", opts)

    end
  }
}
```

##### mrcjkb/rustaceanvim
`~/.config/nvim/lua/plugins/rustaceanvim.lua`
```
return {
  { 
    'mrcjkb/rustaceanvim', 
    config = function()
      local opts = { noremap = true }
      local keymap = vim.api.nvim_set_keymap
      keymap("n", "cr", "<cmd>term cargo check<cr>", opts)
      keymap("i", "<C-_>", "<cmd>RustLsp codeAction<CR>", opts)
      keymap("n", "<C-_>", "<cmd>RustLsp codeAction<CR>", opts)
      keymap("n", "<C-_>", "<cmd>RustLsp codeAction<CR>", opts)
    end,
    version = '^4', 
    ft = { 'rust' },
  }
}
```
#### Keybindings
Keybindings should be added to the bottom of `~/.config/nvim/init.lua`. 

Use the following syntax:
```
-- Normal --
-- Better window navigation
local opts = { noremap = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<C-h>", "<C-w>h", opts) -- left window
keymap("n", "<C-k>", "<C-w>k", opts) -- up window
keymap("n", "<C-j>", "<C-w>j", opts) -- down window
keymap("n", "<C-l>", "<C-w>l", opts) -- right window

-- Resize with arrows when using multiple windows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<c-down>", ":resize +2<cr>", opts)
keymap("n", "<c-right>", ":vertical resize -2<cr>", opts)
keymap("n", "<c-left>", ":vertical resize +2<cr>", opts)


-- navigate buffers
keymap("n", "<tab>", ":bnext<cr>", opts) -- Next Tab 
keymap("n", "<s-tab>", ":bprevious<cr>", opts) -- Previous tab
keymap("n", "<leader>h", ":nohlsearch<cr>", opts) -- No highlight search

-- move text up and down
keymap("n", "<a-j>", "<esc>:m .+1<cr>==gi<esc>", opts) -- Alt-j 
keymap("n", "<a-k>", "<esc>:m .-2<cr>==gi<esc>", opts) -- Alt-k

-- insert --
-- press jk fast to exit insert mode 
keymap("i", "jk", "<esc>", opts) -- Insert mode -> jk -> Normal mode
keymap("i", "kj", "<esc>", opts) -- Insert mode -> kj -> Normal mode

-- visual --
-- stay in indent mode
keymap("v", "<", "<gv", opts) -- Right Indentation
keymap("v", ">", ">gv", opts) -- Left Indentation

-- move text up and down
keymap("v", "<a-j>", ":m .+1<cr>==", opts)
keymap("v", "<a-k>", ":m .-2<cr>==", opts)

-- Visual Block --
-- Move text up and down
    --Terminal --
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
```


### Rust
- Install [[Rust#rust-analyzer|rust-analyzer]]
- Add **[mrcjkb/rustaceanvim]()** to `~/.config/nvim/lua/plugins/user.lua` <br> ```{ 'mrcjkb/rustaceanvim', version = '^4', ft = { 'rust' },}```
- Install **codelldb** as **DAP** (see *[[neovim#Configuration#Basics|Configure AstroVim Basic Setup]]*)



