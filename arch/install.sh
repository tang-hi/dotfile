#!/bin/bash

# Dotfiles installation script for Arch Linux with Hyprland
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
link_file "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
link_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
link_file "$DOTFILES_DIR/.gdbinit" "$HOME/.gdbinit"

# --- .config directories (symlink entire dirs) ---
echo ""
echo "Config directories..."
config_dirs=(
    hypr
    kitty
    ghostty
    nvim
    waybar
    rofi
    dunst
    wlogout
    btop
    cava
    fontconfig
    atuin
    fcitx5
    eww
)

for dir in "${config_dirs[@]}"; do
    link_file "$DOTFILES_DIR/.config/$dir" "$HOME/.config/$dir"
done

# Fcitx5 themes
echo ""
echo "Fcitx5 themes..."
mkdir -p "$HOME/.local/share/fcitx5/themes"
link_file "$DOTFILES_DIR/.local/share/fcitx5/themes/catppuccin-latte-teal" "$HOME/.local/share/fcitx5/themes/catppuccin-latte-teal"
link_file "$DOTFILES_DIR/.local/share/fcitx5/themes/washi" "$HOME/.local/share/fcitx5/themes/washi"

# VSCode: only symlink settings.json (User dir has local state)
echo ""
echo "VSCode settings..."
mkdir -p "$HOME/.config/Code/User"
link_file "$DOTFILES_DIR/.config/Code/User/settings.json" "$HOME/.config/Code/User/settings.json"

# --- tmux plugin manager ---
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo ""
    echo "Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# --- Create local config templates if they don't exist ---
if [ ! -f "$HOME/.gitconfig.local" ]; then
    cat > "$HOME/.gitconfig.local" << 'GITLOCAL'
[user]
	email = your-email@example.com
	name = your-name
GITLOCAL
    echo ""
    echo "Created ~/.gitconfig.local - please configure your git user info"
fi

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
echo "1. Configure your git user in ~/.gitconfig.local"
echo "2. Add your wallpaper to ~/.config/swww/"
echo "3. Add any secrets/API keys to ~/.zshrc.local"
echo "4. Install tmux plugins: press prefix + I in tmux"
echo ""
echo "Recommended packages (Arch):"
echo "  yay -S hyprland waybar rofi dunst kitty"
echo "  yay -S swww hypridle hyprlock brightnessctl pamixer playerctl"
echo "  yay -S neovim tmux fzf thefuck atuin btop cava"
echo "  yay -S eza bat fd delta zoxide starship"
echo "  yay -S ttf-maple ttf-jetbrains-mono-nerd noto-fonts-cjk"
echo "  yay -S fcitx5 fcitx5-chinese-addons fcitx5-rime"
echo ""
