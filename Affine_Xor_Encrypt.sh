#!/bin/bash

PRIVATE_KEY=$1
XOR_KEY=$2
A=5
B=8
M=16
COUNT=1
BYTE=2

AFFINE=$(while [[ $COUNT -lt 65 ]]; do
	CUR=$(echo -n $PRIVATE_KEY | head -c$COUNT | tail -c1)
	ENCODE=$(printf "%01x" $(( (($A*0x$CUR) + $B) % $M)) )		
	let COUNT=COUNT+1
	echo "$ENCODE"
	done)

ENCODED=$(echo $AFFINE | xargs | sed 's/ //g')
COUNT=1
XOR=$(while [[ $COUNT -lt 33 ]]; do
                K=$(echo $XOR_KEY | head -c$BYTE | tail -c2)
                Y=$(echo "$ENCODED" | head -c$BYTE | tail -c2)
                X=$(printf "%02x" $((16#$Y^16#$K)))
                let COUNT=COUNT+1
                let BYTE=BYTE+2
                echo "$X"
                done)
echo $(echo "$XOR" | xargs | sed 's/ //g')

