#!/bin/bash

#cada participante da rede possui seu próprio arquivo de configuração, portanto as configurações devem ser replicadas a partir dos modelos
#assumindo que as informações são geradas do admin ibm, copiar o crypto-material, o genesisblock, os certificados e chaves-privadas.
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

########### copiar crypto-material

#clients
cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/peerOrganizations/ibm.bft/users/User1@ibm.bft/. /home/jose/fabric-orderingservice/docker_images/0.cli_material/fabric/

cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/peerOrganizations/ibm.bft/users/Admin@ibm.bft/. /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/fabric/

cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/peerOrganizations/lasige.bft/users/User1@lasige.bft/. /home/jose/fabric-orderingservice/docker_images/1.cli_material/fabric/

cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/peerOrganizations/lasige.bft/users/Admin@lasige.bft/. /home/jose/fabric-orderingservice/docker_images/admin.1.cli_material/fabric/

#peers
rsync -av --exclude='msp/config.yaml' /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/peerOrganizations/
ibm.bft/peers/0.peer.ibm.bft/ /home/jose/fabric-orderingservice/docker_images/0.peer_material/fabric/

rsync -av --exclude='msp/config.yaml' /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/peerOrganizations/ibm.bft/peers/1.peer.ibm.bft/ /home/jose/fabric-orderingservice/docker_images/1.peer_material/fabric/

rsync -av --exclude='msp/config.yaml' /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/peerOrganizations/
lasige.bft/peers/0.peer.lasige.bft/ /home/jose/fabric-orderingservice/docker_images/2.peer_material/fabric/

rsync -av --exclude='msp/config.yaml' /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/peerOrganizations/lasige.bft/peers/1.peer.lasige.bft/ /home/jose/fabric-orderingservice/docker_images/3.peer_material/fabric/

#frontend
cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/frontend.bft/orderers/1000.frontend.bft/. /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/fabric/

cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/frontend.bft/orderers/2000.frontend.bft/. /home/jose/fabric-orderingservice/docker_images/2000.frontend_material/fabric/

#nodes
cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/0.node.bft/ /home/jose/fabric-orderingservice/docker_images/0.node_material/

cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/1.node.bft/ /home/jose/fabric-orderingservice/docker_images/1.node_material/

cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/2.node.bft/ /home/jose/fabric-orderingservice/docker_images/2.node_material/

cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/3.node.bft/ /home/jose/fabric-orderingservice/docker_images/3.node_material/

########### copiar assinaturas (nodos, frontends)
# copiar todos os certificados para uma pasta, renomeando para nodos / frontends para cert<id>.pem. Replicar a pasta inteira com os certificados. A diferença é que em cada pasta a chave privada é individual

#nodes
cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/0.node.bft/0.node.bft-cert.pem /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/cert0.pem

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/1.node.bft/1.node.bft-cert.pem /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/cert1.pem

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/2.node.bft/2.node.bft-cert.pem /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/cert2.pem

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/3.node.bft/3.node.bft-cert.pem /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/cert3.pem

#frontends
cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/frontend.bft/orderers/1000.frontend.bft/msp/signcerts/1000.frontend.bft-cert.pem /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/cert1000.pem

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/frontend.bft/orderers/2000.frontend.bft/msp/signcerts/2000.frontend.bft-cert.pem /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/cert2000.pem

##replicar a partir da configuração em 1000.frontend.bft
#nodes
cp /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/. /home/jose/fabric-orderingservice/docker_images/0.node_material/config/keys/

cp /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/. /home/jose/fabric-orderingservice/docker_images/1.node_material/config/keys/

cp /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/. /home/jose/fabric-orderingservice/docker_images/2.node_material/config/keys/

cp /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/. /home/jose/fabric-orderingservice/docker_images/3.node_material/config/keys/

#frontend
cp /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/. /home/jose/fabric-orderingservice/docker_images/2000.frontend_material/config/keys/

##copiar chave privada
#frontend
cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/frontend.bft/orderers/1000.frontend.bft/msp/keystore/. /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/frontend.bft/orderers/2000.frontend.bft/msp/keystore/. /home/jose/fabric-orderingservice/docker_images/2000.frontend_material/config/keys/

#nodes
cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/0.node.bft/msp/keystore/. /home/jose/fabric-orderingservice/docker_images/0.node_material/config/keys/

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/1.node.bft/msp/keystore/. /home/jose/fabric-orderingservice/docker_images/1.node_material/config/keys/

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/2.node.bft/msp/keystore/. /home/jose/fabric-orderingservice/docker_images/2.node_material/config/keys/

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/3.node.bft/msp/keystore/. /home/jose/fabric-orderingservice/docker_images/3.node_material/config/keys/
