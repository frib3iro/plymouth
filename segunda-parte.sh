#!/usr/bin/env bash

# variaveis e password root/user
user='fabio'
pass_user='cp1113bug6u'
pass_root='cp1211rmcc3'
blue='\e[34;1m'
green='\e[32;1m'
red='\e[31;1m'
yellow='\e[33;1m'
end='\e[m'
seta='\e[32;1m==>\e[m'

clear
echo -e "${seta} ${blue}Bem vindo a segunda parte da instalação!${end}"
sleep 2s
clear

# Criando o arquivo de swap
echo -e "${seta} ${blue}Criando o arquivo de swap${end}"
fallocate -l 2GB /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo /swapfile none swap defaults 0 0 >> /etc/fstab 
sleep 2s
clear

# Ajustando o fuso horário
echo -e "${seta} ${blue}Ajustando o fuso horário${end}"
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
sleep 2s
clear

# Executando hwclock
echo -e "${seta} ${blue}Executando o hwclock${end}"
hwclock --systohc --utc
sleep 2s
clear

# Definindo o idioma
echo -e "${seta} ${blue}Definindo o idioma${end}"
sed -i 's/en_US ISO-8859-1/#en_US ISO-8859-1/' /etc/locale.gen
sed -i 's/en_US.UTF-8/#en_US.UTF-8/' /etc/locale.gen
sed -i 's/#pt_BR.UTF-8/pt_BR.UTF-8/' /etc/locale.gen
sed -i 's/#pt_BR ISO-8859-1/pt_BR ISO-8859-1/' /etc/locale.gen
sleep 2s
clear

# Gerando locale.gen
echo -e "${seta} ${blue}Gerando o locale-gen${end}"
locale-gen
sleep 2s
clear

# Criando o arquivo locale.conf
echo -e "${seta} ${blue}Criando o arquivo locale.conf${end}"
echo LANG=pt_BR.UTF-8 > /etc/locale.conf
sleep 2s
clear

# Exportando a variável LANG
echo -e "${seta} ${blue}Exportando a variável LANG${end}"
export LANG=pt_BR.UTF-8
sleep 2s
clear

# Atualizando o relógio do sistema
echo -e "${seta} ${blue}Atualizando o relógio do sistema${end}"
timedatectl set-ntp true
sleep 2s
clear

# Criando o arquivo vconsole.conf
echo -e "${seta} ${blue}Criando o arquivo vconsole.conf${end}"
echo KEYMAP=br-abnt2 > /etc/vconsole.conf
sleep 2s
clear

# Criando o hostname
echo -e "${seta} ${blue}Criando o hostname${end}"
echo archlinux > /etc/hostname
sleep 2s
clear

# Configurando o hosts
echo -e "${seta} ${blue}Configurando o arquivo hosts${end}"
cat >> '/etc/hosts' << EOF
127.0.0.1   localhost.localdomain   localhost
::1         localhost.localdomain   localhost
127.0.1.1   archlinux.localdomain   archlinux
EOF
sleep 2s
clear

# Criando senha de root
echo -e "${seta} ${blue}Criando a senha do root${end}"
echo "root:$pass_root" | chpasswd
sleep 2s
clear

# Baixando o Gerenciador de boot 
echo -e "${seta} ${blue}Baixando o Gerenciador de boot e mais alguns pacotes${end}"
pacman -S dosfstools efibootmgr git grub linux-headers networkmanager network-manager-applet vim wget xorg --noconfirm
sleep 2s
clear

# Instalando o grub
echo -e "${seta} ${blue}Instalando o grub${end}"
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
sleep 2s
clear

# Configurando o grub
echo -e "${seta} ${blue}Configurando o grub${end}"
grub-mkconfig -o /boot/grub/grub.cfg
sleep 2s
clear

# Iniciando o NetworkManager
echo -e "${seta} ${blue}Iniciando o NetworkManager${end}"
systemctl enable NetworkManager
systemctl start NetworkManager
sleep 2s
clear

# Adicionando um usuario
echo -e "${seta} ${blue}Adicionando o usuário${end}"
useradd -m -g users -G wheel fabio
sleep 2s
clear

# Criando senha de usuario
echo -e "${seta} ${blue}Adicionando a senha do usuário${end}"
echo "$user:$pass_user" | chpasswd 
sleep 2s
clear

# Adicionando user no grupo sudoers
echo -e "${seta} ${blue}Adicionando o usuário no grupo sudoers${end}"
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
sleep 2s
clear

# Reiniciando
echo -e "${seta} ${blue}Reinicie o sistema para continuar com a terceira parte!${end}"
sleep 2s
exit 

