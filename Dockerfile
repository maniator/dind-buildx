FROM docker:latest as buildx_image

ARG DOCKER_CONFIG=/env_configs/.docker
ARG BUILDX_VERSION=0.6.0
ARG BUILDX_URL="https://github.com/docker/buildx/releases/download/v${BUILDX_VERSION}/buildx-v${BUILDX_VERSION}.linux-amd64"

ENV DOCKER_CONFIG=$DOCKER_CONFIG \
    DOCKER_CLI_EXPERIMENTAL="enabled"

WORKDIR $DOCKER_CONFIG/cli-plugins

RUN wget -O ./docker-buildx $BUILDX_URL \
    && chmod a+x ./docker-buildx

ENTRYPOINT [ "/usr/local/bin/docker" , "buildx"]

CMD ["version"]
