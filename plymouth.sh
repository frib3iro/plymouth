#!/usr/bin/env bash

## variaveis
senha='123'
azul='\e[34;1m'
verde='\e[32;1m'
vermelho='\e[31;1m'
amarelo='\e[33;1m'
fim='\e[m'
seta='\e[32;1m-->\e[m'

## Tela de boas vindas
clear
echo -e "${seta} ${azul}Bem vindo a instalação plymouth no Arch Linux${fim}"
sleep 2s
clear

## Instalando plymouth e o gdm-plymouth
echo -e "${seta} ${azul}Instalando plymouth e o gdm-plymouth${fim}"
sleep 2s
yay -S plymouth gdm-plymouth
clear

## Editando o arquivo mkinitcpio.conf
echo -e "${seta} ${azul}Editando o arquivo mkinitcpio.conf${fim}"
sleep 2s
sudo vim /etc/mkinitcpio.conf
## HOOKS=(base systemd sd-plymouth [...] sd-encrypt [...])
sudo mkinitcpio -p linux
clear

## Editando o grub
echo -e "${seta} ${azul}Editando o grub${fim}"
sleep 2s
sudo vim /etc/default/grub
## quiet splash loglevel=3 rd.udev.log_priority=3 vt.global_cursor_default=0
sudo grub-mkconfig -o /boot/grub/grub.cfg
clear

## Escolhendo o tema
echo -e "${seta} ${azul}Escolha seu tema${fim}"
sleep 2s
sudo plymouth-set-default-theme -l
sudo plymouth-set-default-theme -R spinfinity
clear

## Desabilitando o gdm e habilitando o gdm-plymouth
echo -e "${seta} ${azul}Desabilitando o gdm e habilitando o gdm-plymouth${fim}"
sleep 2s
sudo systemctl disable gdm.service
sudo systemctl enable gdm-plymouth.service
clear

## Editando plymouthd.conf
echo -e "${seta} ${azul}Editando plymouthd.conf${fim}"
sleep 2s
sudo vim /etc/plymouth/plymouthd.conf
HOOKS=(base udev plymouth [...])
sudo mkinitcpio -p linux
clear

## Reiniciando
reboot

