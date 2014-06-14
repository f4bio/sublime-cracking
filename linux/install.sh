#!/bin/bash

arch=$(uname -m)
exec=$(readlink $(which subl3))

cp "$exec" "$exec.bak"

if [[ "$arch" == "x86" || "$arch" == "x86_64" ]]; then
	wget -O /tmp/sublime_text_linux_sled2_"$arch" http://n3th.fftt.info/files/sublime-cracking/linux/sublime_text_linux_sled2_"$arch"
	wget -O /tmp/sublime_text_linux_sled2_"$arch".sha1 http://n3th.fftt.info/files/sublime-cracking/linux/sublime_text_linux_sled2_"$arch".sha1

	cd /tmp
	sha1sum -c "sublime_text_linux_sled2_$arch.sha1"

	if [[ $? == 0 ]]; then
		cp "sublime_text_linux_sled2_$arch" "$exec"
	else
		echo "file 'sublime_text_linux_sled2_$arch' is corrupt..."
	fi
else 
	echo "no such arch '$arch' (must be 'x86' or 'x86_64')"
	exit
fi
echo "done!"