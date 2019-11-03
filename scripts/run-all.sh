#!/bin/bash
gnome-terminal  -e ./node0.sh
sleep 5
gnome-terminal  -e ./node1.sh
sleep 5
gnome-terminal  -e ./node2.sh
sleep 5
gnome-terminal  -e ./node3.sh
sleep 5

gnome-terminal  -e ./peer0.sh
gnome-terminal  -e ./peer1.sh
gnome-terminal  -e ./peer2.sh
gnome-terminal  -e ./peer3.sh

gnome-terminal  -e ./frontend1000.sh 
gnome-terminal  -e ./frontend2000.sh 

gnome-terminal  -e ./client0.sh 
gnome-terminal  -e ./client1.sh
