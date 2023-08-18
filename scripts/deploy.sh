#!/bin/bash
set -e
scriptPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd && cd - >/dev/null 2>&1 )"

kubectl apply -f ${scriptPath}/../kubectl.yaml
