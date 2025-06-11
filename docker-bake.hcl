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
    "base",
    "java", "java-war-machine", "java-tomcat",
    "php", "magento",
  ]
}
target "base" {
  dockerfile = "Alpine.Dockerfile"
  name = "${variant.variant}-${version.version}"
  target = "${variant.variant}-${version.version}-base"
  matrix = {
    variant = [
      { variant="alpine",  target="base",    description="Roushtech-flavoured Alpine Linux base image"                                },
      { variant="builder", target="builder", description="Roushtech-flavoured Alpine Linux base image that has build tools installed" },
    ]
    version = [
      { version=22, latest=true },
      { version=21 },
      { version=18 },
      { version=15 },
    ]
  }
  tags = compact([
    try(version.latest ? "ghcr.io/roushtech/docker/${variant.target}:latest" : null, null),
    "ghcr.io/roushtech/docker/${variant.target}:${version.version}",
    "ghcr.io/roushtech/docker/${variant.target}:${version.version}-${TIMESTAMP}",
  ])
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = variant.description
  }
}
target "java" {
  dockerfile = "Java.Dockerfile"
  name = "java-${version.version}"
  target = "java-${version.version}-base"
  matrix = {
    version = [
      { version=21, latest=true },
      { version=17 },
      { version=11 },
      { version=8 },
    ]
  }
  tags = compact([
    try(version.latest ? "ghcr.io/roushtech/docker/java:latest" : null, null),
    "ghcr.io/roushtech/docker/java:${version.version}",
    "ghcr.io/roushtech/docker/java:${version.version}-${TIMESTAMP}",
  ])
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "Java JDK ${version.version} base image"
  }
}
target "java-tomcat" {
  dockerfile = "Java.Dockerfile"
  name = "java-tomcat-${version.version}"
  target = "java-tomcat-${version.version}-base"
  matrix = {
    version = [
      { version=21, latest=true },
      { version=17 },
      { version=11 },
      { version=8 },
      { version=7 },
    ]
  }
  tags = compact([
    try(version.latest ? "ghcr.io/roushtech/docker/java:tomcat-latest" : null, null),
    "ghcr.io/roushtech/docker/java:tomcat-${version.version}",
    "ghcr.io/roushtech/docker/java:tomcat-${version.version}-${TIMESTAMP}",
  ])
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "Java JDK ${version.version} base image"
  }
}
target "java-war-machine" {
  dockerfile = "Java.Dockerfile"
  name = "java-war-machine-${version.version}"
  target = "java-war-machine-${version.version}-base"
  matrix = {
    version = [
      { version=21, latest=true },
      { version=17 },
      { version=11 },
    ]
  }
  tags = compact([
    try(version.latest ? "ghcr.io/roushtech/docker/java:war-machine-latest" : null, null),
    "ghcr.io/roushtech/docker/java:war-machine-${version.version}",
    "ghcr.io/roushtech/docker/java:war-machine-${version.version}-${TIMESTAMP}",
  ])
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "Java JDK ${version.version} base image that automatically runs WAR files"
  }
}
target "php" {
  dockerfile = "PHP.Dockerfile"
  name = "php-${replace(version.version, ".", "")}-${variant.target}"
  target = "php-${replace(version.version, ".", "")}-${variant.target}"
  matrix = {
    version = [
      { version=8.4, latest=true },
      { version=8.1 },
      { version=7.4 },
    ]
    variant = [
      { variant="php",      target="base"     , description="base image" },
      { variant="php-node", target="node-base", description="base image with Node.js installed" },
    ]
  }
  tags = compact([
    try(version.latest ? "ghcr.io/roushtech/docker/${variant.variant}:latest" : null, null),
    "ghcr.io/roushtech/docker/${variant.variant}:${version.version}",
    "ghcr.io/roushtech/docker/${variant.variant}:${version.version}-${TIMESTAMP}",
  ])
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "PHP ${version.version} ${variant.description}"
  }
}
target "magento" {
  dockerfile = "Magento.Dockerfile"
  name = "magento-${replace(version.version, ".", "")}"
  target = "magento-${replace(version.version, ".", "")}-node-base"
  matrix = {
    version = [
      { version = 8.4, latest = true },
      { version = 8.1 },
    ]
  }
  tags = compact([
    try(version.latest ? "ghcr.io/roushtech/docker/magento:latest" : null, null),
    "ghcr.io/roushtech/docker/magento:${version.version}",
    "ghcr.io/roushtech/docker/magento:${version.version}-${TIMESTAMP}",
  ])
  platforms  = PLATFORMS
  labels = {
    "org.opencontainers.image.description" = "Magento on PHP ${version.version}"
  }
}
