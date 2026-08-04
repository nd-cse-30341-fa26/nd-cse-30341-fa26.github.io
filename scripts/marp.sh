#!/bin/sh

exec docker run \
    --rm \
    -p 8080:8080 \
    -p 37717:37717 \
    -v $(pwd):/home/marp/app/ \
    -e LANG=$LANG \
    -e MARP_USER="$(id -u):$(id -g)" \
    marpteam/marp-cli --allow-local-files $@
