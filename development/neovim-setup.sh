# install neovim, wget and unzip
sudo dnf install -y nvim wget unzip

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

# clear and regenerate font cache
fc-cache -f -v

# backup nvim config
mv ~/.config/nvim ~/.config/nvim.bak 
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak 
mv ~/.cache/nvim ~/.cache/nvim.bak

 # clone and apply AstroVim configuration
git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim && rm -rf ~/.config/nvim/.git && nvim

# add custom keybindings to '~/.config/nvim/init.lua'
cat >> ~/.config/nvim/init.lua << EOF

-- Custom Keybindings

local opts = { noremap = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "cr", "<cmd>term cargo check<cr>", opts)
keymap("i", "<C-_>", "<cmd>RustLsp codeAction<CR>", opts)
keymap("n", "<C-_>", "<cmd>RustLsp codeAction<CR>", opts)
keymap("n", "<C-_>", "<cmd>RustLsp codeAction<CR>", opts)

    -- Normal --
-- Better window navigation
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

EOF 

# install 'Rust'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# add `~/.cargo/bin` to PATH
cat >> ~/.bashrc << EOF
export PATH=$PATH:~/.cargo/bin
EOF

# source ~/.bashrc
source ~/.bashrc

# install 'rust-analyzer'
rustup component add rust-analyzer

# add 'mrcjkb/rustaceanvim' to lazy.nvim plugins
sed -i -e 's/if true then return {}/if true then return {{ "mrcjkb\/rustaceanvim", version = "^4", ft = { "rust" },}}/g' ~/.config/nvim/lua/plugins/user.lua

# install nvim DAP
cat << EOF
##################################################
##################################################
##################################################


Script finished.

Please install `codelldb` (DAP) manually by opening a Rust file and running `:DapInstall`.


##################################################
##################################################
##################################################
EOF
