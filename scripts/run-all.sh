#!/bin/bash
mate-terminal -t 0.node.bft -e ./node0.sh
sleep 5
mate-terminal -t 1.node.bft -e ./node1.sh
sleep 5
mate-terminal -t 2.node.bft -e ./node2.sh
sleep 5
mate-terminal -t 3.node.bft -e ./node3.sh
sleep 5

mate-terminal -t 0.ibm.peer.bft -e ./peer0.sh
mate-terminal -t 1.ibm.peer.bft -e ./peer1.sh
mate-terminal -t 0.lasige.peer.bft -e ./peer2.sh
mate-terminal -t 1.lasige.peer.bft -e ./peer3.sh

mate-terminal -t 1000.frontend.bft -e ./frontend1000.sh 
mate-terminal -t 1000.frontend.bft -e ./frontend2000.sh 

mate-terminal -t 0.ibm.cli -e ./client0.sh 
mate-terminal -t 0.lasige.cli -e ./client1.sh
mate-terminal -t 0.ibm.admin -e ./admin0.sh 
