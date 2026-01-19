#!/bin/bash
set -e

# dotfilesディレクトリに移動
cd "$(dirname "$0")"

# Ansibleのインストール
if ! command -v ansible-playbook > /dev/null 2>&1; then
  echo "Ansible not found. Installing..."

  # macOSの場合
  if [ "$(uname)" == "Darwin" ]; then
    if ! command -v brew > /dev/null 2>&1; then
      echo "Homebrew not found. Installing..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

      if [ -f "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    fi
    # Ansibleをインストール
    brew install ansible

  # Arch Linuxの場合(pacman)
  elif [ -f "/etc/arch-release" ]; then
    echo "Detected Arch Linux."

  else
    echo "Unsupported OS. Please install Ansible manually."
    exit 1
  fi

else
  echo "Ansible is already installed."
fi

# 必要なコレクションのインストール
echo "Installing Ansible Galaxy colllections..."
ansible-galaxy collection install community.general

# Playbook の実行
echo "Running Ansible Playbook..."
ansible-playbook local.yml -K

echo "Done!"

