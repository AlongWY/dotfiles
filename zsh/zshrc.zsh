ZINIT="$HOME/.zinit"
ZINIT_GIT="https://github.com.cnpmjs.org/zdharma/zinit.git"

# Install zinit if not exist
if [ ! -d "$ZINIT" ]; then
    echo "Installing zinit ..."
    if [ -x "$(which git)" ]; then
        mkdir -p "$ZINIT" 2> /dev/null
        git clone "$ZINIT_GIT" "$ZINIT/bin"
    else
        echo "ERROR: please install git before installation !!"
    fi
    if [ ! $? -eq 0 ]; then
        echo ""
        echo "ERROR: downloading zinit ($ZINIT_GIT) failed !!"
        rm -rf $ZINIT
    fi;
fi

# INIT ZINIT
source $ZINIT/bin/zinit.zsh

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
    zinit ice as"command" from"gh-r" bpick"$PICK" mv"bat* -> bat" pick"bat/bat"
    zinit light sharkdp/bat
fi

# sharkdp/fd
if [ ! -x "$(which fd)" ]; then
    zinit ice as"command" from"gh-r" bpick"$PICK" mv"fd* -> fd" pick"fd/fd"
    zinit light sharkdp/fd
fi

# sharkdp/hyperfine
if [ ! -x "$(which hyperfine)" ]; then
    zinit ice as"command" from"gh-r" bpick"$PICK" mv"hyperfine* -> hyperfine" pick"hyperfine/hyperfine"
    zinit light sharkdp/hyperfine
fi

# Peltoche/lsd
if [ ! -x "$(which lsd)" ]; then
    zinit ice as"command" from"gh-r" bpick"$PICK" mv"lsd* -> lsd" pick"lsd/lsd"
    zinit light Peltoche/lsd
fi

# BurntSushi/ripgrep
if [ ! -x "$(which rg)" ]; then
    zinit ice as"command" from"gh-r" bpick"$PICK" mv"ripgrep* -> ripgrep" pick"ripgrep/rg"
    zinit light BurntSushi/ripgrep
fi

# XAMPPRocky/tokei
if [ ! -x "$(which tokei)" ]; then
    zinit ice as"command" from"gh-r" bpick"$PICK" mv"tokei* -> tokei" pick"tokei/tokei"
    zinit light XAMPPRocky/tokei
fi

# starship/starship
if [ ! -x "$(which starship)" ]; then
    zinit ice as"command" from"gh-r" bpick"$PICK" mv"starship* -> starship" pick"starship/starship"
    zinit light starship/starship
fi

# Binary release in archive, from GitHub-releases page.
# After automatic unpacking it provides program "fzf".
if [ ! -x "$(which fzf)" ]; then
    zinit ice from"gh-r" as"program"
    zinit light junegunn/fzf-bin
fi

# }}}

# ENV

# 快速目录跳转
zinit ice lucid wait='1'
zinit light skywind3000/z.lua

# 语法高亮
zinit ice lucid wait='0' atinit='zpcompinit'
zinit light zdharma/fast-syntax-highlighting

# 自动建议
zinit ice lucid wait="0" atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# 补全
zinit ice lucid wait='0'
zinit light zsh-users/zsh-completions

# 加载 OMZ 框架及部分插件
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZ::plugins/extract

zinit ice lucid wait='1'
zinit snippet OMZ::plugins/git/git.plugin.zsh

DISABLE_LS_COLORS=true

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

