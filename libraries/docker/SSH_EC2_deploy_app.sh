#!/usr/bin/env bash
ssh -i "${KEY}" -o StrictHostKeyChecking=no ${EC2_INSTANCE_USERNAME}@${INSTANCE_DNS_NAME}
whoami
if [ ! -d "evans-apps" ]; then
  sudo git clone https://github.com/evanfloyd/evans-apps.git
fi
cd evans-apps/docker/${image_name}
sudo docker-compose up
