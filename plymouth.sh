#!/usr/bin/env bash

# variaveis --------------------------------------------
pass_user='cp1113bug6u'
blue='\e[34;1m'
green='\e[32;1m'
red='\e[31;1m'
yellow='\e[33;1m'
end='\e[m'
seta='\e[32;1m==>\e[m'

# Tela de boas vindas
clear
echo -e "${seta} ${blue}Bem vindo a instalação plymouth no Arch Linux${end}"
sleep 2s
clear

echo -e "${seta} ${blue}Instalando plymouth e o gdm-plymouth${end}"
sleep 2s
yay -S plymouth gdm-plymouth
clear

echo -e "${seta} ${blue}Editando o arquivo mkinitcpio.conf${end}"
sleep 2s
sudo vim /etc/mkinitcpio.conf
sudo mkinitcpio -p linux
clear

echo -e "${seta} ${blue}Editando o grub${end}"
sleep 2s
sudo vim /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
clear

echo -e "${seta} ${blue}Escolha seu tema${end}"
sleep 2s
sudo plymouth-set-default-theme -l
sudo plymouth-set-default-theme -R spinfinity
clear

echo -e "${seta} ${blue}Desabilitando o gdm e habilitando o gdm-plymouth${end}"
sleep 2s
sudo systemctl disable gdm.service
sudo systemctl enable gdm-plymouth.service
clear

echo -e "${seta} ${blue}Editando plymouthd.conf${end}"
sleep 2s
sudo vim /etc/plymouth/plymouthd.conf
sudo mkinitcpio -p linux
clear

reboot

