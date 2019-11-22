#!/bin/bash
raiz=/home/jose/fabric-orderingservice/docker_images
#id dos nodos participantes da rede
cliIds=$(seq 0 10)
nodeIds=$(seq 0 3)
peerIds=$(seq 0 1)
frontendIds=(1000 2000)

#cada participante da rede possui sua propria pasta de configuração, portanto as configurações devem ser replicadas a partir dos modelos
#assumindo que as informações são geradas do admin ibm, copiar o crypto-material, o genesisblock, os certificados e chaves-privadas.
########### copiar genesisblock do admin ibm 0 para todas as instâncias

#cli
for idcli in $cliIds; do
	cp $raiz/admin.0.cli_material/genesisblock $raiz/$idcli.cli_material/genesisblock;
done

#nodes
for idnode in $nodeIds; do
	cp $raiz/admin.0.cli_material/genesisblock $raiz/$idnode.node_material/genesisblock;
done

#frontend
for idfrontend in ${frontendIds[@]}; do
cp $raiz/admin.0.cli_material/genesisblock $raiz/$idfrontend.frontend_material/genesisblock
done


########### copiar crypto-material
#admin
rm -R -f $raiz/admin.0.cli_material/fabric/msp/keystore/
cp -a $raiz/admin.0.cli_material/crypto-config/peerOrganizations/ibm.bft/users/Admin@ibm.bft/. $raiz/admin.0.cli_material/fabric/

#clients
for idcli in $cliIds; do
((userid = $idcli + 1))
rm -R -f $raiz/$idcli.cli_material/fabric/msp/keystore/
cp -a $raiz/admin.0.cli_material/crypto-config/peerOrganizations/ibm.bft/users/User$userid@ibm.bft/. $raiz/$idcli.cli_material/fabric/
done

#peers
for idpeer in $peerIds; do
rm -R -f $raiz/$idpeer.peer_material/fabric/msp/keystore/
rsync -av --exclude='msp/config.yaml' $raiz/admin.0.cli_material/crypto-config/peerOrganizations/ibm.bft/peers/$idpeer.peer.ibm.bft/ $raiz/$idpeer.peer_material/fabric/
done

#frontend
for idfrontend in ${frontendIds[@]}; do
rm -R -f $raiz/$idfrontend.frontend_material/fabric/msp/keystore/
rm -R -f $raiz/$idfrontend.frontend_material/config/keys/
cp -a $raiz/admin.0.cli_material/crypto-config/ordererOrganizations/frontend.bft/orderers/$idfrontend.frontend.bft/. $raiz/$idfrontend.frontend_material/fabric/
done

#nodes
for idnode in $nodeIds; do
	rm -R -f $raiz/$idnode.node_material/msp/keystore/
	rm -R -f $raiz/$idnode.node_material/config/keys/
	cp -a $raiz/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/$idnode.node.bft/. $raiz/$idnode.node_material/
done

########### copiar assinaturas (nodos, frontends)
# copiar todos os certificados para a pasta dos nodos e frontend, renomeando para nodos / frontends para cert<id>.pem. Replicar a pasta inteira com os certificados. A diferença é que em cada pasta a chave privada é individual do nodo / frontend correspondete;

#frontend e nodes
for idfrontend in ${frontendIds[@]}; do
##copiar o certificado dos nodes
	mkdir -p $raiz/$idfrontend.frontend_material/config/keys/
	for idnode in $nodeIds; do
		cp $raiz/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/$idnode.node.bft/msp/signcerts/$idnode.node.bft-cert.pem $raiz/$idfrontend.frontend_material/config/keys/cert$idnode.pem
	done
##copiar o certificado dos frontends
	for innerfrontend in ${frontendIds[@]}; do
		cp $raiz/admin.0.cli_material/crypto-config/ordererOrganizations/frontend.bft/orderers/$innerfrontend.frontend.bft/msp/signcerts/$innerfrontend.frontend.bft-cert.pem $raiz/$idfrontend.frontend_material/config/keys/cert$innerfrontend.pem
	done
##copiar chave privada
	cp -a $raiz/admin.0.cli_material/crypto-config/ordererOrganizations/frontend.bft/orderers/$idfrontend.frontend.bft/msp/keystore/. $raiz/$idfrontend.frontend_material/config/keys/
	mv $raiz/$idfrontend.frontend_material/config/keys/$(ls $raiz/$idfrontend.frontend_material/config/keys/ | grep _sk) $raiz/$idfrontend.frontend_material/config/keys/keystore.pem
done

#nodes
for idnode in $nodeIds; do
#copiar as configuracoes do primeiro frontend
	cp -a $raiz/${frontendIds[0]}.frontend_material/config/keys/ $raiz/$idnode.node_material/config/keys/
#copiar a chave privada
	rm -f $raiz/$idnode.node_material/config/keys/keystore.pem
	cp -a $raiz/admin.0.cli_material/crypto-config/ordererOrganizations/node.bft/orderers/$idnode.node.bft/msp/keystore/. $raiz/$idnode.node_material/config/keys/
#renomear arquivo movendo com o nome keystore.pem
	mv $raiz/$idnode.node_material/config/keys/$(ls $raiz/$idnode.node_material/config/keys/ | grep _sk) $raiz/$idnode.node_material/config/keys/keystore.pem
done
