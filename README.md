# DockerGeth
Dockerfiles and resources for creating a private ethereum network with Docker. Using Docker's features such as swarm and services, we can automate the setup of multiple geth instances for use in a public network. Docker ensures that our Ethereum nodes and miners scale accross multpiple machines in the swarm. 

Completed as part of the Experience Ethereum research project at Lunds Tekniska Högskola.

## Installation
You will need:
* A copy of Docker CE
* A clone of this repository
* Geth

## How to Use
Right now there is a good amount of work that needs to be done to get up and running. However, this could be easily put in a script in the future for quick setup.

1. Run ```bootnode -genkey bootnode.key``` to generate a key and put it in the datadirs folder.
2. Using docker run a container based of the image geth-manager. Check the address that it gives your for the bootnode it should be in the form: ```enode://xxxxxxxxxxxxxx@127.0.0.1:8500```.
3. Generate a password for the EthNetstats API.
4. In all scripts found in the datadirs directory replace the pieces flagged with triple exclamation points with information you just created.
5. Now you can simply run the command ```docker stack deploy --compose-file=docker-compose-geth.yml LTHBlockchain``` to deploy the network. You probably will also want to run ```docker stack deploy --compose-file=docker-compose-portainer.yml Portainer``` for the Portainer GUI. 
6. Deploy the stack to a swarm to have it be automatically distributed across swarm workers. You can scale at runtime with the normal docker service scale methods.

## Devleopment
If changing anything in the Dockerfiles, you can rebuild and push all the images to the local registry with the buildPushAll.sh script. 

## TODO
* Script out initial setup
* Abstract variables to docker run environment variables
* Publish images on DockerHub 
* Make a detailed wiki

Note: This repository is a copy of a private implementation so there is limited commit history.
