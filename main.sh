#!/bin/sh

## install curl
if ! [ -n `which curl` ]; then
	if ! apt install curl -y; then
		echo Cannot install curl. >&2
		exit 1
	fi
fi

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
