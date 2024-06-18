#!/bin/sh

key="ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBInMlLBODDDVdUoc9pfA4Rc8alQSUbbPZFh65+DTO9uLCf5KroHCpbAtEkAmpd6Riyhzp7Q6zMTWDJwOvgn6IW4="
dir=~/.ssh
file="$dir/authorized_keys"

check() {
    $@

	local status=$?

    if [ $status -ne 0 ]; then
        echo "Command '$@' failed with exit status $status."
        exit $status
    fi
}

nlf() {
	if ! [ -f "$1" ]; then
		check touch "$1"
		return
	fi

	if [[ -n $(tail -c 1 "$1") ]]; then
		check echo "" >> "$1"
	fi
}

insert() {
	>>"$file" echo "$key"
}

if ! [ -d "$dir" ]; then
	check mkdir ~/.ssh;
fi

check nlf "$file";

grepped=$(grep "$key" "$file");

if ! [ -n "$grepped" ]; then
	check insert;
fi
