#!/usr/bin/env bash
TEMP_SSH_PRIVATE_KEY_FILE='../private_key.pem'
echo ${KEY} >> ../private_key.pem
ssh -i $TEMP_SSH_PRIVATE_KEY_FILE -o StrictHostKeyChecking=no ${EC2_INSTANCE_USERNAME}@${INSTANCE_DNS_NAME}
whoami
if [ ! -d "evans-apps" ]; then
  sudo git clone https://github.com/evanfloyd/evans-apps.git
fi
cd evans-apps/docker/${image_name}
sudo docker-compose up
