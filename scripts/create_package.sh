#!/bin/sh

if [ "$#" -lt 2 ]; then
	echo "usage: $0 <application.hex> <output.zip>"
	exit 1
fi

nrfutil pkg generate \
	--application "$1" \
	--application-version-string 0.0.1 \
	--hw-version 52 \
	--sd-req 0x100,0xCAFE \
	--key-file private-key.pem \
	"$2"
