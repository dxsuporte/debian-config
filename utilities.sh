#!/bin/sh
#Interromper o script se algum comando falhar.
set -e
######################################################################
read -r -p "Instalar Utilitários de Terminal? [y|n] " TERMINAL
read -r -p "Instalar Firewall? [y|n] " FIREWALL
read -r -p "Instalar Gerenciador de Pacotes Synaptic? [y|n] " SYNAPTIC
read -r -p "Instalar Gerenciador de Partições GParted? [y|n] " GPARTED
read -r -p "Instalar Analisador de Uso de Disco? [y|n] " BAOBAB
read -r -p "Instalar Utilitário de discos Gnome Disk? [y|n] " GNOMEDISK
read -r -p "Instalar Cliente BitTorrent? [y|n] " TORRENT
read -r -p "Instalar Bluetooth? [y|n] " BLUETOOTH
read -r -p "Instalar Gravador de Som simples - SoundRecorder? [y|n] " SOUNDRECORDER
read -r -p "Instalar WebCam? [y|n] " CHEESE
read -r -p "Instalar Impressoras? [y|n] " IMP
read -r -p "Instalar CD/DVD? [y|n] " DVD
read -r -p "Instalar Otimizador de bateria laptop? [y|n] " TLP
read -r -p "Instalar a loja de Software? [y|n] " SOFTWAREDEB
read -r -p "Instalar Tema Personalizado? [y|n] " THEME
######################################################################
#TERMINAL
if [ "$TERMINAL" = "y" ]; then
    apt install -y neofetch arping
    #Bash User Root
    bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)" --unattended || echo 'OK'
    sed -i 's/OSH_THEME="font"/OSH_THEME="zork"/g' /root/.bashrc
    #Bash User First Home
    runuser -l $(id 1000 -u -n) -c 'bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)" --unattended' || echo 'OK'
    sed -i 's/OSH_THEME="font"/OSH_THEME="mairan"/g' /home/$(id 1000 -u -n)/.bashrc
fi
#FIREWALL
if [ "$FIREWALL" = "y" ]; then
    apt install -y gufw
fi
#SYNAPTIC
if [ "$SYNAPTIC" = "y" ]; then
    apt install -y synaptic
fi
#GPARTED
if [ "$GPARTED" = "y" ]; then
    apt install -y gparted
fi
#BAOBAB
if [ "$BAOBAB" = "y" ]; then
    apt install -y baobab
fi
#GNOMEDISK
if [ "$GNOMEDISK" = "y" ]; then
    apt install -y gnome-disk-utility
fi
#TORRENT
if [ "$TORRENT" = "y" ]; then
    apt install -y qbittorrent
fi
#BLUETOOTH
if [ "$BLUETOOTH" = "y" ]; then
    apt install -y bluez blueman pulseaudio-module-bluetooth
fi
#SOUNDRECORDER
if [ "$SOUNDRECORDER" = "y" ]; then
    apt install -y gnome-sound-recorder
fi
#Cheese webcam
if [ "$CHEESE" = "y" ]; then
    apt install -y cheese
fi
#Impressoras
if [ "$IMP" = "y" ]; then
    apt install -y system-config-printer
    apt install -y printer-driver-all
    apt install -y printer-driver-escpr
    apt install -y printer-driver-gutenprint
    apt install -y cups
    apt install -y hplip hp-ppd
    apt install -y openprinting-ppds
    apt install -y simple-scan
fi
#DVD
if [ "$DVD" = "y" ]; then
    apt install -y libdvd-pkg
fi
#Otimizador de bateria laptop
if [ "$TLP" = "y" ]; then
    apt install -y tlp laptop-mode-tools
fi
#Software DEB
if [ "$SOFTWAREDEB" = "y" ]; then
    apt install -y gnome-software
else
    apt install -y deepin-deb-installer
    apt install -y package-update-indicator
fi
#THEME
if [ "$THEME" = "y" ]; then
    #Desktop Base
    tar -xvf config/desktop-base/dx-theme.tar.xz -C /usr/share/desktop-base/
    unlink /etc/alternatives/desktop-theme
    ln -s /usr/share/desktop-base/dx-theme/ /etc/alternatives/desktop-theme
    ln -sf /usr/share/desktop-base/dx-theme/login/background.svg /usr/share/backgrounds/default.svg
    #Icones
    tar -xvf config/icons/icons.tar.xz -C /usr/share/icons/
    #Backgrounds
    tar -xvf config/backgrounds/backgrounds.tar.xz -C /usr/share/backgrounds
fi
#Limpeza no apt
apt autoremove -y
apt autoclean
apt clean
#Reinicia o sistema
read -r -p "Instalação concluida! Seu pc precisa ser reiniciad! [Enter] " REBOOT
reboot
