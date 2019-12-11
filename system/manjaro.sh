#!/bin/bash

password=$(kdialog --title "本脚本需要 sudo 权限" --password "请输入密码")

function sudorun() {
    echo "$password" | sudo -S $*
}

function update_mirror() {
    echo "-----正在更新仓库列表------"
    sudorun pacman-mirrors -c China -m rank

    echo "-----更新仓库列表------"
    sudorun pacman -S --noconfirmyyuu

    echo "-----加入ArchlinuxCN源-----"
    if ! grep -q "archlinuxcn" "/etc/pacman.conf"; then
        ehco "[archlinuxcn]" | sudorun tee -a /etc/pacman.conf
        ehco "SigLevel = Optional TrustedOnly" | sudorun tee -a /etc/pacman.conf
        ehco "Server = https://mirrors.ustc.edu.cn/archlinuxcn/\$arch" | sudorun tee -a /etc/pacman.conf
    fi
}
function main() {
    choice=$(
        kdialog --separate-output --checklist "选择要安装的软件:" \
            1 "更换国内源" on \
            2 "Noto 字体" off \
            3 "Nerd 字体" off \
            4 "文泉驿 字体" off \
            5 "Fcitx  输入法" off \
            6 "Chrome 浏览器" off \
            7 "网易云音乐" off \
            8 "WPS 办公套件" off \
            9 "Micro 编辑器" off \
            10 "VS Code编辑器" off \
            11 "QOwnnotes 笔记" off \
            12 "Gimp 绘图工具" off \
            13 "krita 绘图工具" off \
            14 "Yay 包管理器" off \
            15 "Aria2 下载工具" off \
            16 "Proxychains 终端代理工具" off \
            17 "Texlive 套件" off \
            18 "FileZilla 文件传输工具" off \
            19 "Wireshark 网络分析工具" off \
            20 "Git 版本控制工具" off \
            21 "GNU 编译工具链" off \
            22 "LLVM 编译工具链" off \
            23 "Rust 编译工具链" off \
            24 "Meson 建构系统" off \
            25 "CMake 建构系统" off \
            26 "Ninja 建构系统" off \
            27 "Jetbrains IDEA" off \
            28 "Jetbrains Clion" off \
            29 "Jetbrains Pycharm" off
    )

    case $? in
    0)
        case $(expr length "$choice") in
        0)
            kdialog --sorry "没有做任何选项"
            ;;
        *)
            for result in $choice; do
                case $result in
                '1') update_mirror ;;
                '2') sudorun pacman -S --noconfirm noto-fonts noto-fonts-cjk noto-fonts-compat noto-fonts-emoji noto-fonts-extra ;;
                '3') sudorun pacman -S --noconfirm nerd-fonts-complete nerd-fonts-noto-sans-mono nerd-fonts-terminus ttf-nerd-fonts-symbols ;;
                '4') sudorun pacman -S --noconfirm wqy-bitmapfont wqy-microhei wqy-microhei-lite wqy-zenhei ;;
                '5')
                    sudorun pacman -S --noconfirm fcitx fcitx-gtk2 fcitx-gtk3 fcitx-qt5 kcm-fcitx
                    ehco "export GTK_IM_MODULE=fcitx" | sudorun tee -a ~/.xprofile
                    ehco "export QT_IM_MODULE=fcitx" | sudorun tee -a ~/.xprofile
                    ehco "export XMODIFIERS=\"@im=fcitx\"" | sudorun tee -a ~/.xprofile
                    ;;
                '6') sudorun pacman -S --noconfirm google-chrome ;;
                '7') sudorun pacman -S --noconfirm netease-cloud-music ;;
                '8') sudorun pacman -S --noconfirm wps-office ;;
                '9') sudorun pacman -S --noconfirm micro-manjaro ;;
                '10') sudorun pacman -S --noconfirm visual-studio-code-bin ;;
                '11') sudorun pacman -S --noconfirm qownnotes ;;
                '12') sudorun pacman -S --noconfirm gimp gimp-dbp gimp-help-zh_cn gimp-nufraw gimp-plugin-fblur gimp-plugin-gmic gimp-plugin-lqr gimp-plugin-restnthesizer-git gimp-plugin-wavelet-denoise gimp-refocus ;;
                '13') sudorun pacman -S --noconfirm krita krita-plugin-gmic ;;
                '14') sudorun pacman -S --noconfirm yay ;;
                '15') sudorun pacman -S --noconfirm aria2 ;;
                '16') sudorun pacman -S --noconfirm proxychains-ng ;;
                '17') sudorun pacman -S --noconfirm texlive-most texlive-lang ;;
                '18') sudorun pacman -S --noconfirm filezilla ;;
                '19') sudorun pacman -S --noconfirm wireshark-qt ;;
                '20') sudorun pacman -S --noconfirm git ;;
                '21') sudorun pacman -S --noconfirm base-devel ;;
                '22') sudorun pacman -S --noconfirm lld lldb clang ;;
                '23') sudorun pacman -S --noconfirm rust rust-docs ;;
                '24') sudorun pacman -S --noconfirm meson ;;
                '25') sudorun pacman -S --noconfirm cmake extra-cmake-modules ;;
                '26') sudorun pacman -S --noconfirm ninja ;;
                '27') sudorun pacman -S --noconfirm intellij-idea-ultimate-edition intellij-idea-ultimate-edition-jre ;;
                '28') sudorun pacman -S --noconfirm clion clion-cmake clion-gdb clion-jre clion-lldb ;;
                '29') sudorun pacman -S --noconfirm pycharm-professional ;;
                esac
            done
            ;;
        esac
        ;;
    1)
        kdialog --sorry "您选择了取消"
        ;;
    *)
        kdialog --error "遇到了一个错误"
        ;;
    esac

}

main
