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
echo "Set node name to: ${NODENAME}-miner"

# Setup a new account with passphrase from password.txt then extract the account name for geth command
ETHERBASE="$(geth account new --password /password.txt | cut -d "{" -f2 | cut -d "}" -f1)"

# Start up a node in mining mode
geth --datadir /datadir --syncmode full --port 30300 --rpc --rpcaddr 0.0.0.0 --rpccorsdomain "*" --rpcport 8500\
  --bootnodes !!!BOOTNODE_ENODE_ADDRESS_HERE!!!@${MANAGER_IP}:30400\
  --networkid 1515 --etherbase ${ETHERBASE} --mine --ethstats ${NODENAME}-miner:!!!ETHSTATS_SECRET_HERE!!!@${MANAGER_IP}:3000
