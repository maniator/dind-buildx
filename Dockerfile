FROM docker:latest as buildx_image

ARG DOCKER_CONFIG=/env_configs/.docker

ENV DOCKER_CONFIG=$DOCKER_CONFIG \
    DOCKER_CLI_EXPERIMENTAL="enabled"

WORKDIR $DOCKER_CONFIG/cli-plugins

COPY --from=docker/buildx-bin:0.6.0 /buildx ./docker-buildx

ENTRYPOINT [ "/usr/local/bin/docker" , "buildx"]

CMD ["version"]
