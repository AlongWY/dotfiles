ZPLUGIN="$HOME/.zplugin"
ZPLUGIN_GIT="https://github.com/zdharma/zplugin.git"
ZPLUGIN_MODULE="$HOME/.zplugin/bin/zmodules/Src/zdharma/zplugin.so"

VIRTUALENV="/usr/bin/virtualenvwrapper_lazy.sh"
MINICONDA="$HOME/miniconda3"

# Install zplugin if not exist
if [ ! -d "$ZPLUGIN" ]; then
    echo "Installing zplugin ..."
    if [ -x "$(which git)" ]; then
        mkdir -p "$ZPLUGIN" 2> /dev/null
        git clone "$ZPLUGIN_GIT" "$ZPLUGIN/bin"
        source $ZPLUGIN/bin/zplugin.zsh
        zplugin module build
    else
        echo "ERROR: please install git before installation !!"
    fi
    if [ ! $? -eq 0 ]; then
        echo ""
        echo "ERROR: downloading zplugin ($ZPLUGIN_GIT) failed !!"
        rm -rf $ZPLUGIN
    fi;
fi

# LOAD ZMOUDLE
module_path+=("$ZPLUGIN/bin/zmodules/Src")
zmodload zdharma/zplugin

# INIT ZPLUGIN
source $ZPLUGIN/bin/zplugin.zsh

# 平台判断 {{{
if [[ "$(uname)" == "Darwin" ]]; then
# Mac OS X 操作系统
PICK="*darwin*"

elif [[ "$(uname)" == "Linux" ]]; then
# GNU/Linux操作系统
PICK="*musl*"

elif [[ "$(uname)" == "MINGW32_NT" ]]; then
# Windows NT操作系统
PICK="*windows*"

fi
# }}}

# 安装插件 {{{

# sharkdp/bat
if [ ! -x "$(which bat)" ]; then
    zplugin ice as"command" from"gh-r" bpick"$PICK" mv"bat* -> bat" pick"bat/bat"
    zplugin light sharkdp/bat
fi

# sharkdp/fd
if [ ! -x "$(which fd)" ]; then
    zplugin ice as"command" from"gh-r" bpick"$PICK" mv"fd* -> fd" pick"fd/fd"
    zplugin light sharkdp/fd
fi

# Peltoche/lsd
if [ ! -x "$(which lsd)" ]; then
    zplugin ice as"command" from"gh-r" bpick"$PICK" mv"lsd* -> lsd" pick"lsd/lsd"
    zplugin light Peltoche/lsd
fi

# BurntSushi/ripgrep
if [ ! -x "$(which rg)" ]; then
    zplugin ice as"command" from"gh-r" bpick"$PICK" mv"ripgrep* -> ripgrep" pick"ripgrep/rg"
    zplugin light BurntSushi/ripgrep
fi

# XAMPPRocky/tokei
if [ ! -x "$(which tokei)" ]; then
    zplugin ice as"command" from"gh-r" bpick"$PICK" mv"tokei* -> tokei" pick"tokei/tokei"
    zplugin light XAMPPRocky/tokei
fi

# starship/starship
if [ ! -x "$(which starship)" ]; then
    zplugin ice as"command" from"gh-r" bpick"$PICK" mv"starship* -> starship" pick"starship/starship"
    zplugin light starship/starship
fi

# Binary release in archive, from GitHub-releases page.
# After automatic unpacking it provides program "fzf".
zplugin ice from"gh-r" as"program"
zplugin light junegunn/fzf-bin

zplugin ice from"gh-r" as"program" mv"direnv* -> direnv" \
    './direnv hook zsh > zhook.zsh' atpull'%atclone' pick"direnv"
zplugin light direnv/direnv

zplugin ice wait blockf atpull'zplugin creinstall -q .'
zplugin light zsh-users/zsh-completions

zplugin ice wait atload"_zsh_autosuggest_start"
zplugin light zsh-users/zsh-autosuggestions

zplugin ice wait atinit"zpcompinit; zpcdreplay"
zplugin light zdharma/fast-syntax-highlighting

# zdharma/history-search-multi-word
zstyle ":history-search-multi-word" page-size "11"
zplugin ice wait"1" lucid
zplugin light zdharma/history-search-multi-word

zplugin light zsh-users/zsh-history-substring-search

# zplugin light zpm-zsh/ssh

zplugin ice wait atinit"zpcompinit; zpcdreplay" lucid
zplugin light esc/conda-zsh-completion

# }}}

# 初始化 {{{
autoload -Uz compinit
compinit
zplugin cdreplay -q # <- execute compdefs provided by rest of plugins
# zplugin cdlist    # look at gathered compdefs
# }}}

#关于历史纪录的配置 {{{
#历史纪录条目数量
export HISTSIZE=10000
#注销后保存的历史纪录条目数量
export SAVEHIST=10000
#历史纪录文件
export HISTFILE=~/.zhistory
#以附加的方式写入历史纪录
setopt INC_APPEND_HISTORY
#如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS      
#为历史纪录中的命令添加时间戳      
setopt EXTENDED_HISTORY      

#启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD
#相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS

# }}}

#禁用 core dumps
limit coredumpsize 0


#自动补全功能 {{{
setopt AUTO_LIST
setopt AUTO_MENU
#开启此选项，补全时会直接选中菜单项
setopt MENU_COMPLETE

# 自动补全

zstyle ':completion:*' menu select
#自动补全缓存
#zstyle ':completion::complete:*' use-cache on
#zstyle ':completion::complete:*' cache-path .zcache
#zstyle ':completion:*:cd:*' ignore-parents parent pwd

#自动补全选项
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

#路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always

#彩色补全菜单
eval $(dircolors -b)
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#错误校正      
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

#kill 命令补全      
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

#补全类型提示分组
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'                  #'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'                      #'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'        #'

# Highlight the current autocomplete option
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Better SSH/Rsync/SCP Autocomplete
zstyle ':completion:*:(scp|rsync):*' tag-order ' hosts:-ipaddr:ip\ address hosts:-host:host files'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# Allow for autocomplete to be case insensitive
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  '+l:|?=** r:|?=**'


bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# }}}



# Conda
if [ -d "$MINICONDA" ]; then
    __conda_setup="$('$MINICONDA/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$MINICONDA/etc/profile.d/conda.sh" ]; then
            . "$MINICONDA/etc/profile.d/conda.sh"
        else
            export PATH="$MINICONDA/bin:$PATH"
        fi
    fi
    unset __conda_setup
else
    conda () {
        echo "conda not installed!!!"
    }
fi

# virtualenv
if [ -f "$VIRTUALENV" ]; then
    source "$VIRTUALENV"
fi

# alias
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias cat='bat' 
alias grep='rg' 
alias find='fd' 
alias cloc='tokei' 

# clean wine mime
clean-wine-mime () {
    SHARE="$HOME/.local/share"
    rm -f $SHARE/applications/wine-extension*.desktop &> /dev/null 
    rm -f $SHARE/icons/hicolor/*/*/application-x-wine-extension* &> /dev/null
    rm -f $SHARE/applications/mimeinfo.cache &> /dev/null
    rm -f $SHARE/mime/packages/x-wine* &> /dev/null
    rm -f $SHARE/mime/application/x-wine-extension* &> /dev/null
    update-desktop-database $SHARE/applications &> /dev/null
}

if [ -x "$(which starship)" ]; then
    eval "$(starship init zsh)"
fi
