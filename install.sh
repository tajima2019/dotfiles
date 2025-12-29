#!/bin/bash

# dotfiles フォルダの場所
DOT_DIR="$HOME/dotfiles"

echo "creating symbolic links..."

# --------------------------------------------------
# 1. ホームディレクトリ直下に置くファイル群
# --------------------------------------------------

files=(
  ".zshrc"
  ".zsh_prompt"
  ".zsh_functions"
  ".bashrc"
  ".vimrc"
)

for file in "${files[@]}"; do
  ln -snf "$DOT_DIR/$file" "$HOME/$file"
  echo "Linked: $HOME/$file"
done

# -------------------------------------------------
# 2. .config フォルダに入れるもの
# -------------------------------------------------

# ghostty 
if command -v ghostty > /dev/null 2>&1; then
  mkdir -p "$HOME/.config/ghostty"
  ln -snf "$DOT_DIR/ghostty/config" "$HOME/.config/ghostty/config"
  echo "Linked: Ghostty config"
else
  echo "Ghostty not found, skipping..."
fi

