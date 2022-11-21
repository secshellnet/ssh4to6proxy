FROM alpine

ENV PASSWORD=vyos-2022

RUN apk --update --no-cache add openssh openssh-server \
  && sed -i 's|#PermitRootLogin prohibit-password|PermitRootLogin no|' /etc/ssh/sshd_config \
  && sed -i 's|#MaxAuthTries.*|MaxAuthTries 99|' /etc/ssh/sshd_config \
  && sed -i 's|#PasswordAuthentication.*|PasswordAuthentication yes|' /etc/ssh/sshd_config \
  && sed -i 's|#PubkeyAuthentication.*|PubkeyAuthentication no|' /etc/ssh/sshd_config \
  && sed -i 's|AllowTcpForwarding.*|AllowTcpForwarding yes|' /etc/ssh/sshd_config \
  && sed -i 's|#PermitTTY.*|PermitTTY no|' /etc/ssh/sshd_config \
  \
  && mkdir -p /etc/ssh/keys/etc/ssh \
  && sed -i 's|#HostKey /etc/ssh/ssh_host_rsa_key*|HostKey /etc/ssh/keys/etc/ssh/ssh_host_rsa_key|' /etc/ssh/sshd_config \
  && sed -i 's|#HostKey /etc/ssh/ssh_host_ecdsa_key*|HostKey /etc/ssh/keys/etc/ssh/ssh_host_ecdsa_key|' /etc/ssh/sshd_config \
  && sed -i 's|#HostKey /etc/ssh/ssh_host_ed25519_key*|HostKey /etc/ssh/keys/etc/ssh/ssh_host_ed25519_key|' /etc/ssh/sshd_config \
  && sed -i '/ssh_host_ed25519_key/a HostKey \/etc\/ssh\/keys\/etc\/ssh\/ssh_host_dsa_key' /etc/ssh/sshd_config \
  && adduser --shell=/bin/false -D vyos \
  && passwd -u vyos

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
