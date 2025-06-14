# Generic labels for all derived images
LABEL org.opencontainers.image.vendor="RoushTech LLC" \
      org.opencontainers.image.authors="Matthew B <matthew.baggett@roushtech.net>" \
      org.opencontainers.image.url="https://github.com/RoushTech/docker" \
      org.opencontainers.image.source="https://github.com/RoushTech/docker" \
      org.opencontainers.image.documentation="https://github.com/RoushTech/docker/blob/main/README.md" \
      net.roushtech.version.alpine=${ALPINE_VERSION}
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
    PATH="/app:/app/bin:$PATH" \
    LOG_PATHS="" \
    SVDIR="/etc/services.d" \
    SVWAIT=5 \
    PAGER="/usr/bin/less" \
    EDITOR="/usr/bin/nano" \
    SYSTEM_USER=app

WORKDIR /app

# Add the app user
RUN <<INITIAL_INSTALL
  set -ue
  apk add --no-cache $BASE_PACKAGES

  # add our app user
  adduser -D -u 1000 $SYSTEM_USER -h /home -s /bin/bash
  chown -R $SYSTEM_USER:$SYSTEM_USER /app

  # We're about to add the root filesystem and I want to clean house of these runit-related directories before I do so.
  rm -Rf /etc/service /etc/services /etc/services.d \
        /etc/periodic /etc/cron.d \
        /etc/conf.d
INITIAL_INSTALL
SHELL ["/bin/bash", "-ce"]

# Add the root filesystem. Wipe out the services dirs that we don't want, then copy in our fs, and fix perms.
COPY ./fs/alpine/. /

RUN <<INSTALL_EXTRA_PACKAGES
  # Install lolcat from the edge/testing repo.
  # This is a workaround for the fact that lolcat is not available in the stable repo.
  # It lets us have nice colourful banners.
  apk add --no-cache lolcat --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing
INSTALL_EXTRA_PACKAGES

# Set bash as the default shell
STOPSIGNAL SIGHUP
CMD ["/usr/local/bin/entrypoint"]

RUN <<FINALISE
  rm /root/.bashrc /root/.profile /home/.bashrc /home/.profile >/dev/null 2>&1 || true
  ln -s /etc/profile /root/.bashrc
  ln -s /etc/profile /root/.profile
  ln -s /etc/profile /home/.bashrc
  ln -s /etc/profile /home/.profile
  sed -i 's|/bin/ash|/bin/bash|' /etc/passwd
  sv-fix-perms
  /usr/local/bin/validate
FINALISE