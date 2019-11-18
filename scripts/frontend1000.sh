#!/bin/bash
# inicializar as instancias docker

docker run -i -t --rm --network=bft_network --name=1000.frontend.bft -e FRONTEND_CONFIG_DIR=/bft-config/config/ -e FABRIC_CFG_PATH=/bft-config/fabric/ -v /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/:/bft-config/ bftsmart/fabric-frontend:amd64-1.3.0 1000
