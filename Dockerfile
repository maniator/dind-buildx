# syntax=docker/dockerfile:1.2

ARG ALPINE_VERSION=3.24.1
ARG BUILDX_VERSION=0.35.0
ARG DOCKER_VERSION=29.5.3

FROM docker/buildx-bin:$BUILDX_VERSION as buildx_bin

FROM alpine:$ALPINE_VERSION as buildx_strip

COPY --from=buildx_bin /buildx /
RUN apk upgrade --no-cache && apk add --no-cache binutils && strip /buildx

FROM docker:$DOCKER_VERSION as buildx_image

# Pull any pending OS security patches into the runtime image's Alpine base.
RUN apk upgrade --no-cache

ARG DOCKER_CONFIG=/env_configs/.docker

ENV DOCKER_CONFIG=$DOCKER_CONFIG \
    DOCKER_CLI_EXPERIMENTAL=enabled

WORKDIR $DOCKER_CONFIG/cli-plugins

COPY --from=buildx_strip /buildx ./docker-buildx

ENTRYPOINT [ "/usr/local/bin/docker" , "buildx"]

CMD ["version"]
