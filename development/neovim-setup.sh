# backup nvim config
mv ~/.config/nvim ~/.config/nvim.bak 
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak 
mv ~/.cache/nvim ~/.cache/nvim.bak

 # clone and apply configuration
git clone --depth 1 https://github.com/itsscb/neovim-config ~/.config/nvim 
rm -rf ~/.config/nvim/.git 
chmod +x ~/.config/nvim/setup.sh
~/.config/nvim/setup.sh
