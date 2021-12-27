#!/usr/bin/env bash
function usage {
  >&2 echo usage $0 "<ssh server>"
  exit 1
}
[[ -z "$1" ]] && usage
export CONNECTION="$1"
ssh $COONECTION 'sudo dnf -qy install zip'
ssh $CONNECTION 'sdk version || curl -s "https://get.sdkman.io" | bash'
ssh $CONNECTION 'java --version || sdk install java 11.0.12-open'
