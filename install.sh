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
    # SketchyBar用のTapを追加
    brew tap FelixKratz/formulae

    brew install zsh-autosuggestions zsh-syntax-highlighting navi fzf cmatrix cava fastfetch figlet lolcat tty-clock yazi ffmpegthumbnailer unar jq poppler fd ripgrep zoxide sketchybar lua switchaudio-osx nowplaying-cli pnpm
    
    brew install --cask ghostty
  
    brew install --cask raycast
    brew install --cask nikitabobko/tap/aerospace
    brew install --cask alt-tab
    brew install --cask sf-symbols

    # フォントのインストール
    brew install --cask font-hack-nerd-font
    brew install --cask font-sf-pro
    brew install --cask font-sf-mono

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

# -- ghostty --
if command -v ghostty > /dev/null 2>&1; then
  mkdir -p "$HOME/.config/ghostty"
  
  ln -snf "$DOT_DIR/ghostty/config" "$HOME/.config/ghostty/config"
  ln -snf "$DOT_DIR/ghostty/keybindings" "$HOME/.config/ghostty/keybindings"

  echo "Linked: Ghostty config & keybindings"
else
  echo "Ghostty not found, skipping..."
fi

# -- nvim --
if command -v nvim > /dev/null 2>&1; then
  mkdir -p "$HOME/.config"

  ln -snf "$DOT_DIR/nvim" "$HOME/.config/nvim"

  echo "Linked: Nvim directory" 
else
  echo "Nvim not found, skipping..."
fi

# -- navi --
if command -v navi > /dev/null 2>&1; then
  echo "Linking navi custom cheats..."

  NAVI_DATA_DIR="$HOME/.local/share/navi/cheats"

  mkdir -p "$NAVI_DATA_DIR"
  ln -snf "$HOME/dotfiles/cheats" "$NAVI_DATA_DIR/custom_cheats"
  echo "Linked: custom cheats to navi"
else
  echo "Navi not found, skipping..."
fi

# -- fastfetch --
if command -v fastfetch > /dev/null 2>&1; then
  mkdir -p "$HOME/.config/fastfetch"
  ln -snf "$DOT_DIR/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"
  echo "Linked: Fastfetch config"
else
  echo "Fastfetch not found, skipping..."
fi

# -- aerospace --
if command -v aerospace > /dev/null 2>&1; then
  mkdir -p "$HOME/.config/aerospace"
  ln -snf "$DOT_DIR/aerospace/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"
  echo "Linked: Aerospace config"
else
  echo "Aerospace not found, skipping..."
fi

# -- sketchybar --
if command -v sketchybar > /dev/null 2>&1; then
  mkdir -p "$HOME/.config"

  FONT_DIR="$HOME/Library/Fonts"
  if [ ! -f "$FONT_DIR/sketchybar-app-font.ttf" ]; then
    echo "Downloading sketchybar-app-font.ttf..."
    curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.5/sketchybar-app-font.ttf -o "$FONT_DIR/sketchybar-app-font.ttf"
  fi

  if [ ! -f "$FONT_DIR/sketchybar-app-font-bg.ttf" ]; then
    echo "Downloading sketchybar-app-font-bg.ttf..."
    curl -L https://github.com/SoichiroYamane/sketchybar-app-font-bg/releases/download/v0.0.11/sketchybar-app-font-bg.ttf -o "$FONT_DIR/sketchybar-app-font-bg.ttf"
  fi

  # SbarLuaのインストール
  if [ ! -f "$HOME/.local/share/sketchybar_lua.so" ] && [ ! -f "/usr/local/lib/sketchybar/sketchybar.so" ]; then
    echo "Compiling and Installing StarLua..."
    if [ -d "/tmp/SbarLua" ]; then rm -rf /tmp/SbarLua; fi
    git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua
    cd /tmp/SbarLua/ && make install && cd -
    rm -rf /tmp/SbarLua/
  else
    echo "SbarLua is already installed."
  fi

  # 設定ファイルのリンク
  ln -snf "$DOT_DIR/sketchybar" "$HOME/.config/sketchybar"

  chmod +x "$DOT_DIR/sketchybar/sketchybarrc"

  find "$DOT_DIR/sketchybar" -name "*.sh" -exec chmod +x {} \;

  echo "Linked: SketchyBar directory and dependencies installed."

  # フォントの更新
  if [ -f "$DOT_DIR/sketchybar/icon_updater.sh" ]; then
    echo "Running icon_updater.sh..."
    pushd "$DOT_DIR/sketchybar" > /dev/null
    ./icon_updater.sh
    popd > /dev/null
  fi
  
  brew services restart sketchybar
  sketchybar --reload
else
  echo "SketchyBar not found, skipping..."
fi

echo "All setting has been completed!!!!"

