#!/bin/sh

if [ "$#" -lt 2 ]; then
	echo "usage: $0 <ACM-Port> <package.zip>"
	exit 1
fi

nrfutil dfu usb-serial --package "$2" -p "$1"
