# -- 起動時の表示 --
neofetch

# -- パス設定 --
export PATH="$HOME/go/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

# -- conda初期設定 --
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# -- 自作関数の読み込み --
if [ -f ~/.zsh_functions ]; then
  source ~/.zsh_functions
fi

# -- プロンプト設定 --
if [ -f ~/.zsh_prompt ]; then
  source ~/.zsh_prompt
fi

# -- プラグイン設定の読み込み --
if [ -f ~/.zsh_plugins ]; then
  source ~/.zsh_plugins
fi

