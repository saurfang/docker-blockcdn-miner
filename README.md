# BlockCDN Miner (MBerry Miner) on Docker

Run the [BlockCDN Miner](https://github.com/Blockcdnteam/Minner) in a Docker container.

## Prerequisites

1. Install [Docker](https://www.docker.com/community-edition#/download).

## Running

BlockerCDN miner serves the CDN and collect mining rewards.

```sh
docker run -d --restart=always -e MINER_CODE='<your mining code>' --name blockcdn-miner saurfang/blockcdn-miner
```

Note you need to fill in your miner code in order for the miner to register with the network.

`restart` is recommended as `bcdn` exits upon network disruption or unstableness, which brings down the container.

To check the status your miner:

```sh
docker ps
```

You can see the logs by:

```sh
docker logs -f blockcdn-miner
```

## DATADIR

Miner reward is determined both by network bandwidth and disk capacity.

TODO: Figure out the mechanism of how disk capacity is determined and 
associate it with a volume so data can be persisted and the space can be properly measured.

## Building It Yourself

1. Follow Prerequisites above.
2. Checkout source: `git clone https://github.com/saurfang/docker-blockcdn-miner.git && cd docker-blockcdn-miner`
3. Build container: `docker build -t $(whoami)/blockcdn-miner .`
4. Run container: `docker run -d -e MINER_CIDE='[your miner code]' $(whoami)/blockcdn-miner`
