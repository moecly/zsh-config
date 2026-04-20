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
