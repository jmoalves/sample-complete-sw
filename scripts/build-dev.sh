#!/bin/bash
scriptPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd && cd - >/dev/null 2>&1 )"

docker build \
    --progress=plain \
    -t jmoalves/sample-app-build \
    -f ${scriptPath}/../.devcontainer/Dockerfile \
    ${scriptPath}/..
