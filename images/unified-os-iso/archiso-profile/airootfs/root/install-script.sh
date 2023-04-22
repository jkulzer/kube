#sets root password
yes root | passwd root

#creates partitions
#no seperate home directory is used, is not needed
parted /dev/sda mklabel gpt
parted -a optimal /dev/sda --script mkpart P1 fat32 1MB 500MB
parted -a optimal /dev/sda --script mkpart P1 ext4 500MB 100%
parted -a optimal /dev/sda --script set 1 esp on

#formats partions
#sda1 is the boot partition, needs to be fat32
mkfs.fat -F 32 /dev/sda1
mkfs.ext4 /dev/sda2

#mounts partitions to mnt
mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

#bootstraps system
pacstrap -K /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

#chroots and configures locale, users and installs bootloader
arch-chroot /mnt <<"EOT"
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

echo -e "\nen_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo -e "\nLANG=en_US.UTF-8" >> /etc/locale.conf

echo -e "kubernetes-node" >> /etc/hostname

echo -e "[Match]\nName=en*\n\n[Network]\nDHCP=yes" >> /etc/systemd/network/eth0.network

mkinitcpio -P

yes root | passwd root
useradd -m johannes
yes johannes | passwd johannes

usermod -aG wheel johannes

echo -e "\n%wheel      ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

yes | pacman -S openssh curl vim grub efibootmgr sudo python vi

systemctl enable sshd

systemctl enable systemd-networkd
systemctl enable systemd-resolved

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

mkinitcpio -P
EOT

shutdown -h now
