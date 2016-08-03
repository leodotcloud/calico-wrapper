#!/bin/bash

REPO=${REPO:-"rancher"}
TAG=${TAG:-"dev"}
IMAGE=${IMAGE:-"calico-wrapper"}

echo "Beginning build of image [${IMAGE}] using repo [${REPO}] and tag [${TAG}]"

docker build -t ${REPO}/${IMAGE}:${TAG} .

echo "Done building"
