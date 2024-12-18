#!/bin/sh

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb \
    && dpkg -i minikube_latest_amd64.deb
