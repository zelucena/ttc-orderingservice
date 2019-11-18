#!/bin/bash
# inicializar as instancias docker

docker run -i -t --rm --network=bft_network -e FABRIC_CFG_PATH=/bft-config/fabric/ -v /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/:/bft-config/ -e CORE_PEER_ADDRESS=0.peer.ibm.bft:7051 -e CORE_PEER_MSPCONFIGPATH=/bft-config/fabric/msp -e CORE_PEER_LOCALMSPID=IBMMSP bftsmart/fabric-tools:amd64-1.3.0

