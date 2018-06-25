#!/bin/bash

# Wait until the hostname geth-manager resolves to an IP (Done as part of compose)
MANAGER_IP="$(dig +short geth-manager)"
while true
do
  if [ -z "$MANAGER_IP" ]
  then
    echo "Waiting for geth-manager"
    sleep 30
    MANAGER_IP="$(dig +short geth-manager)"
  else
    break
  fi
done
sleep 30

# Set nodename as hostname for eth-netstats
NODENAME="$(cat /etc/hostname)"
echo "Set node name to: ${NODENAME}"

# Startup a node
geth --datadir /datadir --syncmode full --port 30300 --rpc --rpcaddr 0.0.0.0 --rpccorsdomain "*" --rpcport 8500\
        --bootnodes !!!BOOTNODE_ENODE_ADDRESS_HERE!!!@${MANAGER_IP}:30400\
        --networkid 1515 --ethstats ${NODENAME}:!!!ETHSTATS_SECRET_HERE!!!${MANAGER_IP}:3000
