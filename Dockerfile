# syntax=docker/dockerfile:1.2

ARG ALPINE_VERSION=3.15.4
ARG BUILDX_VERSION=0.8.2
ARG DOCKER_VERSION=20.10.14

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
