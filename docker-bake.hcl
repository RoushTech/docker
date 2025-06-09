variable "PLATFORMS" {
  description = "List of platforms to build for"
  type        = list(string)
  default     = [
    "linux/amd64",
    "linux/arm64",
  ]
}
variable "TIMESTAMP"{
  description = "Timestamp for image creation"
  type        = string
  default     = "build-${formatdate("YYYY-MM-DD", timestamp())}"
}
group "default" {
  targets = [
    "alpine-21",
    "alpine-18",
    "alpine-15",
    "builder-21",
    "php-74",
    "php-81",
    "php-84",
    "php-81-node",
    "php-84-node",
    "magento-81",
    "magento-84",
  ]
  labels = {
    "org.opencontainers.image.url"           = "https://github.com/RoushTech/docker"
    "org.opencontainers.image.source"        = "https://github.com/RoushTech/docker"
    "org.opencontainers.image.documentation" = "https://github.com/RoushTech/docker/blob/main/README.md"
    "org.opencontainers.image.vendor"        = "RoushTech LLC"
    "org.opencontainers.image.authors"       = "Matthew B <matthew.baggett@roushtech.net>"
    "org.opencontainers.image.created"       = timestamp()
  }
}
group "alpine" {
  targets = [
    "alpine-21",
    "alpine-18",
    "alpine-15",
  ]
}
group "php" {
  targets = [
    "php-84",
    "php-81",
    "php-74",
  ]
}
group "php-node" {
  targets = [
    "php-84-node",
    "php-81-node",
  ]
}
group "magento" {
  targets = [
    "magento-84",
    "magento-81",
  ]
}
target "alpine-21" {
  dockerfile = "Alpine.Dockerfile"
  target     = "alpine-21-base"
  tags       = [
    "ghcr.io/roushtech/docker/base:3.21",
    "ghcr.io/roushtech/docker/base:3.21-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
    labels = {
        "org.opencontainers.image.description" = "Roushtech-flavoured Alpine Linux base image"
    }
}
target "alpine-18" {
  dockerfile = "Alpine.Dockerfile"
  target     = "alpine-18-base"
  tags       = [
    "ghcr.io/roushtech/docker/base:latest",
    "ghcr.io/roushtech/docker/base:3.18",
    "ghcr.io/roushtech/docker/base:3.18-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
    labels = {
        "org.opencontainers.image.description" = "Roushtech-flavoured Alpine Linux base image"
    }
}
target "alpine-15" {
  dockerfile = "Alpine.Dockerfile"
  target     = "alpine-15-base"
  tags       = [
    "ghcr.io/roushtech/docker/base:3.15",
    "ghcr.io/roushtech/docker/base:3.15-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
    labels = {
        "org.opencontainers.image.description" = "Roushtech-flavoured Alpine Linux base image"
    }
}
target "builder-21" {
  dockerfile = "Alpine.Dockerfile"
  target     = "builder-21-base"
  tags       = [
    "ghcr.io/roushtech/docker/builder:3.21",
    "ghcr.io/roushtech/docker/builder:3.21-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "Roushtech-flavoured Alpine Linux base image that has build tools installed"
  }
}
target "php-74" {
  dockerfile = "PHP.Dockerfile"
  target     = "php-74-base"
  tags       = [
    "ghcr.io/roushtech/docker/php:7.4",
    "ghcr.io/roushtech/docker/php:7.4-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
    labels = {
        "org.opencontainers.image.description" = "PHP 7.4 base image"
    }
}
target "php-81" {
  dockerfile = "PHP.Dockerfile"
  target     = "php-81-base"
  tags       = [
    "ghcr.io/roushtech/docker/php:8.1",
    "ghcr.io/roushtech/docker/php:8.1-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
    labels = {
        "org.opencontainers.image.description" = "PHP 8.1 base image"
    }
}
target "php-84" {
  dockerfile = "PHP.Dockerfile"
  target     = "php-84-base"
  tags       = [
    "ghcr.io/roushtech/docker/php:latest",
    "ghcr.io/roushtech/docker/php:8.4",
    "ghcr.io/roushtech/docker/php:8.4-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
    labels = {
        "org.opencontainers.image.description" = "PHP 8.4 base image"
    }
}
target "php-81-node" {
  dockerfile = "PHP.Dockerfile"
  target     = "php-81-node-base"
  tags       = [
    "ghcr.io/roushtech/docker/php-node:latest",
    "ghcr.io/roushtech/docker/php-node:8.1",
    "ghcr.io/roushtech/docker/php-node:8.1-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "PHP 8.1 with Node.js base image"
  }
}
target "php-84-node" {
  dockerfile = "PHP.Dockerfile"
  target     = "php-84-node-base"
  tags       = [
    "ghcr.io/roushtech/docker/php-node:8.4",
    "ghcr.io/roushtech/docker/php-node:8.4-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "PHP 8.4 with Node.js base image"
  }
}
target "magento-81" {
  dockerfile = "Magento.Dockerfile"
  target     = "magento-81-node-base"
  tags       = [
    "ghcr.io/roushtech/docker/magento:latest",
    "ghcr.io/roushtech/docker/magento:8.1",
    "ghcr.io/roushtech/docker/magento:8.1-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "Magento on PHP 8.1 with Node.js base image"
  }
}
target "magento-84" {
  dockerfile = "Magento.Dockerfile"
  target     = "magento-84-node-base"
  tags       = [
    "ghcr.io/roushtech/docker/magento:8.4",
    "ghcr.io/roushtech/docker/magento:8.4-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "Magento on PHP 8.4 with Node.js base image"
  }
}