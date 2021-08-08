#!/bin/bash
CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    touch $CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"
    sudo usermod -u 1000 -o circleci
    sudo groupmod -o -g 1000 circleci
    sudo chown -R circleci:circleci .gnupg/
    while true; do sleep 1000; done
else
    echo "-- Not first container startup --"
    sudo chown circleci -R /dev/kvm
fi
