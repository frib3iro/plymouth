#!/usr/bin/env bash

# variaveis
pass_user='cp1113bug6u'
blue='\e[34;1m'
green='\e[32;1m'
red='\e[31;1m'
yellow='\e[33;1m'
end='\e[m'
seta='\e[32;1m==>\e[m'

# Funções ------------------------------------------------------------
driver_virtmanager(){
    echo $pass_user | sudo -S pacman -S xf86-video-qxl --noconfirm
}

driver_nvidia(){
    echo $pass_user | sudo -S pacman -S nvidia nvidia-utils nvidia-settings intel-ucode --noconfirm
}
# GDM ----------------------------------------------------------------
instalar_gdm(){
    echo $pass_user | sudo -S pacman -S gdm --noconfirm
}
iniciar_gdm(){
    echo $pass_user | sudo -S systemctl enable gdm
    echo $pass_user | sudo -S systemctl start gdm
}

# Tela de boas vindas
clear
echo -e "${seta} ${blue}Bem vindo a terceira parte da instalação!${end}"
sleep 2s
clear

# Atualizando os espelhos
echo -e "${seta} ${blue}Atualizando...${end}"
echo $pass_user | sudo -S pacman -Syu --noconfirm
sleep 2s
clear

echo -en "${seta} ${blue}Digite${end} ${red}[ 1 ]${end} ${blue}para instalar o driver virt-manager ou${end} ${red}[ 2 ]${end} ${blue}para instalar o driver nvidia:${end} "
read resposta
clear

if [ "$resposta" -eq 1 ]; then
    echo -e "${seta} ${blue}Iniciando instalação do driver para virt-manager${end}"
    driver_virtmanager
    sleep 2s
    clear
elif [ "$resposta" -eq 2 ]; then
    echo -e "${seta} ${blue}Iniciando instalação do driver para nvidia${end}"
    driver_nvidia
    sleep 2s
    clear
else
    echo -e "${seta} ${red}Resposta inválida!${end}"
    exit 1
fi

echo -e "${seta} ${blue}Instalando o cinnamon desktop${end}"
echo $pass_user | sudo -S pacman -S cinnamon cinnamon-translations cinnamon-screensaver cinnamon-session cinnamon-settings-daemon --noconfirm
sleep 2s
clear

echo -e "${seta} ${blue}Instalando o nemo${end}"
echo $pass_user | sudo -S pacman -S nemo nemo-preview nemo-share nemo-fileroller --noconfirm
sleep 2s
clear

echo -e "${seta} ${blue}Instalando pacotes necessários${end}"
echo $pass_user | sudo -S pacman -S accountsservice alsa-utils archlinux-keyring archlinux-wallpaper baobab bash-completion blueberry bluez bluez-cups bluez-tools bolt cmatrix colord coreutils cpio cronie dialog ffmpegthumbnailer gimp gnome-bluetooth gedit gnome-calculator gnome-calendar gnome-disk-utility gnome-keyring gnome-menus gnome-online-accounts gnome-power-manager gnome-screenshot gnome-settings-daemon gnome-system-monitor gnupg gst-libav gufw htop libreoffice libreoffice-fresh-pt-br lollypop man-db metacity mtools neofetch pass rsync system-config-printer tcpdump totem ttf-hack gnu-free-fonts ttf-dejavu ttf-nerd-fonts-symbols ufw unrar xdg-user-dirs xdg-utils xf86-input-synaptics xcursor-vanilla-dmz-aa xclip xreader youtube-dl --noconfirm
sleep 2s
clear

echo -e "${seta} ${blue}Instalando o yay${end}"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
sleep 2s
clear

# Playmouth ------------------------------------------------------
echo -e "${seta} ${blue}Instalando o plymouth-git${end}"
yay -S plymouth-git --noconfirm
sleep 2s
clear

echo -e "${seta} ${blue}Instalando o gdm-plymouth${end}"
yay -S gdm-plymouth --noconfirm
sleep 2s
clear

echo -e "${seta} ${blue}Adicione${end} ${red}plymouth${end} ${blue}ao vetor HOOKS${end}"
echo -e "${seta} ${blue}Tem que ser adicionado após base e udev para funcionar:${end}"
echo -e "${seta} ${blue}É necessário adicionar o driver gráfico${end} ${red}(xf86-video-qxl)${end} ${blue}ao MODULES=()${end}"
echo -e "${seta} ${yellow}Aperte enter para editar o arquivo${end}"
read
echo $pass_user | sudo -S vim /etc/mkinitcpio.conf
clear

echo -e "${seta} ${blue}Neste momento precisa de adicionar os parâmetros do kernel${end}"
echo -e "${seta} ${red}quiet splash loglevel=3 rd.udev.log_priority=3 vt.global_cursor_default=0${end}"
echo -e "${seta} ${yellow}Aperte enter para editar o arquivo${end}"
read
echo $pass_user | sudo -S vim /etc/default/grub
clear

echo -e "${seta} ${blue}Recompile a sua imagem initrd${end}"
echo -e "${seta} ${yellow}Aperte enter para continuar${end}"
read
mkinitcpio -p linux
clear

echo -e "${seta} ${blue}Recompile a sua imagem initrd${end}"
echo -e "${seta} ${yellow}Aperte enter para continuar${end}"
read
grub-mkconfig -o /boot/grub/grub.cfg
clear

# mint-backgrounds -----------------------------------------------
echo -e "${seta} ${blue}Instalando o gnome-terminal-transparency${end}"
yay -S gnome-terminal-transparency --noconfirm
sleep 2s
clear

echo -e "${seta} ${blue}Instalando os${end} ${yellow}firmwares warnigs${end} ${blue}do archlinux${end}"
yay -S aic94xx-firmware wd719x-firmware --noconfirm
sleep 2s
clear

echo -e "${seta} ${blue}Instalando cinnamon-sound-effects${end}"
yay -S cinnamon-sound-effects --noconfirm
sleep 2s
clear

echo -e "${seta} ${blue}Instalando o mint-themes${end}"
yay -S mint-themes mint-y-icons mintlocale --noconfirm
sleep 2s
clear

echo -e "${seta} ${blue}Instalando o google-chrome${end}"
yay -S google-chrome --noconfirm
sleep 2s
clear

echo -e "${seta} ${blue}Iniciando o xdg-update${end}"
xdg-user-dirs-update
sleep 2s

# echo -e "${seta} ${blue}Instalando o gdm${end}"
# instalar_gdm 
# sleep 2s
# clear
# 
# echo -e "${seta} ${blue}Iniciando o serviço do gdm${end}"
# iniciar_gdm
# sleep 2s
# clear
