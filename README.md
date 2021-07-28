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