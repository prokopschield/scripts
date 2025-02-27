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

## install unzip
install_package unzip

## install bun
if ! command -v "bun" > /dev/null; then
	if ! curl -fsSL https://bun.sh/install | bash; then
		echo Cannot install bun. >&2
		exit 2
	fi
fi

# install Node.js
if ! command -v "node" > /dev/null; then
	~/.bun/bin/bunx n lts
fi

