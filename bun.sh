#!/bin/sh

## install curl
if ! [ -n `which curl` ]; then
	if ! apt install curl -y; then
		echo Cannot install curl. >&2
		exit 1
	fi
fi

## install unzip
if ! [ -n `which unzip` ]; then
	if ! apt install unzip -y; then
		echo Cannot install unzip. >&2
		exit 1
	fi
fi

## install bun
if ! [ -n `which bun` ]; then
	if ! curl -fsSL https://bun.sh/install | bash; then
		echo Cannot install bun. >&2
		exit 2
	fi
fi
