#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# dev app
printf "${GREEN}[DEV]${NC} - Install and launch app...\n"
sudo kubectl apply -f ./confs/dev/namespace.yaml
sudo kubectl apply -n argocd -f ./confs/dev/app.yaml > /dev/null
sudo kubectl apply -n dev -f ./confs/dev/ingress.yaml > /dev/null
