#!/bin/zsh
#===============================================================================
#
#      NOTES: For this to work you must have installed wget/curl and git
#
#===============================================================================

#============================================
# Variables
#============================================

DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_REPO="https://github.com/AlongWY/dotfiles"

#============================================
# Clone dotfiles repo
#============================================

if [ -x "$(which git)" ]; then
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
    echo "ERROR: please install git before installation !!"
    exit
fi

declare -A LINK_MAP=(
    ["$HOME/.gitconfig"]="$DOTFILES_DIR/gitconfig"
    ["$HOME/.zshrc"]="$DOTFILES_DIR/config/zsh/zshrc"
    ["$HOME/.cargo/config.toml"]="$DOTFILES_DIR/config/cargo/config.toml"
    ["$HOME/.config/pixi/config.toml"]="$DOTFILES_DIR/.config/pixi/config.toml"
    ["$HOME/.config/fish/config.toml"]="$DOTFILES_DIR/config/fish/config.toml"
)

# 遍历字典，创建符号链接（如果目标不存在）
for target in "${!LINK_MAP[@]}"; do
    source="${LINK_MAP[$target]}"
    if [ ! -e "$target" ]; then
        # 确保父目录存在
        mkdir -p "$(dirname "$target")"
        ln -s "$source" "$target"
        echo "Linked $source → $target"
    fi
done


#===================================
# Set zsh as the default shell
#===================================
chsh -s $(which fish)

#=========================================================
# Give the user a summary of what has been installed
#=========================================================
echo "Dotfiles install finished! Enjoy it. --along"
