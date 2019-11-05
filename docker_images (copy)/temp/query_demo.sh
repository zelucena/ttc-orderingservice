
#!/bin/bash

if [ -f /tmp/query_demo ]; then {

	echo "This script already executed!"
	exit 0
}

fi

if [ -z $CORE_PEER_ADDRESS ] || [ $CORE_PEER_ADDRESS != bft.peer.1:7051 ]; then {

	echo "Please set \$CORE_PEER_ADDRESS to 'bft.peer.1:7051'"
	exit 0
}

fi

echo ""
echo "Fetching genesis block for channel47"
echo ""

peer channel fetch 0 ./channel47.block -c channel47 -o bft.frontend.2000:7050

echo ""
echo "Joining the peer to the channel"
echo ""

peer channel join -b channel47.block

echo ""
echo "Waiting 10 seconds for peer to fetch the ledger for channel channel47"
echo ""
sleep 10

echo ""
echo "Installing chaincode at the peer"
echo ""

peer chaincode install -n example02 -v 1.2 -p github.com/hyperledger/fabric/examples/chaincode/go/example02/cmd

echo ""
echo "Querying the chaincode"
echo ""

peer chaincode query -C channel47 -n example02 -c '{"Args":["query","a"]}'

echo ""
echo "Done!"
echo ""

touch /tmp/query_demo

