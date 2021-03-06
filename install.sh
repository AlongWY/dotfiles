#!/bin/zsh
#===============================================================================
#
#      NOTES: For this to work you must have installed wget/curl and git
#
#===============================================================================

#============================================
# Variables
#============================================

dotfiles_dir="$HOME/dotfiles"
dotfiles_repo="https://github.com/AlongWY/dotfiles"

#============================================
# Clone dotfiles repo
#============================================

if [ -x "$(which git)" ]; then
    git clone "$dotfiles_repo" "$dotfiles_dir"
else
    echo "ERROR: please install git before installation !!"
    exit
fi

#============================================
#   Install ZSH Config
#============================================

# zsh
rm -rf $HOME/.zshrc > /dev/null 2>&1
rm -rf $HOME/.zplugin > /dev/null 2>&1
ln -sf $dotfiles_dir/zsh/zshrc.zsh $HOME/.zshrc

#============================================
# Install oh-my-fish
#============================================

if [ -x "$(which git)" ]; then
    curl -L https://get.oh-my.fish | fish
    rm -rf $HOME/.config/fish/ > /dev/null 2>&1
    rm -rf $HOME/.local/share/omf > /dev/null 2>&1
    ln -sf $dotfiles_dir/fish/omf $HOME/.local/share/omf
fi

#============================================
# Create symlinks in the home folder
#============================================

ln -sf $dotfiles_dir/starship/starship.toml $HOME/.config/starship.toml

# gitconfig
if [ ! -f "$HOME/.gitconfig" ]; then
    ln -s $dotfiles_dir/gitconfig $HOME/.gitconfig
fi

#===================================
# Set zsh as the default shell
#===================================
chsh -s $(which zsh)

#=========================================================
# Give the user a summary of what has been installed
#=========================================================
echo "Dotfiles install finished! Enjoy it. --along"
