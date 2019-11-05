#!/bin/bash

########### copiar genesisblock do admin ibm 0 para todas as instâncias

#cli
cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/genesisblock /home/jose/fabric-orderingservice/docker_images/0.cli_material/

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/genesisblock /home/jose/fabric-orderingservice/docker_images/1.cli_material/

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/genesisblock /home/jose/fabric-orderingservice/docker_images/admin.1.cli_material/

#nodes
cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/genesisblock /home/jose/fabric-orderingservice/docker_images/0.node_material/

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/genesisblock /home/jose/fabric-orderingservice/docker_images/1.node_material/

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/genesisblock /home/jose/fabric-orderingservice/docker_images/2.node_material/

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/genesisblock /home/jose/fabric-orderingservice/docker_images/3.node_material/

########### copiar cryptoconfig

#clients
cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/peerOrganizations/ibm.bft/users/User1@ibm.bft/. /home/jose/fabric-orderingservice/docker_images/0.cli_material/fabric/

cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/peerOrganizations/ibm.bft/users/Admin@ibm.bft/. /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/fabric/

cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/peerOrganizations/lasige.bft/users/User1@lasige.bft/. /home/jose/fabric-orderingservice/docker_images/1.cli_material/fabric/

cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/peerOrganizations/ibm.bft/users/Admin@lasige.bft/. /home/jose/fabric-orderingservice/docker_images/admin.1.cli_material/fabric/

#peers
rsync -av --exclude='msp/config.yaml' /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/peerOrganizations/ibm.bft/peers/0.peer.ibm.bft
