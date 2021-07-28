FROM docker:latest

ENV DOCKER_BUILDKIT=1 \
    BUILDX_VERSION=0.6.0

ARG BUILDX_URL="https://github.com/docker/buildx/releases/download/v${BUILDX_VERSION}/buildx-v${BUILDX_VERSION}.linux-amd64"
ARG HOME=/root
ADD $BUILDX_URL $HOME/.docker/cli-plugins/docker-buildx
RUN echo '{"experimental": "enabled"}' > ~/.docker/config.json \
    && chmod a+x $HOME/.docker/cli-plugins/docker-buildx

ENTRYPOINT [ "/usr/local/bin/docker" , "buildx"]

CMD ["version"]
