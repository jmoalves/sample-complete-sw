#!/bin/bash
set -e
scriptPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd && cd - >/dev/null 2>&1 )"

docker build \
    --progress=plain \
    -t jmoalves/sample-app \
    -t localhost:32000/jmoalves/sample-app \
    ${scriptPath}/..

docker push localhost:32000/jmoalves/sample-app
