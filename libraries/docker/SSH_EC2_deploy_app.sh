#!/bin/sh -l
set -eu

sudo touch /private_key.pem
TEMP_SSH_PRIVATE_KEY_FILE='../private_key.pem'
printf "%s" "${KEY}" >$TEMP_SSH_PRIVATE_KEY_FILE
chmod 600 $TEMP_SSH_PRIVATE_KEY_FILE
ssh -i $TEMP_SSH_PRIVATE_KEY_FILE -o StrictHostKeyChecking=no ${EC2_INSTANCE_USERNAME}@${INSTANCE_DNS_NAME} \
whoami \
if [ ! -d "evans-apps" ]; then \
  sudo git clone https://github.com/evanfloyd/evans-apps.git \
fi \
cd evans-apps/docker/${image_name} \
sudo docker-compose up \
