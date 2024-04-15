if ! command -v nvim &> /dev/null
then
  echo "'nvim' not found. Starting setup..."
  sudo dnf install -y nvim
else
  echo "'nvim' already installed."
fi

if ! command -v wget &> /dev/null
then
  echo "'wget' not found. Starting setup..."
  sudo dnf install -y wget
else
  echo "'wget' already installed."
fi


if ! command -v curl &> /dev/null
then
  echo "'curl' not found. Starting setup..."
  sudo dnf install -y curl
else
  echo "'curl' already installed."
fi

if ! command -v unzip &> /dev/null
then
  echo "'unzip' not found. Starting setup..."
  sudo dnf install -y unzip
else
  echo "'unzip' already installed."
fi

if $(fc-list | grep -i 'fira' -c) == 0 &> /dev/null
then
  echo "'firacode' font not found. Starting setup..."
  # download FiraCode
  wget -O /tmp/fira.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.0/FiraCode.zip

  # make temporary directory
  mkdir /tmp/firacode

  # unzip the font files
  unzip /tmp/fira.zip -d /tmp/firacode

  # create fonts folder
  mkdir ~/.local/share/fonts

  # move *.ttf files to fonts folder
  mv /tmp/firacode/*.ttf ~/.local/share/fonts/

  # remove temp files
  rm /tmp/fira.zip
  rm -rf /tmp/firacode

  # clear and regenerate font cache
  fc-cache -f -v
else
  echo "'firacode' font already installed."
fi
# backup nvim config
mv ~/.config/nvim ~/.config/nvim.bak 
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak 
mv ~/.cache/nvim ~/.cache/nvim.bak

 # clone and apply AstroVim configuration
git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim && rm -rf ~/.config/nvim/.git && nvim

# add custom keybindings to '~/.config/nvim/init.lua'
cat >> ~/.config/nvim/init.lua << EOF
local opts = { noremap = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-k>", "<C-w>k", opts) 
keymap("n", "<C-j>", "<C-w>j", opts) 
keymap("n", "<C-l>", "<C-w>l", opts) 
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<c-down>", ":resize +2<cr>", opts)
keymap("n", "<c-right>", ":vertical resize -2<cr>", opts)
keymap("n", "<c-left>", ":vertical resize +2<cr>", opts)
keymap("n", "<tab>", ":bnext<cr>", opts)  
keymap("n", "<s-tab>", ":bprevious<cr>", opts) 
keymap("n", "<leader>h", ":nohlsearch<cr>", opts) 
keymap("n", "<a-j>", "<esc>:m .+1<cr>==gi<esc>", opts)  
keymap("n", "<a-k>", "<esc>:m .-2<cr>==gi<esc>", opts) 
keymap("i", "jk", "<esc>", opts)
keymap("i", "kj", "<esc>", opts)
keymap("v", "<", "<gv", opts) 
keymap("v", ">", ">gv", opts) 
keymap("v", "<a-j>", ":m .+1<cr>==", opts)
keymap("v", "<a-k>", ":m .-2<cr>==", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
EOF

if ! command -v rustc &> /dev/null
then
  echo "'rustc' not found. Starting setup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  cat >> ~/.bashrc << EOF
export PATH=$PATH:~/.cargo/bin
EOF
  # source ~/.bashrc
  source ~/.bashrc
else
  echo "'rustc' is already installed."
fi



# install 'rust-analyzer'
rustup component add rust-analyzer


cat > ~/.config/nvim/lua/plugins/rustaceanvim.lua << EOF
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
EOF

cat > ~/.config/nvim/lua/plugins/emmet.lua << EOF
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
EOF

cat > ~/.config/nvim/lua/plugins/tailwindcss.lua << EOF
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
EOF

nvim -c "LspInstall tailwindcss"
