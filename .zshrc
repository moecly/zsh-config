# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# 主题
zinit ice depth=1
zinit light romkatv/powerlevel10k

# 自动建议（根据历史记录）
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

# 语法高亮
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

# 补全增强
zinit ice wait lucid
zinit light zsh-users/zsh-completions

# 快速目录跳转
zinit ice wait lucid
zinit light agkozak/zsh-z

# Git 补全
zinit snippet OMZP::git

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
