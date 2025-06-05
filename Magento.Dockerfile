# syntax = devthefuture/dockerfile-x
FROM ./PHP.Dockerfile#php-84-node-base AS magento-84-node-base
INCLUDE ./Magento.fragment.Dockerfile

FROM ./PHP.Dockerfile#php-81-node-base AS magento-81-node-base
INCLUDE ./Magento.fragment.Dockerfile