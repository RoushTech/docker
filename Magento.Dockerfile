# syntax = devthefuture/dockerfile-x
FROM ./PHP.Dockerfile#php-85-node-base AS magento-85-node-base
INCLUDE ./Magento.fragment.Dockerfile

FROM ./PHP.Dockerfile#php-84-node-base AS magento-84-node-base
INCLUDE ./Magento.fragment.Dockerfile

FROM ./PHP.Dockerfile#php-83-node-base AS magento-83-node-base
INCLUDE ./Magento.fragment.Dockerfile

FROM ./PHP.Dockerfile#php-82-node-base AS magento-82-node-base
INCLUDE ./Magento.fragment.Dockerfile

FROM ./PHP.Dockerfile#php-81-node-base AS magento-81-node-base
INCLUDE ./Magento.fragment.Dockerfile