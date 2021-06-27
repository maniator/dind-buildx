FROM docker:latest as root

ENV DOCKER_BUILDKIT=1

ARG BUILDX_VERSION=0.5.1
ARG BUILDX_URL="https://github.com/docker/buildx/releases/download/v${BUILDX_VERSION}/buildx-v${BUILDX_VERSION}.linux-amd64"
RUN mkdir -p ~/.docker && echo '{"experimental": "enabled"}' > ~/.docker/config.json
RUN echo $BUILDX_URL "HELLO"
RUN mkdir -p $HOME/.docker/cli-plugins/ && wget -O $HOME/.docker/cli-plugins/docker-buildx $BUILDX_URL && chmod a+x $HOME/.docker/cli-plugins/docker-buildx

ENTRYPOINT [ "/usr/local/bin/docker" , "buildx"]

CMD ["version"]