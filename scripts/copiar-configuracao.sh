#!/bin/bash

#cada participante da rede possui seu próprio arquivo de configuração, portanto as configurações devem ser replicadas a partir dos modelos
#assumindo que as informações são geradas do admin ibm, copiar o crypto-material, o genesisblock, os certificados e chaves-privadas.
########### copiar genesisblock do admin ibm 0 para todas as instâncias

#cli
cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/genesisblock /home/jose/fabric-orderingservice/docker_images/0.cli_material/genesisblock

#nodes
cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/genesisblock /home/jose/fabric-orderingservice/docker_images/0.node_material/genesisblock

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/genesisblock /home/jose/fabric-orderingservice/docker_images/1.node_material/genesisblock

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/genesisblock /home/jose/fabric-orderingservice/docker_images/2.node_material/genesisblock

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/genesisblock /home/jose/fabric-orderingservice/docker_images/3.node_material/genesisblock

#frontend

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/genesisblock /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/genesisblock

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/genesisblock /home/jose/fabric-orderingservice/docker_images/2000.frontend_material/genesisblock

########### copiar crypto-material
#clients
rm -R -f /home/jose/fabric-orderingservice/docker_images/0.cli_material/fabric/msp/keystore/
cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/peerOrganizations/ibm.bft/users/User1@ibm.bft/. /home/jose/fabric-orderingservice/docker_images/0.cli_material/fabric/

rm -R -f /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/fabric/msp/keystore/
cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/peerOrganizations/ibm.bft/users/Admin@ibm.bft/. /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/fabric/

#peers
rm -R -f /home/jose/fabric-orderingservice/docker_images/0.peer_material/fabric/msp/keystore/
rsync -av --exclude='msp/config.yaml' /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/peerOrganizations/ibm.bft/peers/0.peer.ibm.bft/ /home/jose/fabric-orderingservice/docker_images/0.peer_material/fabric/

rm -R -f /home/jose/fabric-orderingservice/docker_images/1.peer_material/fabric/msp/keystore/
rsync -av --exclude='msp/config.yaml' /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/peerOrganizations/ibm.bft/peers/1.peer.ibm.bft/ /home/jose/fabric-orderingservice/docker_images/1.peer_material/fabric/

#frontend
rm -R -f /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/fabric/msp/keystore/
rm -R -f /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/

cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/frontend.bft/orderers/1000.frontend.bft/. /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/fabric/

rm -R -f /home/jose/fabric-orderingservice/docker_images/2000.frontend_material/fabric/msp/keystore/
rm -R -f /home/jose/fabric-orderingservice/docker_images/2000.frontend_material/config/keys/

cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/frontend.bft/orderers/2000.frontend.bft/. /home/jose/fabric-orderingservice/docker_images/2000.frontend_material/fabric/

#nodes
rm -R -f /home/jose/fabric-orderingservice/docker_images/0.node_material/msp/keystore/
rm -R -f /home/jose/fabric-orderingservice/docker_images/0.node_material/config/keys/

cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/0.node.bft/. /home/jose/fabric-orderingservice/docker_images/0.node_material/

rm -R -f /home/jose/fabric-orderingservice/docker_images/1.node_material/msp/keystore/
rm -R -f /home/jose/fabric-orderingservice/docker_images/1.node_material/config/keys/
cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/1.node.bft/. /home/jose/fabric-orderingservice/docker_images/1.node_material/

rm -R -f /home/jose/fabric-orderingservice/docker_images/2.node_material/msp/keystore/
rm -R -f /home/jose/fabric-orderingservice/docker_images/2.node_material/config/keys/
cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/2.node.bft/. /home/jose/fabric-orderingservice/docker_images/2.node_material/

rm -R -f /home/jose/fabric-orderingservice/docker_images/3.node_material/msp/keystore/
rm -R -f /home/jose/fabric-orderingservice/docker_images/3.node_material/config/keys/
cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/3.node.bft/. /home/jose/fabric-orderingservice/docker_images/3.node_material/

########### copiar assinaturas (nodos, frontends)
# copiar todos os certificados para uma pasta, renomeando para nodos / frontends para cert<id>.pem. Replicar a pasta inteira com os certificados. A diferença é que em cada pasta a chave privada é individual

#nodes
mkdir -p /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/
cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/0.node.bft/msp/signcerts/0.node.bft-cert.pem /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/cert0.pem

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/1.node.bft/msp/signcerts/1.node.bft-cert.pem /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/cert1.pem

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/2.node.bft/msp/signcerts/2.node.bft-cert.pem /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/cert2.pem

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/3.node.bft/msp/signcerts/3.node.bft-cert.pem /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/cert3.pem

#frontends
cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/frontend.bft/orderers/1000.frontend.bft/msp/signcerts/1000.frontend.bft-cert.pem /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/cert1000.pem

cp /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/frontend.bft/orderers/2000.frontend.bft/msp/signcerts/2000.frontend.bft-cert.pem /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/cert2000.pem

##replicar a partir da configuração em 1000.frontend.bft
#nodes
cp -a /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/. /home/jose/fabric-orderingservice/docker_images/0.node_material/config/keys/

cp -a /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/. /home/jose/fabric-orderingservice/docker_images/1.node_material/config/keys/

cp -a /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/. /home/jose/fabric-orderingservice/docker_images/2.node_material/config/keys/

cp -a /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/. /home/jose/fabric-orderingservice/docker_images/3.node_material/config/keys/

#frontend
cp -a /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/. /home/jose/fabric-orderingservice/docker_images/2000.frontend_material/config/keys/

##copiar chave privada
#frontend

#1000
cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/frontend.bft/orderers/1000.frontend.bft/msp/keystore/. /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/

mv /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/$(ls /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/ | grep _sk) /home/jose/fabric-orderingservice/docker_images/1000.frontend_material/config/keys/keystore.pem

#2000
cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/frontend.bft/orderers/2000.frontend.bft/msp/keystore/. /home/jose/fabric-orderingservice/docker_images/2000.frontend_material/config/keys/

mv /home/jose/fabric-orderingservice/docker_images/2000.frontend_material/config/keys/$(ls /home/jose/fabric-orderingservice/docker_images/2000.frontend_material/config/keys/ | grep _sk) /home/jose/fabric-orderingservice/docker_images/2000.frontend_material/config/keys/keystore.pem

#nodes
#0
cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/0.node.bft/msp/keystore/. /home/jose/fabric-orderingservice/docker_images/0.node_material/config/keys/

mv /home/jose/fabric-orderingservice/docker_images/0.node_material/config/keys/$(ls /home/jose/fabric-orderingservice/docker_images/0.node_material/config/keys/ | grep _sk) /home/jose/fabric-orderingservice/docker_images/0.node_material/config/keys/keystore.pem

#1
cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/1.node.bft/msp/keystore/. /home/jose/fabric-orderingservice/docker_images/1.node_material/config/keys/

mv /home/jose/fabric-orderingservice/docker_images/1.node_material/config/keys/$(ls /home/jose/fabric-orderingservice/docker_images/1.node_material/config/keys/ | grep _sk) /home/jose/fabric-orderingservice/docker_images/1.node_material/config/keys/keystore.pem

#2
cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/2.node.bft/msp/keystore/. /home/jose/fabric-orderingservice/docker_images/2.node_material/config/keys/

mv /home/jose/fabric-orderingservice/docker_images/2.node_material/config/keys/$(ls /home/jose/fabric-orderingservice/docker_images/2.node_material/config/keys/ | grep _sk) /home/jose/fabric-orderingservice/docker_images/2.node_material/config/keys/keystore.pem

#3
cp -a /home/jose/fabric-orderingservice/docker_images/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/3.node.bft/msp/keystore/. /home/jose/fabric-orderingservice/docker_images/3.node_material/config/keys/

mv /home/jose/fabric-orderingservice/docker_images/3.node_material/config/keys/$(ls /home/jose/fabric-orderingservice/docker_images/3.node_material/config/keys/ | grep _sk) /home/jose/fabric-orderingservice/docker_images/3.node_material/config/keys/keystore.pem
