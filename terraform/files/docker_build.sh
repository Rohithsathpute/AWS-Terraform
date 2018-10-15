#!/usr/bin/env bash
set -e

docker build -t $1 .
$(/usr/local/bin/aws ecr get-login --no-include-email)
docker push $1
