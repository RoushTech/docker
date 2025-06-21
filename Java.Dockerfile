# syntax = devthefuture/dockerfile-x
FROM ./Alpine.Dockerfile#alpine-22-base AS java-21-base
ARG JAVA_PACKAGES="openjdk21 openjdk21-jre-headless"
ARG JAVA_VERSION=21
ENV JAVA_HOME="/usr/lib/jvm/java-${JAVA_VERSION}-openjdk"
INCLUDE ./Java.fragment.Dockerfile

FROM ./Alpine.Dockerfile#alpine-22-base AS java-17-base
ARG JAVA_PACKAGES="openjdk17 openjdk17-jre-headless"
ARG JAVA_VERSION=17
ENV JAVA_HOME="/usr/lib/jvm/java-${JAVA_VERSION}-openjdk"
INCLUDE ./Java.fragment.Dockerfile

FROM ./Alpine.Dockerfile#alpine-22-base AS java-11-base
ARG JAVA_PACKAGES="openjdk11 openjdk11-jre-headless"
ARG JAVA_VERSION=11
ENV JAVA_HOME="/usr/lib/jvm/java-${JAVA_VERSION}-openjdk"
INCLUDE ./Java.fragment.Dockerfile

FROM ./Alpine.Dockerfile#alpine-22-base AS java-8-base
ARG JAVA_PACKAGES="openjdk8 openjdk8-jre-base"
ARG JAVA_VERSION=1.8
ENV JAVA_HOME="/usr/lib/jvm/java-${JAVA_VERSION}-openjdk"
INCLUDE ./Java.fragment.Dockerfile

FROM ./Alpine.Dockerfile#alpine-18-base AS java-7-base
ARG JAVA_PACKAGES="openjdk7 openjdk7-jre-base"
ARG JAVA_VERSION=1.7
ENV JAVA_HOME="/usr/lib/jvm/java-${JAVA_VERSION}-openjdk"
INCLUDE ./Java.fragment.Dockerfile

FROM java-21-base AS java-war-machine-21-base
INCLUDE ./Java.War.fragment.Dockerfile

FROM java-17-base AS java-war-machine-17-base
INCLUDE ./Java.War.fragment.Dockerfile

FROM java-11-base AS java-war-machine-11-base
INCLUDE ./Java.War.fragment.Dockerfile

FROM java-8-base AS java-war-machine-8-base
INCLUDE ./Java.War.fragment.Dockerfile

FROM java-21-base AS java-tomcat-21-base
ARG TOMCAT_VERSION=9.0.106
INCLUDE ./Java.Tomcat.fragment.Dockerfile

FROM java-17-base AS java-tomcat-17-base
ARG TOMCAT_VERSION=9.0.106
INCLUDE ./Java.Tomcat.fragment.Dockerfile

FROM java-11-base AS java-tomcat-11-base
ARG TOMCAT_VERSION=9.0.106
INCLUDE ./Java.Tomcat.fragment.Dockerfile

FROM java-8-base AS java-tomcat-8-base
ARG TOMCAT_VERSION=9.0.106
INCLUDE ./Java.Tomcat.fragment.Dockerfile

FROM java-7-base AS java-tomcat-7-base
ARG TOMCAT_VERSION=8.5.83
INCLUDE ./Java.Tomcat.fragment.Dockerfile
