#!/bin/bash
asnfile="/root/.ascension/ascension.conf"
asnfolder="/root/.ascension"

#check if ascension config file was created yet
if [ -f "$asnfile" ]
then
	echo "Ascension config file found."
else
	echo "$asnfile not found, creating it!"
  mkdir "$asnfolder"
  echo -e "rpcuser=ascensionrpc\nrpcpassword=SomePassword" > "$asnfile"
fi

#start ascension daemon in background
echo "Starting ascension daemon..."
ascensiond -daemon
echo "It will take a few minutes for Ascension daemon to start, you may run \"tail -f ~/.ascension/debug.log\" to see what is going on."
echo "Run \"ascensiond getinfo\" or \"ascensiond help\" to get more information about Ascension blockchain"
echo "Type \"exit\" to quit docker container. Enjoy!"

#start bash now
/bin/bash
