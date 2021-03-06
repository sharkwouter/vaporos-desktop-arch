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

#Create group for logging in without password
sed -i '1s/^/auth sufficient pam_succeed_if.so user ingroup nopasswdlogin\n/' /etc/pam.d/gdm-password
groupadd nopasswdlogin

#Create live user
useradd -m -s /bin/bash -G users,games,uucp,nopasswdlogin liveuser

#Start gdm automatically
systemctl set-default graphical.target
systemctl enable gdm

#Gnome autologin
echo "[daemon]
AutomaticLogin=liveuser
AutomaticLoginEnable=True" > /etc/gdm/custom.conf

#Set hostname
echo "vaporos-live" > /etc/hostname

#Use NetworkManager instead of dhcpd
rm /etc/udev/rules.d/81-dhcpcd.rules
systemctl enable NetworkManager

#Sudo config
echo "liveuser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/iveuser-nopasswd
