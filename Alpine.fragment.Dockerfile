ARG BASE_PACKAGES="\
    bash bash-completion less \
    git openssh-client ca-certificates \
    wget curl \
    cronie \
    nano vim \
    figlet ncurses \
    runuser runit \
    dos2unix patch"

ENV TERM=xterm-256color \
    PS1="\[\e[31m\][\[\e[m\]\[\e[38;5;32m\]\u\[\e[m\]@\[\e[38;5;153m\]\H\[\e[m\] \[\e[38;5;74m\]\W\[\e[m\]\[\e[31m\]]\[\e[m\]\\$ " \
    PATH="/app:/app/bin:$PATH" \
    LOG_PATHS="" \
    PAGER="less"

LABEL org.opencontainers.image.source https://github.com/RoushTech/docker \
      org.opencontainers.image.description "RoushTech Alpine base image with runit, bash, and common utilities" \
      org.opencontainers.image.vendor "RoushTech"
MAINTAINER "RoushTech <support@roushtech.net>"

# Add the app user
RUN <<INITIAL_INSTALL
  set -ue
  apk add --no-cache $BASE_PACKAGES
  adduser -D -u 1000 app -h /home/app -s /bin/bash

  # We're about to add the root filesystem and I want to clean house of these runit-related directories before I do so.
  rm -Rf /etc/service /etc/services /etc/services.d
INITIAL_INSTALL
SHELL ["/bin/bash", "-ce"]

# Add the root filesystem. Wipe out the services dirs that we don't want, then copy in our fs, and fix perms.
COPY ./fs/alpine/. /
RUN <<FIX_PERMS
  sv-fix-perms
  chmod +x /usr/local/bin/*
FIX_PERMS

RUN <<INSTALL_EXTRA_PACKAGES
  # Install lolcat from the edge/testing repo.
  # This is a workaround for the fact that lolcat is not available in the stable repo.
  # It lets us have nice colourful banners.
  apk add --no-cache lolcat --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing
INSTALL_EXTRA_PACKAGES

# Set bash as the default shell
SHELL ["/bin/bash", "-ce"]
STOPSIGNAL SIGHUP
CMD ["/usr/local/bin/entrypoint"]

RUN <<FIXUP_BASH
rm ~/.bashrc ~/.profile || true
ln -s /etc/profile ~/.bashrc
ln -s /etc/profile ~/.profile
sed -i 's|/bin/ash|/bin/bash|' /etc/passwd
FIXUP_BASH

WORKDIR /app
