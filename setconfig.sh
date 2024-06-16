#!/bin/bash

echo -e "\e[1mBefore continuing, ensure you have the following packages installed:\e[0m"
echo -e "(the theme may break if packages are missing, do so at your own risk!!)"
echo ""

echo -e "\e[33mfeh (wallpaper):\e[0m \e[4mhttps://archlinux.org/packages/extra/x86_64/feh/\e[0m"
echo -e "\e[33mdunst (notifications):\e[0m \e[4mhttps://github.com/dunst-project/dunst\e[0m"
echo -e "\e[33mkitty (terminal):\e[0m \e[4mhttps://sw.kovidgoyal.net/kitty/binary/\e[0m"
echo -e "\e[33mpicom (compositor):\e[0m \e[4mhttps://github.com/yshui/picom\e[0m"
echo -e "\e[33mpolybar (status bar):\e[0m \e[4mhttps://github.com/polybar/polybar\e[0m"
echo -e "\e[33mrofi (app search):\e[0m \e[4mhttps://github.com/davatorium/rofi\e[0m"
echo -e "\e[33mrofi emoji (emoji search):\e[0m \e[4mhttps://github.com/Mange/rofi-emoji (rofi-emoji on AUR)\e[0m"
echo -e "\e[2m[\e[0m\e[33moptional\e[0m\e[2m] starship (terminal customization):\e[0m \e[4mhttps://starship.rs/guide\e[0m"
echo -e "\e[2m[\e[0m\e[33moptional\e[0m\e[2m] hyfetch (silly gay neofetch):\e[0m \e[4mhttps://github.com/hykilpikonna/hyfetch\e[0m"
echo ""

echo -e "\e[1mThis will overwrite configs in ${HOME}/.config!!\e[0m"
read -p "Press Enter to continue, Ctrl+C to quit..." </dev/tty

sudo pacman -S --needed wget unzip libnotify

if ! fc-list | grep -q "JetBrainsMono Nerd Font"; then
    wget -O "/tmp/font.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip"
    mkdir -p ~/.fonts
    unzip /tmp/font.zip -d ~/.fonts/nerdfonts
    fc-cache -fv
fi

dir="."
dst="${HOME}/.config"

cp ${dir}/dunst -Rf ${dst}/
cp ${dir}/i3 -Rf ${dst}/
cp ${dir}/kitty -Rf ${dst}/
cp ${dir}/picom -Rf ${dst}/
cp ${dir}/polybar -Rf ${dst}/
cp ${dir}/rofi -Rf ${dst}/

cp ${dir}/starship.toml ${dst}/starship.toml
cp ${dir}/hyfetch.json ${dst}/hyfetch.json

mkdir -p ${dst}/scripts
cp ${dir}/scripts/media.sh ${dst}/scripts/media.sh
cp ${dir}/scripts/volume.sh ${dst}/scripts/volume.sh

echo -e "\e[1mInstallation complete, please reload your WM (or just reboot your PC)\e[0m"
