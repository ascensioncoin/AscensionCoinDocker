# AscensionCoinDocker

Docker that runs ascension coin daemon


## Prerequisites

install docker


## Build docker container

Run docker build from the folder that has Dockerfile to build a docker container with a tag "asn". It takes a few minutes.
```
docker build . -t asn
```


## Run docker container [easy way]

We want to retain the ascensioncoin blockchain data out of the docker container.
That's why we need to map some folder on the host filesystem (`/tmp/AscensionBlockchain` in this example) to `/root` folder inside docker.

Everything that you store inside the `/root` folder while running docker, will be retained.

```
docker run --rm -it -v /tmp/AscensionBlockchain:/root asn
```


## Run docker container [hard way, advanced]

You may want to skip automatically executing run.sh, which simplifies a few things for you. Execute this:
```
docker run --rm -it -v /tmp/AscensionBlockchain:/root --entrypoint /bin/bash asn
```

Use your favourite terminal program to issue commands to Ubuntu 14.04 running inside docker.

You need to execute `ascension -daemon` to start Ascension daemon. Ascension will store all blockchain data in `~/.ascension`  (or `/root/.ascension`). Note: folders that start with `.` are hidden folder in Linux. You will not see them if you just do `ls`... Execute `ls -a` to see hidden folders.

If you execute `ascension -daemon` for the first time, Ascension will complain if `~/.ascension/ascension.conf` does not exist (because it has RPC user login/password). Just create that file manually, for example `vi ~/.ascension/ascension.conf` and add contents similar to this:
```
rpcuser=ascensionrpc
rpcpassword=SomePassword
```


## Useful commands

`ascensiond getinfo` - get info about ascension blockchain

`ascensiond getaccountaddress ""` - get wallet address

`ascensiond listtransactions` - lists input/output transactions

`ascensiond help` - shows a list of other useful commands

`exit` - to exit from ascension Docker container
