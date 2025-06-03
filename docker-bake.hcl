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
    "php-74",
    "php-81",
    "php-81-node",
    "magento-81",
    "magento-81-node",
  ]
  labels = {
    "org.opencontainers.image.created" = timestamp()
    "org.opencontainers.image.authors" = "Matthew B <matthew.baggett@roushtech.net>"
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
    "php-74",
    "php-81",
    "php-81-node",
    "php-84",
  ]
}
group "magento" {
  targets = [
    "magento-81",
    "magento-81-node",
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
}
target "alpine-15" {
  dockerfile = "Alpine.Dockerfile"
  target     = "alpine-15-base"
  tags       = [
    "ghcr.io/roushtech/docker/base:3.15",
    "ghcr.io/roushtech/docker/base:3.15-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
}
target "php-74" {
  dockerfile = "PHP.Dockerfile"
  target     = "php-74-base"
  tags       = [
    "ghcr.io/roushtech/docker/php:7.4",
    "ghcr.io/roushtech/docker/php:7.4-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
}
target "php-81" {
  dockerfile = "PHP.Dockerfile"
  target     = "php-81-base"
  tags       = [
    "ghcr.io/roushtech/docker/php:8.1",
    "ghcr.io/roushtech/docker/php:8.1-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
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
}
target "php-81-node" {
  dockerfile = "PHP-Node.Dockerfile"
  target     = "php-81-node-base"
  tags       = [
    "ghcr.io/roushtech/docker/php-node:latest",
    "ghcr.io/roushtech/docker/php-node:8.1",
    "ghcr.io/roushtech/docker/php-node:8.1-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
}
target "magento-81" {
  dockerfile = "Magento.Dockerfile"
  target     = "magento-81-base"
  tags       = [
    "ghcr.io/roushtech/docker/magento:latest",
    "ghcr.io/roushtech/docker/magento:8.1",
    "ghcr.io/roushtech/docker/magento:8.1-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
}
target "magento-81-node" {
  dockerfile = "Magento.Dockerfile"
  target     = "magento-81-node-base"
  tags       = [
    "ghcr.io/roushtech/docker/magento:latest-node",
    "ghcr.io/roushtech/docker/magento:8.1-node",
    "ghcr.io/roushtech/docker/magento:8.1-node-${TIMESTAMP}",
  ]
  platforms  = PLATFORMS
}