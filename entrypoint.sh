#!/bin/sh

# generate ssh keys if they does not exist
ssh-keygen -A -f /etc/ssh/keys

if [ -z ${PASSWORD} ]; then
  echo "No password set!"
  exit 1
fi

echo "vyos:${PASSWORD}" | chpasswd &> /dev/null

/usr/sbin/sshd -eD
