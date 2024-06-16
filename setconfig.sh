#!/bin/bash

echo "before continuing, ensure you have the following packages installed:"
echo "(the theme may break if packages are missing, do so at your own risk!!)
echo ""
echo "feh (wallpaper): https://archlinux.org/packages/extra/x86_64/feh/"
echo "dunst (notifications): https://github.com/dunst-project/dunst"
echo "kitty (terminal) https://sw.kovidgoyal.net/kitty/binary/"
echo "picom (compositor): https://github.com/yshui/picom"
echo "polybar (status bar): https://github.com/polybar/polybar"
echo "rofi (app search): https://github.com/davatorium/rofi"
echo "rofi emoji (emoji search): https://github.com/Mange/rofi-emoji (rofi-emoji on AUR)"
echo "[optional] starship (terminal customization): https://starship.rs/guide"
echo "[optional] hyfetch (silly gay neofetch): https://github.com/hykilpikonna/hyfetch"
read -p "press enter to continue..." </dev/tty

sudo pacman -S --needed wget unzip

if ! fc-list | grep -q "JetBrainsMono Nerd Font"; then
    wget -O "/tmp/font.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip"
    unzip /tmp/font.zip -d ~/.fonts/nerdfonts
    fc-cache -fv
fi

dir="${HOME}/.config/dotfiles"
dst="${HOME}/.config"


cp ${dir}/dunst -r ${dst}/dunst
cp ${dir}/i3 -r ${dst}/i3
cp ${dir}/kitty -r ${dst}/kitty
cp ${dir}/picom -r ${dst}/picom
cp ${dir}/polybar -r ${dst}/polybar
cp ${dir}/rofi -r ${dst}/rofi

cp ${dir}/starship.toml ${dst}/starship.toml
cp ${dir}/hyfetch.json ${dst}/hyfetch.json

cp ${dir}/scripts/media.sh ${dst}/scripts/media.sh
cp ${dir}/scripts/volume.sh ${dst}/scripts/volume.sh

echo "installation complete, please reload your wm (or just reboot your pc)"