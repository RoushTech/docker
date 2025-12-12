# syntax = devthefuture/dockerfile-x
FROM ./Alpine.Dockerfile#alpine-23-base AS dotnet-10-base
ARG DOTNET_VERSION=10.0
ARG DOTNET_PACKAGES="dotnet10-sdk dotnet10-runtime mono mono-dev dotnet-bash-completion"
ARG EXTRA_PACKAGES=""
INCLUDE ./Dotnet.fragment.Dockerfile

FROM ./Alpine.Dockerfile#alpine-23-base AS dotnet-9-base
ARG DOTNET_VERSION=9.0
ARG DOTNET_PACKAGES="dotnet9-sdk dotnet9-runtime mono mono-dev dotnet-bash-completion"
ARG EXTRA_PACKAGES=""
INCLUDE ./Dotnet.fragment.Dockerfile
