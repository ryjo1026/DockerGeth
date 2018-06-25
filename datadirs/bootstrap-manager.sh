#!/bin/bash

# Run bootnode and ethstats
bootnode -nodekey /boot.key -addr :30400 &
cd /eth-netstats && WS_SECRET=!!!ETHSTATS_SECRET_HERE!!! npm start
