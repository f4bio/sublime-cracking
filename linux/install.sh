#!/bin/bash

# setup
arch=$(uname -m)
exec=$(readlink $(which subl3))
fileDownload=$(mktemp)
fileCrack=$(mktemp)
fileChecksum=$(mktemp)

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root"
	exit 1
fi
echo "-> root: ok"

if [[ "$arch" == "x86_64" || "$arch" == "x86" ]]; then
	# safty first
	cp "$exec" "$exec.bak"
	if [[ $? -ne 0 ]]; then
		echo "error backing up '$exec'"
		exit $?
	fi
	echo "-> backup: ok"
	# download
	curl -sL --output "$fileDownload" https://db.tt/EH5QQIzK
	echo "-> download: ok"
	# unzip
	unzip -qp "$fileDownload" "sublime_text crack linux 64 build 3065" > "$fileCrack"
	echo "-> unzip: ok"
	# check for corruption
	echo "37a93e50bcdb034d2f40537d225f582c $fileCrack" > "$fileChecksum"
	md5sum -c "$fileChecksum" > /dev/null
	if [[ $? -ne 0 ]]; then
		echo "crack '$fileCrack' is corrupt..."
		exit $?
	fi
	echo "-> checksum: ok"
	cp "$fileCrack" "$exec"
	echo "-> copy: ok"
else
	echo "no such arch '$arch' (must be 'x86' or 'x86_64')"
	exit
fi
echo "--> done!"
