#!/bin/bash

ENCODED=$1
XOR_KEY=$2
##Affine Settings Here
A=13
B=8
M=16
##
COUNT=1
BYTE=2
XOR=$(while [[ $COUNT -lt 33 ]]; do
                K=$(echo $XOR_KEY | head -c$BYTE | tail -c2)
                Y=$(echo "$ENCODED" | head -c$BYTE | tail -c2)
                X=$(printf "%02X" $((16#$Y^16#$K)))
                let COUNT=COUNT+1
                let BYTE=BYTE+2
                echo "$X"
                done)

PRIVATE_KEY=$(echo $(echo "$XOR" | xargs | sed 's/ //g'))
COUNT=1
AFFINE=$(while [[ $COUNT -lt 65 ]]; do
        CUR=$(echo -n $PRIVATE_KEY | head -c$COUNT | tail -c1)
        ENCODED=$(printf "%d" $((0x$CUR)) )
	NEG_TEST=$(echo $(($A * ($ENCODED - $B) % 16)) )
	if [[ $NEG_TEST -ge 0 ]]; then
		DECODE=$(printf "%01x" $(($A * ($ENCODED - $B) % $M )) )
	else
		NUM=$(echo $(($NEG_TEST * -1)) )
                MOD=$(echo $M)
		LOW=$(echo $(($NUM / $MOD)) )
                HIGH=$(echo $(($LOW + 1)) )
                DECODE=$(printf "%01x" $(( ($HIGH * $MOD) - $NUM )) )
	fi
	let COUNT=COUNT+1
        echo "$DECODE"
        done)

echo $(echo $AFFINE | xargs | sed 's/ //g')
