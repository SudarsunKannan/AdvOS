#!/bin/bash
set -x

sudo umount $MOUNT_DIR

#Get the 4.17 kernel
#sudo apt-get update
#sudo apt-get install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc
wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.17.tar.xz
tar xf linux-4.17.tar.xz
cd linux-4.17

#Compile the kernel
cd $KERN_SRC


#Enable the KVM mode in your kernel config file
sudo make x86_64_defconfig
sudo make kvmconfig 

#Compile the kernel with '-j' (denotes parallelism) in sudo mode
sudo make $PARA
sudo make modules
sudo make modules_install
sudo make install

 y="4.17.0"
   if [[ x$ == x ]];
  then
      echo You have to say a version!
      exit 1
   fi

sudo cp ./arch/x86/boot/bzImage /boot/vmlinuz-$y
sudo cp System.map /boot/System.map-$y
sudo cp .config /boot/config-$y
sudo update-initramfs -c -k $y
