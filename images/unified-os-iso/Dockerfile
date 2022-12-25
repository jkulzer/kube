FROM archlinux:latest

COPY scripts /scripts
COPY archiso-profile /profile

RUN yes | pacman -Sy archlinux-keyring
RUN yes | pacman -Syu archiso parted arch-install-scripts
RUN chmod +x /scripts/build.sh

CMD /scripts/build.sh
