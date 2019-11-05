#!/bin/bash
# inicializar as instancias docker

docker run -i -t --rm --network=bft_network -e FABRIC_CFG_PATH=/bft-config/fabric/ -v /home/jose/fabric-orderingservice/docker_images/admin.1.cli_material/:/bft-config/ -e CORE_PEER_ADDRESS=0.peer.lasige.bft:7051 bftsmart/fabric-tools:amd64-1.3.0

