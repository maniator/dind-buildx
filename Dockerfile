ARG BUILDX_VERSION=latest
ARG DOCKER_VERSION=latest

FROM docker/buildx-bin:$BUILDX_VERSION as buildx_bin

FROM docker:$DOCKER_VERSION as buildx_image

ARG DOCKER_CONFIG=/env_configs/.docker

ENV DOCKER_CONFIG=$DOCKER_CONFIG \
    DOCKER_CLI_EXPERIMENTAL="enabled"

WORKDIR $DOCKER_CONFIG/cli-plugins

COPY --from=buildx_bin /buildx ./docker-buildx

ENTRYPOINT [ "/usr/local/bin/docker" , "buildx"]

CMD ["version"]
