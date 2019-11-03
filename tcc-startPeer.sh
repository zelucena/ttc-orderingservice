sudo docker create -i -t --rm --network=bridge --name=0.peer.ibm.bft -e FABRIC_CFG_PATH=/bft-config/fabric/ -v /home/jose/fabric-orderingservice/docker_images/0.peer_material/:/bft-config/ -v /var/run/:/var/run hyperledger/fabric-peer:amd64-1.3.0;
sudo docker network connect bft_network 0.peer.ibm.bft;
sudo docker start -a 0.peer.ibm.bft;
