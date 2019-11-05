
#!/bin/bash

if [ -f /tmp/invoke_done ]; then {

	echo "This script already executed!"
	exit 0
}

fi

if [ -z $CORE_PEER_ADDRESS ] || [ $CORE_PEER_ADDRESS != bft.peer.0:7051 ]; then {

	echo "Please set \$CORE_PEER_ADDRESS to 'bft.peer.0:7051'"
	exit 0
}

fi

echo ""
echo "Creating artifacts for channel bftchannel"
echo ""

configtxgen -profile SampleSingleMSPChannel -outputCreateChannelTx channel.tx -channelID channel47
configtxgen -profile SampleSingleMSPChannel -outputAnchorPeersUpdate anchor.tx -channelID channel47 -asOrg SampleOrg

echo ""
echo "Creating bftchannel and updating its anchor peer"
echo ""

peer channel create -o bft.frontend.1000:7050 -c channel47 -f channel.tx
peer channel update -o bft.frontend.1000:7050 -c channel47 -f anchor.tx

echo ""
echo "Joining the peer to the channel"
echo ""

peer channel join -b channel47.block

echo ""
echo "Waiting 10 seconds for peer to fetch the ledger for channel channel47"
echo ""
sleep 10

echo ""
echo "Installing and instantiating chaincode at the peer"
echo ""

peer chaincode install -n example02 -v 1.2 -p github.com/hyperledger/fabric/examples/chaincode/go/example02/cmd
peer chaincode instantiate -o bft.frontend.1000:7050 -C channel47 -n example02 -v 1.2 -c '{"Args":["init","a","100","b","200"]}'

echo ""
echo "Waiting 10 seconds for peer to receive the new block and instantiate chaincode"
echo ""
sleep 10

echo ""
echo "Querying the chaincode"
echo ""

peer chaincode query -C channel47 -n example02 -c '{"Args":["query","a"]}'

echo ""
echo "Issuing invocation on the chaincode"
echo ""

peer chaincode invoke -C channel47 -n example02 -c '{"Args":["invoke","a","b","10"]}'

echo ""
echo "Waiting 10 seconds for peer to receive the new block and update its state"
echo ""
sleep 10

echo ""
echo "Querying the chaincode again"
echo ""

peer chaincode query -C channel47 -n example02 -c '{"Args":["query","a"]}'

echo ""
echo "Done!"
echo ""

touch /tmp/invoke_done

