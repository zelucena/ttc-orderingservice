#!/bin/bash
# sudo docker container stop $(sudo docker container ls -qa)
raiz=/home/jose/fabric-orderingservice/docker_images
cliIds=$(seq 0 10)
nodeIds=$(seq 0 3)
peerIds=$(seq 0 1)
frontendIds=(1000 2000)
enableTLS=false
clientAuthRequired=false
for nodeId in $nodeIds; do
mate-terminal -t $nodeId.node.bft -e "docker run -i -t --rm --network=bft_network --name=$nodeId.node.bft -e NODE_CONFIG_DIR=/bft-config/config/ -v $raiz/$nodeId.node_material/:/bft-config/ bftsmart/fabric-orderingnode:amd64-1.3.0 $nodeId" &
sleep 5
done

for frontendId in ${frontendIds[@]}; do
mate-terminal -t $frontendId.frontend.bft -e "docker run -i -t --rm --network=bft_network --name=$frontendId.frontend.bft -e FRONTEND_CONFIG_DIR=/bft-config/config/ -e FABRIC_CFG_PATH=/bft-config/fabric/ -e ORDERER_GENERAL_TLS_ENABLED=$enableTLS -v $raiz/$frontendId.frontend_material/:/bft-config/ bftsmart/fabric-frontend:amd64-1.3.0 $frontendId" &
done

for peerId in $peerIds; do
docker create -i -t --rm --network=bridge --name=$peerId.peer.ibm.bft -e FABRIC_CFG_PATH=/bft-config/fabric/ -v $raiz/$peerId.peer_material/:/bft-config/ -e CORE_PEER_TLS_ENABLED=$enableTLS -e CORE_PEER_TLS_CLIENTAUTHREQUIRED=$clientAuthRequired -v /var/run/:/var/run/ hyperledger/fabric-peer:amd64-1.3.0
docker network connect bft_network $peerId.peer.ibm.bft
mate-terminal -t $peerId.ibm.peer.bft -e "docker start -a $peerId.peer.ibm.bft" &
done

for idcli in $cliIds; do
mate-terminal -t $idcli.ibm.cli -e "docker run -i -t --rm --network=bft_network -e FABRIC_CFG_PATH=/bft-config/fabric/ -v /home/jose/fabric-orderingservice/docker_images/$idcli.cli_material/:/bft-config/ -e CORE_PEER_ADDRESS=0.peer.ibm.bft:7051 -e CORE_PEER_TLS_ENABLED=$enableTLS -e CORE_PEER_TLS_CLIENTAUTHREQUIRED=$clientAuthRequired bftsmart/fabric-tools:amd64-1.3.0" &
done
echo ""

