#!/bin/bash

# Dotfiles installation script for macOS
# Creates symlinks from home directory to this dotfile repo

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles from: $DOTFILES_DIR"
echo "Using symlinks (not copies)"

# Create necessary directories
mkdir -p ~/.config
mkdir -p ~/.tmux/plugins

# Backup and symlink helper
# If target exists and is NOT already a symlink to our repo, back it up
backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
backup_created=false

link_file() {
    local src="$1"
    local dst="$2"

    if [ -L "$dst" ]; then
        local current_target
        current_target="$(readlink -f "$dst")"
        local expected_target
        expected_target="$(readlink -f "$src")"
        if [ "$current_target" = "$expected_target" ]; then
            echo "  [skip] $dst (already linked)"
            return
        fi
        rm "$dst"
    elif [ -e "$dst" ]; then
        if [ "$backup_created" = false ]; then
            mkdir -p "$backup_dir"
            backup_created=true
        fi
        echo "  [backup] $dst -> $backup_dir/"
        mv "$dst" "$backup_dir/"
    fi

    ln -sf "$src" "$dst"
    echo "  [link] $dst -> $src"
}

# --- Shell configs ---
echo ""
echo "Shell configs..."
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
link_file "$DOTFILES_DIR/.skhdrc" "$HOME/.skhdrc"

# --- .config directories (symlink entire dirs) ---
echo ""
echo "Config directories..."
config_dirs=(
    nvim
    ghostty
    kitty
    yabai
    sketchybar
)

for dir in "${config_dirs[@]}"; do
    link_file "$DOTFILES_DIR/.config/$dir" "$HOME/.config/$dir"
done

# --- tmux plugin manager ---
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo ""
    echo "Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# --- Create local config templates if they don't exist ---
if [ ! -f "$HOME/.zshrc.local" ]; then
    touch "$HOME/.zshrc.local"
    echo "Created ~/.zshrc.local - put secrets/API keys here"
fi

echo ""
echo "=========================================="
echo "Dotfiles installed successfully!"
echo "=========================================="
echo ""
if [ "$backup_created" = true ]; then
    echo "Backups saved to: $backup_dir"
    echo ""
fi
echo "Next steps:"
echo "1. Add any secrets/API keys to ~/.zshrc.local"
echo "2. Install tmux plugins: press prefix + I in tmux"
echo "3. Open nvim and let lazy.nvim install plugins"
echo "4. Run :Copilot auth in nvim to authenticate GitHub Copilot"
echo ""
echo "Recommended packages (macOS):"
echo "  brew install neovim tmux fzf thefuck starship"
echo "  brew install eza bat fd delta zoxide lazygit"
echo "  brew install --cask ghostty"
echo "  brew install koekeishiya/formulae/yabai"
echo "  brew install koekeishiya/formulae/skhd"
echo ""
