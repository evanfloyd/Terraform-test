#!/bin/sh -l
set -eu

ssh_cmd="$(cat <<-EOF
    whoami 
    if [ ! -d "evans-apps" ]; then 
    sudo git clone https://github.com/evanfloyd/evans-apps.git 
    fi 
    cd evans-apps/docker/${image_name} 
    sudo docker-compose up 
EOF
)"

sudo touch private_key.pem
KEY='${KEY}'
TEMP_SSH_PRIVATE_KEY_FILE='private_key.pem'
sudo bash -c "printf "%s" "$KEY" >$TEMP_SSH_PRIVATE_KEY_FILE"
sudo chmod 600 $TEMP_SSH_PRIVATE_KEY_FILE
ssh -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE ${EC2_INSTANCE_USERNAME}@${INSTANCE_DNS_NAME} "$ssh_cmd"

