#!/bin/bash

function cd1(){
	cd ..
}

function cd2(){
	cd ../..
}

function cd3(){
	cd ../../..
}

#
# Convert Hexadecimal codes to ASCII
# printable caracters
#
function hex2a(){
	if [ -z $1 ] ; then
		echo "Usage: hex2a HEX_CODE"
	else
		echo -n " HEX($1) -> ASCII("
		echo -ne \\x$1
		echo -n ")"
		echo ""
	fi
}
