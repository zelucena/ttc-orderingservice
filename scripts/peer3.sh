#!/bin/bash
docker create -i -t --rm --network=bridge --name=1.peer.lasige.bft -e FABRIC_CFG_PATH=/bft-config/fabric/ -v /home/jose/fabric-orderingservice/docker_images/3.peer_material/:/bft-config/ -v /var/run/:/var/run/  hyperledger/fabric-peer:amd64-1.3.0

docker network connect bft_network 1.peer.lasige.bft

docker start -a 1.peer.lasige.bft

