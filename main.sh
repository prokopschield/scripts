#!/bin/sh

install_package() {
    local package=$1
    if ! command -v "$package" > /dev/null; then
        if ! apt-get install -y "$package"; then
            echo "Cannot install $package." >&2
            exit 1
        fi
    fi
}

## install curl
install_package curl

run() {
	url="https://raw.githubusercontent.com/prokopschield/scripts/master/$1.sh"

	echo "Running command: $1"
	
	if ! curl -fsSL "$url" | bash; then
		echo "Command failed: $1" >&2
	fi
}

for name in "$@"
do
	run "$name"
done
