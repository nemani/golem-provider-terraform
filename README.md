#  Golem Provider Multiple Nodes + Monitoring Terraform Setup

> Project submited to the [Hack New Golem](https://gitcoin.co/issue/golemfactory/hackathons/6/100024411) bounties.
> 

## :link: Links

- [Node-Golem Github Repository](https://github.com/alexandre-abrioux/golem-node)
- [Node-Golem DockerHub Respository](https://hub.docker.com/r/aabrioux/golem-node)
- [Golem Network > Website](https://golem.network/)
- [Golem Network > Provider Node Documentation](https://handbook.golem.network/provider-tutorials/provider-tutorial)

## :arrow_forward: Usage

You can clone this repository or use the provided `docker-compose.yml` as a base template for your own setup.

A `Makefile` is included for convenience but `make` is not required to run the node.

Use `make` or `make help` to list the available shortcuts.

### 1. First Start

Use `make golem-setup` to run the node for the first time.

The CLI will ask you a few questions: refer to the [Provider Node Documentation > Initial Setup](https://handbook.golem.network/provider-tutorials/provider-tutorial#initial-setup) for more details.

The node settings will be kept on your host in a `./data-node` repository.

### 2. Run the Node

Use `make up` to start the node and prometheus services in a detached mode.

You can access the logs for all at any time by running `make logs`.

You can access the logs for golem at any time by running `make golem-logs`.

Use `make golem-status` to get your node address and health.


### 3. Running Only Prometheus

Use `make prometheus` to start the prometheus services in a detached mode.

You can access the logs at any time by running `make logs`


### 4. Running using terraform + hetzner 

Create API token by signing up and registering on https://console.hetzner.cloud/projects

Add SSH key to the project with the name "golem-provider-terraform"

## Donation :beer:

If you find this template useful you may consider the option of offering me a beer through a donation. Support is very appreciated :slightly_smiling_face: 

ETH / ERC20 Token: nemani.eth

You should also consider donating to the creator of the [docker-image](https://github.com/alexandre-abrioux/golem-node)
