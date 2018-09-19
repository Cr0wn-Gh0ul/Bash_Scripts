#!/bin/bash
#USAGE: ./EXTRACT_IMG_MAP.sh {OFFSET_FILE} {IMAGE_FILE}

$(xxd -p $2 > ./img_hex)
COUNT=1
EOF=$(wc -l $1 | cut -d" " -f1)

while true; do

	if [[ $COUNT -gt $EOF ]]; then
		break	
	fi
OFFSET=$(echo $((16#$(head -n$COUNT $1 | tail -n1))))
$(dd bs=1 skip=$OFFSET count=2 if=./img_hex of=./EXTRACTED 2> /dev/null)
$(cat ./EXTRACTED >> ./extracted_hex)
let COUNT=COUNT+1
continue
done

$(cat ./extracted_hex | sed 's/ //g' > ./tmp)
$(xxd -r -p ./tmp > ./extracted_file)
$(rm ./EXTRACTED && rm ./extracted_hex && rm ./tmp && rm ./img_hex)
