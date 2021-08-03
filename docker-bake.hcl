// docker-bake.hcl
variable "IMAGE_NAME" {}
variable "LABELED_IMAGE" {}
variable "DOCKER_VERSION" { default="latest" }
variable "BUILDX_VERSION" { default="latest" }
variable "REPO" { default="" }

group "default" {
    targets = ["build"]
}

target "docker-metadata-action" {}

target "build" {
  context = "."
  inherits = ["docker-metadata-action"]
  dockerfile = "Dockerfile"
  cache-from = [
    "${REPO}:latest",
    LABELED_IMAGE,
    IMAGE_NAME
  ]
  cache-to = [
    IMAGE_NAME
  ]
  args = {
    DOCKER_VERSION: DOCKER_VERSION,
    BUILDX_VERSION: BUILDX_VERSION
  }
  platforms = [
    "linux/amd64",
    "linux/arm64/v8"
  ]
  tags = [ 
    LABELED_IMAGE,
    IMAGE_NAME
  ]
}
