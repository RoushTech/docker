# syntax = devthefuture/dockerfile-x
FROM ./Alpine.Dockerfile#alpine-22-base AS java-21-base
RUN apk update && \
    apk add --no-cache \
        openjdk21

FROM ./Alpine.Dockerfile#alpine-22-base AS java-17-base
RUN apk update && \
    apk add --no-cache \
        openjdk17

FROM ./Alpine.Dockerfile#alpine-22-base AS java-11-base
RUN apk update && \
    apk add --no-cache \
        openjdk11

FROM ./Alpine.Dockerfile#alpine-22-base AS java-8-base
RUN apk update && \
    apk add --no-cache \
        openjdk8

FROM java-21-base AS java-war-machine-21-base
COPY ./fs/java-war-machine /
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk \
    PATH=$PATH:/usr/lib/jvm/java-21-openjdk/bin \
    JAVA_OPTS=""
RUN <<CONFIGURE_WAR_MACHINE
    # Fix ownership & execution of service scripts
    sv-fix-perms
CONFIGURE_WAR_MACHINE

FROM java-17-base AS java-war-machine-17-base
COPY ./fs/java-war-machine /
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk \
    PATH=$PATH:/usr/lib/jvm/java-17-openjdk/bin \
    JAVA_OPTS=""
RUN <<CONFIGURE_WAR_MACHINE
    # Fix ownership & execution of service scripts
    sv-fix-perms
CONFIGURE_WAR_MACHINE

FROM java-11-base AS java-war-machine-11-base
COPY ./fs/java-war-machine /
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk \
    PATH=$PATH:/usr/lib/jvm/java-11-openjdk/bin \
    JAVA_OPTS=""
RUN <<CONFIGURE_WAR_MACHINE
    # Fix ownership & execution of service scripts
    sv-fix-perms
CONFIGURE_WAR_MACHINE