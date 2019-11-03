#!/bin/bash
# inicializar as instancias docker
bash --rcfile <(echo '. ~/.bashrc; docker run -i -t --rm --network=bft_network --name=3.node.bft -e NODE_CONFIG_DIR=/bft-config/config/ -v /home/jose/fabric-orderingservice/docker_images/3.node_material/:/bft-config/ bftsmart/fabric-orderingnode:amd64-1.3.0 3')
