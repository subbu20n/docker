#!/bin/bash 

dnf install -y dnf-plugins-core 
dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo 
dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y 

systemctl start docker 
systemctl enable docker 
usermod -aG docker ec2-user 

growpart /dev/nvme0n1 4 
pvresize /dev/nvme0n1p4

lvextend -l +20G  /dev/RootVG/rootVol  
lvextend -l +10G  /dev/RootVG/varVol 

xfs_growfs /
xfs_growfs /var 


 