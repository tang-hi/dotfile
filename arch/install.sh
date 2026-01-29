#!/bin/bash

# Dotfiles installation script for Arch Linux with Hyprland

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles from: $DOTFILES_DIR"

# Create necessary directories
mkdir -p ~/.config/{nvim,hypr/scripts,kitty,alacritty,waybar,rofi,dunst/icons,swww}
mkdir -p ~/.tmux/plugins

# Backup existing configs
backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
echo "Creating backup directory: $backup_dir"
mkdir -p "$backup_dir"

backup_if_exists() {
    if [ -e "$1" ]; then
        echo "Backing up: $1"
        cp -r "$1" "$backup_dir/"
    fi
}

# Backup existing configs
backup_if_exists ~/.zshrc
backup_if_exists ~/.bashrc
backup_if_exists ~/.gitconfig
backup_if_exists ~/.tmux.conf
backup_if_exists ~/.config/nvim
backup_if_exists ~/.config/hypr
backup_if_exists ~/.config/kitty
backup_if_exists ~/.config/alacritty
backup_if_exists ~/.config/waybar
backup_if_exists ~/.config/rofi
backup_if_exists ~/.config/dunst

# Install shell configs
echo "Installing shell configs..."
cp "$DOTFILES_DIR/.zshrc" ~/
cp "$DOTFILES_DIR/.bashrc" ~/
cp "$DOTFILES_DIR/.gitconfig" ~/
cp "$DOTFILES_DIR/.tmux.conf" ~/

# Install nvim config
echo "Installing nvim config..."
cp -r "$DOTFILES_DIR/.config/nvim/"* ~/.config/nvim/

# Install hyprland config
echo "Installing hyprland config..."
cp -r "$DOTFILES_DIR/.config/hypr/"* ~/.config/hypr/
chmod +x ~/.config/hypr/scripts/*.sh

# Install terminal configs
echo "Installing terminal configs..."
cp -r "$DOTFILES_DIR/.config/kitty/"* ~/.config/kitty/
cp -r "$DOTFILES_DIR/.config/alacritty/"* ~/.config/alacritty/

# Install waybar config
echo "Installing waybar config..."
cp -r "$DOTFILES_DIR/.config/waybar/"* ~/.config/waybar/

# Install rofi config
echo "Installing rofi config..."
cp -r "$DOTFILES_DIR/.config/rofi/"* ~/.config/rofi/

# Install dunst config
echo "Installing dunst config..."
cp -r "$DOTFILES_DIR/.config/dunst/"* ~/.config/dunst/

# Install tmux plugin manager
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo ""
echo "=========================================="
echo "Dotfiles installed successfully!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Configure your monitors in ~/.config/hypr/hyprland.conf"
echo "2. Add your wallpaper to ~/.config/swww/"
echo "3. Configure your git user in ~/.gitconfig"
echo "4. Add any secrets to ~/.zshrc.local (not tracked by git)"
echo "5. Install tmux plugins: press prefix + I in tmux"
echo "6. Install oh-my-zsh if not already: sh -c \"\$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
echo ""
echo "Recommended packages (Arch):"
echo "  yay -S hyprland waybar rofi dunst kitty alacritty"
echo "  yay -S swww hypridle hyprlock brightnessctl pamixer playerctl"
echo "  yay -S neovim tmux fzf thefuck atuin"
echo "  yay -S ttf-maple ttf-jetbrains-mono-nerd"
echo ""
