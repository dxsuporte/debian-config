#!/bin/sh
#Interromper o script se algum comando falhar.
set -e
#APT or NALA
PRG="$1"
#Versão do Debian
if [ $(lsb_release -rs 2 | awk "{print}") = "n/a" ]; then
    RELEASE="testing"
else
    RELEASE=$(lsb_release -rs 2 | awk "{print}")
fi
#----------Start----------#
wget -c https://mega.nz/linux/repo/Debian_"$RELEASE"/amd64/megasync-Debian_"$RELEASE"_amd64.deb -O /tmp/megasync-Debian_amd64.deb
$PRG install -y /tmp/megasync-Debian_amd64.deb
#XFCE
if [ $XDG_CURRENT_DESKTOP = XFCE ]; then
    wget -c https://mega.nz/linux/repo/Debian_"$RELEASE"/amd64/thunar-megasync-Debian_"$RELEASE"_amd64.deb -O /tmp/thunar-megasync-Debian_amd64.deb
    $PRG install -y /tmp/thunar-megasync-Debian_amd64.deb
fi