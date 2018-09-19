#!/bin/bash
#USAGE: ./MAP_TO_IMG.sh {IMAGE_FILE} {FILE_TO_MAP}

$(xxd -p $2 > ./hex_tmp)
$(xxd -p $1 > ./img_hex)
$(mkdir ./Music)
#COUNTER=1
OPS=1
POS=2
CURRENT_LINE=1
EOF_LINE=$(wc -l < ./hex_tmp)
EOF_BYTE=$(tail -n1 ./hex_tmp | wc -c)

while true; do
	if [[ $OPS -lt 31 ]]; then
		if [[ $CURRENT_LINE == $EOF_LINE ]] && [[ $EOF_BYTE -lt $POS ]]; then
			break
		fi
	BYTE=$(head -n$CURRENT_LINE ./hex_tmp | tail -n1)
	PULL=$(echo $BYTE | head -c$POS | tail -c2)
	FIND=$(grep -b -o $PULL ./img_hex > ./positions)
	OFFSET=$(head -n1 ./positions | tail -n1 | cut -d":" -f1)
	OFFSET_HEX=$(printf %03X $OFFSET)
	FNAME=$(printf %02X $COUNTER)
	$(echo $OFFSET_HEX >> ./Music/Nuts.mp3)
		let OPS=OPS+1
		let POS=POS+2
#		let COUNTER=COUNTER+1
	else
		OPS=1
		POS=2
		let CURRENT_LINE=CURRENT_LINE+1
	fi
done
$(rm ./hex_tmp && rm ./img_hex && rm ./positions)

