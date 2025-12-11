#!/bin/bash

echo "🔧 Setting up your personalized environment..."

# Determine where the dotfiles are (where this script is located)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Debug: Show where we are
echo "Current directory: $(pwd)"
echo "Home directory: $HOME"
echo "Dotfiles directory: $DOTFILES_DIR"

# Backup existing configs
backup_if_exists() {
    if [ -f "$1" ]; then
        echo "📦 Backing up existing $1 to $1.backup"
        mv "$1" "$1.backup"
    fi
}

# Link dotfiles
link_dotfile() {
    source_file="$DOTFILES_DIR/$1"
    target_file="$HOME/$1"
    
    if [ -f "$source_file" ]; then
        backup_if_exists "$target_file"
        echo "🔗 Linking $1"
        ln -sf "$source_file" "$target_file"
    else
        echo "⚠️  $source_file not found, skipping"
    fi
}

# Link all dotfiles
link_dotfile ".gitconfig"
link_dotfile ".bash_aliases"

# Append custom bashrc to existing .bashrc
if [ -f "$DOTFILES_DIR/.bashrc_custom" ]; then
    echo "✨ Adding custom bashrc settings"
    
    # Check if already added (to avoid duplicates)
    if ! grep -q "Custom settings from dotfiles" ~/.bashrc 2>/dev/null; then
        echo "" >> ~/.bashrc
        echo "# Custom settings from dotfiles" >> ~/.bashrc
        cat "$DOTFILES_DIR/.bashrc_custom" >> ~/.bashrc
        echo "✅ Custom bashrc settings added"
    else
        echo "ℹ️  Custom bashrc settings already present"
    fi
else
    echo "⚠️  .bashrc_custom not found, skipping"
fi

echo "✅ Dotfiles setup complete!"
echo "🎉 Your environment is ready!"
echo ""
echo "To apply changes, run: source ~/.bashrc"
