# syntax=docker/dockerfile:1.2

ARG ALPINE_VERSION=latest
ARG BUILDX_VERSION=latest
ARG DOCKER_VERSION=latest

FROM docker/buildx-bin:$BUILDX_VERSION as buildx_bin

FROM alpine:$ALPINE_VERSION as buildx_strip

COPY --from=buildx_bin /buildx /
RUN apk add -U binutils && strip /buildx

FROM docker:$DOCKER_VERSION as buildx_image

ARG DOCKER_CONFIG=/env_configs/.docker

ENV DOCKER_CONFIG=$DOCKER_CONFIG \
    DOCKER_CLI_EXPERIMENTAL=enabled

WORKDIR $DOCKER_CONFIG/cli-plugins

COPY --from=buildx_strip /buildx ./docker-buildx

ENTRYPOINT [ "/usr/local/bin/docker" , "buildx"]

CMD ["version"]
