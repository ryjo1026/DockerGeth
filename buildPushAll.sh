#!/bin/bash
# Start registry service
docker service create --name registry --publish 5000:5000 registry:2

# Build each image locally and tag
docker build -t localhost:5000/geth-manager -f geth-manager .
docker build -t localhost:5000/geth-node -f geth-node .
docker build -t localhost:5000/geth-miner -f geth-miner .

# Push each image to the registry
docker push localhost:5000/geth-manager
docker push localhost:5000/geth-node
docker push localhost:5000/geth-miner
