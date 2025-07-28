# syntax = devthefuture/dockerfile-x
FROM alpine:3.15 AS alpine-15-base
ENV ALPINE_VERSION=3.15
ARG BASE_PACKAGES="\
    bash bash-completion \
    pv bc \
    less util-linux-misc util-linux-bash-completion \
    bind-tools iputils net-tools \
    git openssh-client ca-certificates \
    wget curl \
    tar gzip xz bzip2 \
    cronie flock \
    nano vim \
    figlet ncurses \
    runuser runit \
    dos2unix patch"
INCLUDE ./Alpine.fragment.Dockerfile
FROM alpine-15-base AS builder-15-base
ARG BUILDER_PACKAGES="build-base linux-headers openssl-dev zlib-dev"
RUN apk add --no-cache $BUILDER_PACKAGES

FROM alpine:3.18 AS alpine-18-base
ENV ALPINE_VERSION=3.18
ARG BASE_PACKAGES="\
    bash bash-completion \
    pv bc btop \
    less util-linux-misc util-linux-bash-completion \
    bind-tools iputils-ping net-tools traceroute \
    git openssh-client ca-certificates \
    wget curl \
    tar gzip xz bzip2 \
    cronie flock \
    nano vim \
    figlet ncurses \
    runuser runit \
    dos2unix patch"
INCLUDE ./Alpine.fragment.Dockerfile
FROM alpine-18-base AS builder-18-base
ARG BUILDER_PACKAGES="build-base linux-headers openssl-dev zlib-dev"
RUN apk add --no-cache $BUILDER_PACKAGES

FROM alpine:3.21 AS alpine-21-base
ENV ALPINE_VERSION=3.21
ARG BASE_PACKAGES="\
    bash bash-completion \
    pv bc btop \
    less util-linux-misc util-linux-bash-completion \
    bind-tools iputils-ping net-tools traceroute \
    git openssh-client ca-certificates \
    wget curl \
    tar gzip xz bzip2 \
    cronie flock \
    nano vim \
    figlet ncurses \
    runuser runit \
    dos2unix patch"
INCLUDE ./Alpine.fragment.Dockerfile
FROM alpine-21-base AS builder-21-base
ARG BUILDER_PACKAGES="build-base linux-headers openssl-dev zlib-dev"
RUN apk add --no-cache $BUILDER_PACKAGES

FROM alpine:3.22 AS alpine-22-base
ENV ALPINE_VERSION=3.22
ARG BASE_PACKAGES="\
    bash bash-completion \
    pv bc btop \
    less util-linux-misc util-linux-bash-completion \
    bind-tools iputils-ping net-tools traceroute \
    git openssh-client ca-certificates \
    wget curl \
    tar gzip xz bzip2 \
    cronie flock \
    nano vim \
    figlet ncurses \
    runuser runit \
    dos2unix patch"
INCLUDE ./Alpine.fragment.Dockerfile
FROM alpine-22-base AS builder-22-base
ARG BUILDER_PACKAGES="build-base linux-headers openssl-dev zlib-dev"
RUN apk add --no-cache $BUILDER_PACKAGES
