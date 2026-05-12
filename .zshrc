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
# 使用 zinit 安装 Starship (替代 p10k)
zinit ice as"command" from"gh-r"
zinit light starship/starship
export STARSHIP_CONFIG=~/.moecly_conf/zsh/starship.toml
# 初始化 Starship
eval "$(starship init zsh)"

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
#zinit snippet OMZP::git

autoload -Uz compinit
compinit -u

export EDITOR=nvim

# --- Vi Mode 增强配置 ---
bindkey -v  # 你配置里已有的，确保在这些自定义绑定之前

# 1. 即使在 Vi 模式下，也找回你习惯的 Ctrl 组合键（插入模式下有效）
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^N' down-line-or-history
bindkey -M viins '^F' forward-char
bindkey -M viins '^B' backward-char
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line

# 2. 在命令模式（Normal Mode）下，让 j/k 支持搜索当前已输入的开头
# 比如输入 'vim' 按 k，只会匹配 vim 开头的历史
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search

# 3. 减少按 Esc 后的延迟（默认延迟会导致切换模式卡顿）
export KEYTIMEOUT=1

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

if command -v trash-put >/dev/null 2>&1; then
  alias rm='trash-put'
  compdef _rm trash-put
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

# Btrfs balance 快捷命令
# 用法: btrfs-balance [dusage] [musage] [path]
btrfs-balance() {
  sudo btrfs balance start -dusage=${1:-5} -musage=${2:-5} ${3:-/}
}

# Btrfs 子卷列表
btrfs-list() {
  sudo btrfs subvolume list "$@" | rg -v ".snapshot"
}

# Btrfs 创建子卷
btrfs-create() {
  sudo btrfs subvolume create "$@"
}

# Btrfs 删除子卷
btrfs-delete() {
  sudo btrfs subvolume delete "$@"
}

# Btrfs 创建快照
btrfs-snapshot() {
  sudo btrfs subvolume snapshot "$@"
}

# Btrfs 显示子卷详细信息
btrfs-show() {
  sudo btrfs subvolume show "$@"
}

# Btrfs 发送子卷快照
btrfs-send() {
  sudo btrfs send "$@"
}

# Btrfs 接收子卷快照
btrfs-receive() {
  sudo btrfs receive "$@"
}

# Btrfs 文件系统使用情况
btrfs-usage() {
  sudo btrfs fi usage "$@"
}

# Btrfs 文件系统碎片整理
btrfs-defrag() {
  sudo btrfs filesystem defragment -r -czstd -vv --step "$@"
}

# Btrfs maintenance 定时任务刷新
btrfs-refresh() {
  sudo /usr/share/btrfsmaintenance/btrfsmaintenance-refresh-cron.sh "$@"
}

# 修改文件所有者为当前用户
chown-me() {
  sudo chown $USER:$USER "$@"
}

# rsync 带进度显示复制
rscp() {
  sudo rsync -avhP --info=progress2 "$@"
}

# rsync 同步
rscpd() {
  sudo rsync -avhP --delete-during --info=progress2 "$@"
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
