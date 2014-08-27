#!/bin/bash
#   dd磁盘克隆

#   硬盘备份与恢复
dd if=/dev/sda1 of=/data/sda1_part.img bs=512   #  backup
dd if=/dev/sda1_part.img of=/dev/sda1 bs=512    #  restore

#    制作光盘镜像
dd if=/dev/cdrom of=/data/cdrom.iso

dd if=/ubunto.iso of=/dev/sdb

#    挂载镜像文件
mkdir /mnt/img
mount -o loop file.img /mnt/img

# 卸载
umount
