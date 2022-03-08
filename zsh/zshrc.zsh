# INIT HOMEBREW
eval "$(/usr/local/bin/brew shellenv)"
# eval "$(sheldon source)"

# INSTALL ZI
if [ ! -d "$ZI_HOME" ]; then
    echo "Installing zi ..."
    if [ -x "$(which git)" ]; then
        mkdir -p "$ZI_HOME" 2> /dev/null
        git clone "$ZI_GIT" "$ZI_HOME/bin"
    else
        echo "ERROR: please install git before installation !!"
    fi
    if [ ! $? -eq 0 ]; then
        echo ""
        echo "ERROR: downloading zinit ($ZI_GIT) failed !!"
        rm -rf $ZI_HOME
    fi;
fi

# INIT ZI
source $ZI_HOME/bin/zi.zsh

# 快速目录跳转
zi ice lucid wait='1'
zi light skywind3000/z.lua

# 语法高亮
zi ice lucid wait='0' atinit='zpcompinit'
zi light zdharma/fast-syntax-highlighting

# 自动建议
zi ice lucid wait="0" atload='_zsh_autosuggest_start'
zi light zsh-users/zsh-autosuggestions

# 补全
zi ice lucid wait='0'
zi light zsh-users/zsh-completions

# 加载 OMZ 框架及部分插件
zi snippet OMZ::lib/completion.zsh
zi snippet OMZ::lib/history.zsh
zi snippet OMZ::lib/key-bindings.zsh
zi snippet OMZ::lib/theme-and-appearance.zsh
zi snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zi snippet OMZ::plugins/extract

zi ice lucid wait='1'
zi snippet OMZ::plugins/git/git.plugin.zsh

zi ice lucid wait as'completion' blockf has'cargo'
zi snippet https://github.com/rust-lang/cargo/blob/master/src/etc/_cargo

DISABLE_LS_COLORS=true

# BAT 支持鼠标滚动
export BAT_PAGER="less -RF"

# alias
alias ls='exa --icons'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
# alias cat='bat' 
alias cp='xcp'
alias grep='rg' 
alias find='fd' 
alias cloc='tokei' 
alias ps='procs' 
alias sed='sd' 
alias du='dust' 

# 配置 fzf 使用 fd
export FZF_DEFAULT_COMMAND='fd --type f'

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if which pyenv-virtualenv-init > /dev/null; then
  eval "$(pyenv virtualenv-init -)"; 
fi

if [ -x "$(which starship)" ]; then
    eval "$(starship init zsh)"
fi

# rbenv
eval "$(rbenv init -)"

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi
