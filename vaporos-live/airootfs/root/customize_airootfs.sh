#!/bin/bash

set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

usermod -s /usr/bin/zsh root
cp -aT /etc/skel/ /root/
chmod 700 /root

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

systemctl enable pacman-init.service choose-mirror.service

#VaporOS specific stuff

#Create live user
useradd -m -s /bin/bash liveuser

#Start gdm automatically
ln -s /usr/lib/systemd/system/gdm.service ~/archlive/airootfs/etc/systemd/system/display-manager.service
systemctl set-default graphical.target

#Gnome autologin
echo "[daemon]
AutomaticLogin=liveuser
AutomaticLoginEnable=True" > /etc/gdm/custom.conf

#Other services
systemctl enable NetworkManager
