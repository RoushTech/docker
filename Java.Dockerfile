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
