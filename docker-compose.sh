#!/bin/bash

install_docker() {
	url="https://raw.githubusercontent.com/prokopschield/scripts/master/docker.sh"
	
	if ! curl -fsSL "$url" | bash; then
		echo "Failed to install docker" >&2
        exit 1
	fi
}

# Check if docker command is installed
if ! command -v docker &> /dev/null
then
    install_docker
fi

# Replace `docker-compose` with `docker compose`
docker compose "$@"

# Exit with the status code of the last command
exit $?
