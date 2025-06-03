# syntax = devthefuture/dockerfile-x
FROM ./PHP-Node.Dockerfile#php-81-node-base AS magento-81-node-base
INCLUDE ./Magento.fragment.Dockerfile
FROM ./PHP.Dockerfile#php-81-base AS magento-81-base
INCLUDE ./Magento.fragment.Dockerfile