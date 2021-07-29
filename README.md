# Buildx in a docker container

Can run all `docker buildx` commands easily in a docker container 

```zsh
docker run --rm \
    -e DOCKER_TLS_CERTDIR=/certs \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $(pwd):$(pwd) -w $(pwd) maniator/dind-buildx build .
```

Which will build the Dockerfile in the current directory

Same with any [docker buildx](https://docs.docker.com/engine/reference/commandline/buildx/) commands


[![Snyk Container](https://github.com/maniator/dind-buildx/actions/workflows/snyk-container-analysis.yml/badge.svg)](https://github.com/maniator/dind-buildx/actions/workflows/snyk-container-analysis.yml)
[![Docker](https://github.com/maniator/dind-buildx/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/maniator/dind-buildx/actions/workflows/docker-publish.yml)

[![DockerHub Badge](http://dockeri.co/image/maniator/dind-buildx)](https://hub.docker.com/r/maniator/dind-buildx/)
