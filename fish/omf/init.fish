# commands
alias ls 'lsd'
alias l 'ls -l'
alias la 'ls -a'
alias lla 'ls -la'
alias lt 'ls --tree'

alias cat 'bat'
alias grep 'rg'
alias find 'fd'
alias cloc 'tokei'

# rm wine mime
function rm-wine-mime -d "Remove wine mine."
    rm -f ~/.local/share/applications/wine-extension*.desktop
    rm -f ~/.local/share/icons/hicolor/*/*/application-x-wine-extension*
    rm -f ~/.local/share/applications/mimeinfo.cache
    rm -f ~/.local/share/mime/packages/x-wine*
    rm -f ~/.local/share/mime/application/x-wine-extension*
    update-desktop-database ~/.local/share/applications
end

# starship
starship init fish | source
