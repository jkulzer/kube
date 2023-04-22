FROM archlinux:latest

COPY scripts/docker-entrypoint.sh /docker-entrypoint.sh
WORKDIR  /playbook

RUN yes | pacman -Syu ansible
RUN chmod +x /docker-entrypoint.sh

COPY scripts/ansible.cfg /etc/ansible/ansible.cfg

ENTRYPOINT /docker-entrypoint.sh
CMD /docker-entrypoint.sh
