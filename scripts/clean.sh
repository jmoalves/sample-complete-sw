#!/bin/bash
scriptPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd && cd - >/dev/null 2>&1 )"

docker run -it --rm --mount type=bind,source="$(pwd)",target=/home/developer/src jmoalves/sample-app-build "mvn clean"