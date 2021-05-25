# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# options
export ZSH="/home/jaivin/.oh-my-zsh"
export MYPYPATH="$PWD/types"

ZSH_THEME="powerlevel10k/powerlevel10k"

# plugins
plugins=(git
         zsh-autosuggestions
         fast-syntax-highlighting
         vi-mode
)

# aliases
alias vim="nvim"
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# sources
source $ZSH/oh-my-zsh.sh
