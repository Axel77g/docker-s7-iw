#!/bin/bash

PREFIX="axel77g"

build_image() {
    local image_name="$1"
    local context="$2"
    local dockerfile="$2/$3"
    local platform="$4"
    local tag="$PREFIX/$image_name:latest"

    echo "Building $image_name for $platform : docker buildx build --platform $platform -t $tag -f $dockerfile --push $context"
    docker buildx build --no-cache --platform "$platform" -t "$tag" -f "$dockerfile" --push "$context"
}

docker buildx create --use --name docker-tp-builder
build_image "adminer-tp-docker-esgi" "docker/adminer" "adminer.Dockerfile" "linux/amd64,linux/arm64"
build_image "composer-tp-docker-esgi" "docker/composer" "composer.Dockerfile" "linux/amd64,linux/arm64"
build_image "postgres-tp-docker-esgi" "docker/postgres" "postgres.Dockerfile" "linux/amd64,linux/arm64"
build_image "symfony-tp-docker-esgi" "docker/symfony" "symfony.Dockerfile" "linux/amd64,linux/arm64"
