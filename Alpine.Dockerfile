# syntax = devthefuture/dockerfile-x
FROM alpine:3.15 AS alpine-15-base
ENV ALPINE_VERSION=3.15
INCLUDE ./Alpine.fragment.Dockerfile
FROM alpine-15-base AS builder-15-base
ARG BUILDER_PACKAGES="build-base linux-headers openssl-dev zlib-dev"
RUN apk add --no-cache $BUILDER_PACKAGES

FROM alpine:3.18 AS alpine-18-base
ENV ALPINE_VERSION=3.18
INCLUDE ./Alpine.fragment.Dockerfile
FROM alpine-18-base AS builder-18-base
ARG BUILDER_PACKAGES="build-base linux-headers openssl-dev zlib-dev"
RUN apk add --no-cache $BUILDER_PACKAGES

FROM alpine:3.21 AS alpine-21-base
ENV ALPINE_VERSION=3.21
INCLUDE ./Alpine.fragment.Dockerfile
FROM alpine-21-base AS builder-21-base
ARG BUILDER_PACKAGES="build-base linux-headers openssl-dev zlib-dev"
RUN apk add --no-cache $BUILDER_PACKAGES

FROM alpine:3.22 AS alpine-22-base
ENV ALPINE_VERSION=3.22
INCLUDE ./Alpine.fragment.Dockerfile
FROM alpine-22-base AS builder-22-base
ARG BUILDER_PACKAGES="build-base linux-headers openssl-dev zlib-dev"
RUN apk add --no-cache $BUILDER_PACKAGES
