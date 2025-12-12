# syntax = devthefuture/dockerfile-x
FROM ./Alpine.Dockerfile#alpine-23-base AS node-24-base
ARG NODE_PACKAGES="nodejs nodejs-dev nodejs-libs nodejs-doc yarn npm npm-bash-completion npm-doc"
ARG EXTRA_PACKAGES=""
ARG NODE_VERSION=24
ARG YARN_VERSION=1.22
ARG NPM_VERSION=11
INCLUDE ./Node.fragment.Dockerfile

FROM ./Alpine.Dockerfile#alpine-21-base AS node-22-base
ARG NODE_PACKAGES="nodejs nodejs-dev nodejs-libs nodejs-doc yarn npm npm-bash-completion npm-doc"
ARG EXTRA_PACKAGES=""
ARG NODE_VERSION=22
ARG YARN_VERSION=1.22
ARG NPM_VERSION=10
INCLUDE ./Node.fragment.Dockerfile

