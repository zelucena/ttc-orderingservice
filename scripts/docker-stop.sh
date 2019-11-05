#!/bin/bash
#derruba todas os containers docker em execução
sudo docker container stop $(sudo docker container ls -qa)
