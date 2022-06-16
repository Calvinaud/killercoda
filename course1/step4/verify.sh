#!/bin/bash
if [[ $(docker image ls --filter 'reference=myapp:1.0.0' --format "{{.ID}}") ]]; then
    exit 0
else
    exit 1
fi