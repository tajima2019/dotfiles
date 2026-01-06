#!/bin/bash

# dotfiles フォルダの場所
DOT_DIR="$HOME/dotfiles"

# -------------------------------------------------
# 1. ツールのインストール
# -------------------------------------------------
echo "installing required tools..."
if [ "$(uname)" == "Darwin" ]; then
  if command -v brew >/dev/null 2>&1; then
    echo "Installing/Updating Homebrew..."
    brew install zsh-autosuggestions zsh-syntax-highlighting navi fzf cmatrix cava fastfetch figlet lolcat tty-clock
    brew install --cask raycast
  else
    echo "Error: Homebrew is not installed. Please install it first."
  fi
fi  

echo "creating symbolic links..."

# --------------------------------------------------
# 2. ホームディレクトリ直下に置くファイル群
# --------------------------------------------------

files=(
  ".zshrc"
  ".zsh_prompt"
  ".zsh_functions"
  ".zsh_plugins"
  ".bashrc"
  ".gitconfig"
  ".hushlogin"
)

for file in "${files[@]}"; do
  ln -snf "$DOT_DIR/$file" "$HOME/$file"
  echo "Linked: $HOME/$file"
done

# -------------------------------------------------
# 3. .config フォルダに入れるもの
# -------------------------------------------------

# ghostty 
if command -v ghostty > /dev/null 2>&1; then
  mkdir -p "$HOME/.config/ghostty"
  
  ln -snf "$DOT_DIR/ghostty/config" "$HOME/.config/ghostty/config"
  ln -snf "$DOT_DIR/ghostty/keybindings" "$HOME/.config/ghostty/keybindings"

  echo "Linked: Ghostty config & keybindings"
else
  echo "Ghostty not found, skipping..."
fi

# nvim
if command -v nvim > /dev/null 2>&1; then
  mkdir -p "$HOME/.config"

  ln -snf "$DOT_DIR/nvim" "$HOME/.config/nvim"

  echo "Linked: Nvim directory" 
else
  echo "Nvim not found, skipping..."
fi

# navi
if command -v navi > /dev/null 2>&1; then
  echo "Linking navi custom cheats..."

  NAVI_DATA_DIR="$HOME/.local/share/navi/cheats"

  mkdir -p "$NAVI_DATA_DIR"
  ln -snf "$HOME/dotfiles/cheats" "$NAVI_DATA_DIR/custom_cheats"
  echo "Linked: custom cheats to navi"
else
  echo "Navi not found, skipping..."
fi

echo "All setting has been completed!!!!"

