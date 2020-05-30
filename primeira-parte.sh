#!/usr/bin/env bash

# variaveis
pass_user='cp1113bug6u'
mirror='/etc/pacman.d/mirrorlist'
blue='\e[34;1m'
green='\e[32;1m'
red='\e[31;1m'
yellow='\e[33;1m'
end='\e[m'
seta='\e[32;1m==>\e[m'

# Funções ---------------------------------------------
# Para a maquina maquina_virtual
maquina_virtual(){
    (echo g; echo n; echo ""; echo ""; echo +512M; echo t; echo 1; echo n; echo ""; echo ""; echo ""; echo w) | fdisk ${disco}
}

# Para a maquina real 
maquina_real(){
    (echo d; echo ""; echo d; echo ""; echo g; echo n; echo ""; echo ""; echo +512M; echo t; echo 1; echo n; echo ""; echo ""; echo ""; echo w) | fdisk ${disco}
}

# Tela de boas vindas
clear
echo -e "${seta} ${blue}Bem vindo a instalação do Arch Linux${end}"
sleep 2s
clear

# Definindo layout do teclado
echo -e "${seta} ${blue}Definindo o layout do teclado${end}"
loadkeys br-abnt2
sleep 2s
clear

# Atualizando o relógio do sistema
echo -e "${seta} ${blue}Atualizando o relógio do sistema${end}"
timedatectl set-ntp true
sleep 2s
clear

# Listando os discos
echo -e "${seta} ${blue}Listando os discos${end}"
lsblk -l | grep disk
sleep 2s
echo ""

# Informando o nome do seu disco
echo -en "${seta} ${blue}Informe o nome do seu disco: ${end}"
read disco
disco=/dev/${disco}
clear

echo -en "${seta} ${blue}Digite${end} ${red}[ 1 ]${end} ${blue}para maquina maquina_virtual e${end} ${red}[ 2 ]${end} ${blue}para maquina maquina_real:${end} "
read resposta
clear

if [ "$resposta" -eq 1 ]; then
    echo -e "${seta} ${blue}Iniciando particionamento na maquina_virtual${end}"
    maquina_virtual
    sleep 2s
    clear
elif [ "$resposta" -eq 2 ]; then
    echo -e "${seta} ${blue}Iniciando particionamento na maquina_real${end}"
    maquina_real
    sleep 2s
    clear
fi

# Formatando partições
echo -e "${seta} ${blue}Formatando as partições${end}"
mkfs.fat -F32 ${disco}1
mkfs.ext4 ${disco}2
sleep 2s
clear

# Montando partições
echo -e "${seta} ${blue}Montando as partições${end}"
mount ${disco}2 /mnt
mkdir -p /mnt/boot
mount ${disco}1 /mnt/boot
sleep 2s
clear

# Listando partições
echo -e "${seta} ${blue}Conferindo as partições${end}"
lsblk ${disco}
sleep 5s
clear

# Configurando mirrorlist
echo -e "${seta} ${blue}Fazendo backup do mirrorlist${end}"
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
clear
echo -e "${seta} ${blue}Comentando todos os servidores${end}"
sleep 2s
sed 's/^Ser/#Ser/' ${mirror} > ${mirror}.bkp
clear
echo -e "${seta} ${blue}Descomentando os servidores Brasileiros${end}"
sleep 2s
sed '/Brazil/{n;s/^#//}' ${mirror}.bkp > ${mirror}
sleep 2s
clear

# Atualizando os repositórios
echo -e "${seta} ${blue}Atualizando os repositórios${end}"
pacman -Syyy --noconfirm
sleep 2s
clear

# Instalando os pacotes base
echo -e "${seta} ${blue}Instalando os pacotes base${end}"
pacstrap /mnt base base-devel linux linux-firmware
sleep 2s
clear

# Gerando o fstab
echo -e "${seta} ${blue}Gerando o fstab${end}"
genfstab -U /mnt >> /mnt/etc/fstab
sleep 2s
clear

# Copiando o script archinstall-02.sh para /mnt
echo -e "${seta} ${blue}Copiando o script archinstall-02.sh para /mnt${end}"
cp segunda-parte.sh /mnt
sleep 2s
clear

# Iniciando arch-chroot
echo -e "${seta} ${blue}Iniciando arch-chroot${end}"
sleep 2s
arch-chroot /mnt ./segunda-parte.sh

