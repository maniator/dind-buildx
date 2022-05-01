// docker-bake.hcl
variable "IMAGE_NAME" { default="dind-buildx:latest" }
variable "DOCKER_VERSION" { default="latest" }
variable "BUILDX_VERSION" { default="latest" }

group "default" {
    targets = ["build"]
}

target "docker-metadata-action" {}

target "root" {
  context = "."
  dockerfile = "Dockerfile"
  target = "buildx_image"
  args = {
    DOCKER_VERSION: DOCKER_VERSION,
    BUILDX_VERSION: BUILDX_VERSION
  }
  tags = [ 
    IMAGE_NAME
  ]
}

target "build" {
  inherits = ["root", "docker-metadata-action"]
  platforms = [
    "linux/amd64",
    equal(DOCKER_VERSION, "latest") ? "linux/arm/v6" : "",
    equal(DOCKER_VERSION, "latest") ? "linux/arm/v7" : "",
    "linux/arm64/v8"
  ]
}
