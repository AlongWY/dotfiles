set -x UV_PYTHON_INSTALL_MIRROR https://gh-proxy.com/https://github.com/astral-sh/python-build-standalone/releases/download
set -x UV_INSTALLER_GITHUB_BASE_URL https://gh-proxy.com/https://github.com
set -x HF_ENDPOINT https://hf-mirror.com

fish_add_path $HOME/.local/bin
fish_add_path $HOME/.pixi/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.go/bin
fish_add_path $HOME/.go/current/bin


if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    zoxide init fish | source
    atuin init fish | source
    pixi completion --shell fish | source
end

if test -f /usr/share/modules/init/fish
    source /usr/share/modules/init/fish
end

for file in $HOME/.pixi/completions/fish/**.fish
    source $file 2>/dev/null
end

# alias
alias ls="lsd"
alias l="lsd -l"
alias la="lsd -a"
alias lla="lsd -la"
alias lt="lsd --tree"
alias rm="rm -i"
alias sq="squeue -u (whoami)"
