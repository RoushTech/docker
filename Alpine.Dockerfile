# syntax = devthefuture/dockerfile-x
FROM alpine:3.15 AS alpine-15-base
INCLUDE ./Alpine.fragment.Dockerfile

FROM alpine:3.18 AS alpine-18-base
INCLUDE ./Alpine.fragment.Dockerfile

FROM alpine:3.21 AS alpine-21-base
INCLUDE ./Alpine.fragment.Dockerfile

FROM alpine:3.22 AS alpine-22-base
INCLUDE ./Alpine.fragment.Dockerfile

FROM alpine-21-base AS builder-21-base
ARG BUILDER_PACKAGES="build-base linux-headers openssl-dev zlib-dev"
RUN apk add --no-cache $BUILDER_PACKAGES

FROM alpine-22-base AS builder-22-base
ARG BUILDER_PACKAGES="build-base linux-headers openssl-dev zlib-dev"
RUN apk add --no-cache $BUILDER_PACKAGES
