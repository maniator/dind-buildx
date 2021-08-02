# Buildx in a docker container
### docker image with buildx pre-installed

Can run all `docker buildx` commands easily in a docker container 

```zsh
docker run --rm \
    -e DOCKER_TLS_CERTDIR=/certs \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $(pwd):$(pwd) -w $(pwd) maniator/docker-with-buildx build .
```

Which will build the Dockerfile in the current directory

Same with any [docker buildx](https://docs.docker.com/engine/reference/commandline/buildx/) commands

If you want to share buildx configs/node creations between runs, you can hook a volume like this:

```zsh
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
BUILDX_DIR="$DOCKER_CONFIG/buildx"

mkdir -p $BUILDX_DIR

docker run --rm \
    -e DOCKER_TLS_CERTDIR=/certs \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $BUILDX_DIR:/env_configs/.docker/buildx \
    -v $(pwd):$(pwd) -w $(pwd) maniator/docker-with-buildx \
    create --driver docker-container --name my_builder --use
docker run --rm \
    -e DOCKER_TLS_CERTDIR=/certs \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $BUILDX_DIR:/env_configs/.docker/buildx \
    -v $(pwd):$(pwd) -w $(pwd) maniator/docker-with-buildx \
    --builder=my_builder build .
```

[![Snyk Container](https://github.com/maniator/dind-buildx/actions/workflows/snyk-container-analysis.yml/badge.svg)](https://github.com/maniator/dind-buildx/actions/workflows/snyk-container-analysis.yml)
[![Docker](https://github.com/maniator/dind-buildx/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/maniator/dind-buildx/actions/workflows/docker-publish.yml)

[![DockerHub Badge](http://dockeri.co/image/maniator/docker-with-buildx)](https://hub.docker.com/r/maniator/docker-with-buildx/)
