#!/bin/bash
#Outputs to {File}.xor

KEY=$1
OPS=1
POS=2
CURRENT_LINE=1
EOF_LINE=$(wc -l < $1)
EOF_BYTE=$(tail -n1 $1 | wc -c)
b=""
ar=()
        while read -r b ; do
        b=$b
	ENC=$(while [[ $OPS -lt 33 ]]; do
	if [[ $CURRENT_LINE == $EOF_LINE ]] && [[ $EOF_BYTE -lt $POS ]]; then
		break
	fi
		K=$(echo "$KEY" | head -c$POS | tail -c2)
		B=$(echo $b | head -c$POS | tail -c2)
                X=$(printf "%02X" $((16#$B^16#$K)))
		let OPS=OPS+1
		let POS=POS+2
		echo "$X"
		done)
	ar+=$(echo $(echo $ENC | sed 's/ //g') >> ./$1.xor)
	let CURRENT_LINE=CURRENT_LINE+1
        done < $1


