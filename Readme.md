# Dotfiles ![GitHub](https://img.shields.io/github/license/alongwy/dotfiles?style=for-the-badge) [![Fish Shell Version](https://img.shields.io/badge/fish-≥v2.2.0-007EC7.svg?style=for-the-badge)](http://fishshell.com) [![Zsh Shell Version](https://img.shields.io/badge/zsh-≥v5.3-red.svg?style=for-the-badge)](http://zsh.sourceforge.net/) ![GitHub repo size](https://img.shields.io/github/repo-size/alongwy/dotfiles?style=for-the-badge)

## 特性

1. 使用 [Zplugin](https://github.com/zdharma/zplugin) 作为 zsh 插件工具加快插件加载速度 [![Zsh Support](https://img.shields.io/badge/zsh-support-red.svg?style=flat)](http://zsh.sourceforge.net/)
2. 使用一些更好的工具取代默认的 binutils [![Zsh Support](https://img.shields.io/badge/zsh-support-red.svg?style=flat)](http://zsh.sourceforge.net/)
   + [lsd](https://github.com/Peltoche/lsd) -> ls
   + [bat](https://github.com/sharkdp/bat) -> cat
   + [fd](https://github.com/sharkdp/fd) -> find
   + [tokei](https://github.com/XAMPPRocky/tokei) -> cloc
   + [ripgrep](https://github.com/BurntSushi/ripgrep) -> grep
   + [direnv](https://github.com/direnv/direnv)/[fzf](https://github.com/junegunn/fzf) 支持
3. [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish) 支持[![Zsh/Fish Support](https://img.shields.io/badge/fish-support-007EC7.svg?style=flat)](http://fishshell.com)
4. [Starship](https://github.com/starship/starship) 支持 ![Zsh/Fish Support](https://img.shields.io/badge/zsh_fish-support-purple.svg?style=flat)

## 安装需求

+ zsh
+ git
+ fish

## 安装

使用curl安装

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/AlongWY/dotfiles/master/install.sh)"
```

使用wget安装

```bash
sh -c "$(wget https://raw.githubusercontent.com/AlongWY/dotfiles/master/install.sh -O -)"
```

## Todo list

+ [ ] Fish binutils 支持
+ [ ] Safe rm 支持
