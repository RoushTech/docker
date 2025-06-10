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
    "alpine-22",
    "alpine-21",
    "alpine-18",
    "alpine-15",
    "builder-22",
    "builder-21",
    "php-74",
    "php-81",
    "php-84",
    "php-81-node",
    "php-84-node",
    "magento-81",
    "magento-84",
    "java-21",
    "java-17",
    "java-11",
    "java-8",
    "java-war-machine-21",
    "java-war-machine-17",
    "java-war-machine-11",
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
    "alpine-22",
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
group "java" {
  targets = [
    "java-21",
    "java-17",
    "java-11",
    "java-8",
    "java-war-machine-21",
    "java-war-machine-17",
    "java-war-machine-11",
  ]
}
target "alpine-22" {
  dockerfile = "Alpine.Dockerfile"
  target     = "alpine-22-base"
  tags       = [
    "ghcr.io/roushtech/docker/base:3.22",
    "ghcr.io/roushtech/docker/base:3.22-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "Roushtech-flavoured Alpine Linux base image"
  }
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
target "builder-22" {
  dockerfile = "Alpine.Dockerfile"
  target     = "builder-22-base"
  tags       = [
    "ghcr.io/roushtech/docker/builder:3.22",
    "ghcr.io/roushtech/docker/builder:3.22-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "Roushtech-flavoured Alpine Linux base image that has build tools installed"
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
target "java-21" {
  dockerfile = "Java.Dockerfile"
  target     = "java-21-base"
  tags       = [
    "ghcr.io/roushtech/docker/java:latest",
    "ghcr.io/roushtech/docker/java:21",
    "ghcr.io/roushtech/docker/java:21-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "Java JDK 21 base image"
  }
}
target "java-17" {
  dockerfile = "Java.Dockerfile"
  target     = "java-17-base"
  tags       = [
    "ghcr.io/roushtech/docker/java:17",
    "ghcr.io/roushtech/docker/java:17-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "Java JDK 11 base image"
  }
}
target "java-11" {
  dockerfile = "Java.Dockerfile"
  target     = "java-11-base"
  tags       = [
    "ghcr.io/roushtech/docker/java:11",
    "ghcr.io/roushtech/docker/java:11-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "Java JDK 11 base image"
  }
}
target "java-8" {
  dockerfile = "Java.Dockerfile"
  target     = "java-8-base"
  tags       = [
    "ghcr.io/roushtech/docker/java:8",
    "ghcr.io/roushtech/docker/java:8-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "Java JDK 8 base image"
  }
}
target "java-war-machine-21" {
  dockerfile = "Java.Dockerfile"
  target     = "java-war-machine-21-base"
  tags       = [
    "ghcr.io/roushtech/docker/java:war-machine-21",
    "ghcr.io/roushtech/docker/java:war-machine-21-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "Java JDK 21 base image that automatically runs WAR files"
  }
}
target "java-war-machine-17" {
  dockerfile = "Java.Dockerfile"
  target     = "java-war-machine-17-base"
  tags       = [
    "ghcr.io/roushtech/docker/java:war-machine-17",
    "ghcr.io/roushtech/docker/java:war-machine-17-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "Java JDK 17 base image that automatically runs WAR files"
  }
}
target "java-war-machine-11" {
  dockerfile = "Java.Dockerfile"
  target     = "java-war-machine-11-base"
  tags       = [
    "ghcr.io/roushtech/docker/java:war-machine-11",
    "ghcr.io/roushtech/docker/java:war-machine-11-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "Java JDK 11 base image that automatically runs WAR files"
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