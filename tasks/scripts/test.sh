#!/bin/bash 

docker-compose -p take-item -f platform/local/docker-compose.yml run test\
    --recursive\
    -p /bats/unit\
    --print-output-on-failure\
    --jobs 10