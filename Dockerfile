FROM docker:latest

ENV DOCKER_BUILDKIT=1 \
    BUILDX_VERSION=0.5.1

ARG BUILDX_URL="https://github.com/docker/buildx/releases/download/v${BUILDX_VERSION}/buildx-v${BUILDX_VERSION}.linux-amd64"
RUN mkdir -p ~/.docker && echo '{"experimental": "enabled"}' > ~/.docker/config.json \
    && mkdir -p $HOME/.docker/cli-plugins/ && wget -O $HOME/.docker/cli-plugins/docker-buildx $BUILDX_URL \
    && chmod a+x $HOME/.docker/cli-plugins/docker-buildx

ENTRYPOINT [ "/usr/local/bin/docker" , "buildx"]

CMD ["version"]