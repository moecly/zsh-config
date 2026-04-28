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

autoload -Uz compinit
compinit -u

# 主题
zinit ice depth=1
zinit light romkatv/powerlevel10k

# 自动建议（根据历史命令智能补全）
zinit light zsh-users/zsh-autosuggestions
# 历史记录配置
HISTFILE=~/.zsh_history     # 历史记录文件位置
HISTSIZE=10000              # 内存中保存的历史条数
SAVEHIST=10000              # 写入文件的历史条数
setopt INC_APPEND_HISTORY   # 新命令立即追加到历史文件
setopt SHARE_HISTORY        # 会话间共享历史记录
setopt EXTENDED_HISTORY     # 记录命令执行时间
setopt HIST_IGNORE_DUPS     # 忽略重复命令
setopt HIST_IGNORE_SPACE    # 忽略以空格开头的命令       

# 语法高亮
zinit light zsh-users/zsh-syntax-highlighting

# 补全增强
zinit light zsh-users/zsh-completions

# 快速目录跳转
# zinit light agkozak/zsh-z

# fzf Tab 补全增强（支持模糊搜索）
zinit light Aloxaf/fzf-tab

# Git 补全
zinit snippet OMZP::git

# 现代化命令别名
if command -v eza >/dev/null 2>&1; then
  alias ls='eza'
  alias ll='eza -l'
  alias la='eza -la'
  alias lt='eza -T'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat='bat'
fi

if command -v trash >/dev/null 2>&1; then
  alias rm='trash'
fi

if command -v fd >/dev/null 2>&1; then
  alias find='fd'
fi

if command -v rg >/dev/null 2>&1; then
  alias grep='rg'
fi

if command -v btop >/dev/null 2>&1; then
  alias top='btop'
fi

if command -v dust >/dev/null 2>&1; then
  alias du='dust'
fi

if command -v duf >/dev/null 2>&1; then
  alias df='duf'
fi

if command -v procs >/dev/null 2>&1; then
  alias ps='procs'
fi

if command -v gping >/dev/null 2>&1; then
  alias ping='gping'
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias cd='z'
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
