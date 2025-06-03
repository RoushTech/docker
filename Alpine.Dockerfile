# syntax = devthefuture/dockerfile-x
FROM alpine:3.15 AS alpine-15-base
INCLUDE ./Alpine.fragment.Dockerfile

FROM alpine:3.18 AS alpine-18-base
INCLUDE ./Alpine.fragment.Dockerfile

FROM alpine:3.21 AS alpine-21-base
INCLUDE ./Alpine.fragment.Dockerfile

