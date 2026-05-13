# Dotfiles

## Usage

The package folder must mirror the path from ~. Since Neovim lives at
~/.config/nvim, the structure inside the package is .config/nvim/.

mkdir -p ~/dotfiles/nvim/.config
mv ~/.config/nvim ~/dotfiles/nvim/.config/nvim

Your tree should look like:

~/dotfiles/
└── nvim/
    └── .config/
        └── nvim/
            ├── init.lua
            ├── lazy-lock.json
            └── lua/
                └── ...

Now create the symlink:

cd ~/dotfiles
stow nvim

Stow creates ~/.config/nvim as a symlink pointing to ~/dotfiles/nvim/.config/nvim.
Neovim sees nothing different.

Verify:

ls -la ~/.config/nvim
→ lrwxrwxrwx ... ~/.config/nvim -> ../dotfiles/nvim/.config/nvim

### Adding more configs in the future

Same pattern for any tool. For example, adding your zsh config:

mkdir -p ~/dotfiles/zsh
mv ~/.zshrc ~/dotfiles/zsh/.zshrc
cd ~/dotfiles
stow zsh
git add zsh
git commit -m "add zsh config"
git push

Each tool gets its own package directory — this lets you stow/unstow configs
independently.

### Restoring on a new machine

// Prerequisites
sudo apt install stow git neovim   # or brew equivalents

// Clone your dotfiles
git clone git@github.com:<your-username>/dotfiles.git ~/dotfiles

Stow whichever packages you want
cd ~/dotfiles
stow nvim
stow zsh       # if you have it
// etc.

// Launch nvim — lazy.nvim bootstraps automatically
nvim

---
Stow quick reference

┌──────────────────────┬────────────────────────────────────────────────────────┐
│       Command        │                         Effect                         │
├──────────────────────┼────────────────────────────────────────────────────────┤
│ stow nvim            │ Create symlinks for the nvim package                   │
├──────────────────────┼────────────────────────────────────────────────────────┤
│ stow -D nvim         │ Remove symlinks (unstow)                               │
├──────────────────────┼────────────────────────────────────────────────────────┤
│ stow -R nvim         │ Restow (remove + recreate, useful after restructuring) │
├──────────────────────┼────────────────────────────────────────────────────────┤
│ stow --simulate nvim │ Dry run — show what would happen                       │
└──────────────────────┴────────────────────────────────────────────────────────┘

---
Caution: conflicts

If a real file already exists at the target path, Stow will refuse to overwrite it.
You must remove or back up the original first:

rm ~/.config/nvim          # if it already exists as a real dir on the new machine
stow nvim
