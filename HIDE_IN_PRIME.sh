#!/bin/bash
#Cr0wn_Gh0ul

#Save list of prime numbers in file ./Prime
#1 Prime number per line

KEY=$1

COUNT=1
COUNT2=0
$(touch ./tmp)

while true; do
if [[ $COUNT -lt 65 ]]; then
	PRIME=$(head -n$COUNT ./Prime | tail -n1)
	LAST_PRIME=$(head -n$COUNT2 ./Prime | tail -n1)
		if [[ $COUNT2 -eq 0 ]]; then
			PAD=$(echo $(( $PRIME - 1 )) )
		else
			PAD=$(echo $(( ($PRIME - $LAST_PRIME) - 1 )) )
		fi
	KBYTE=$(echo $KEY | head -c$COUNT | tail -c1)
		$(dd bs=1 count=$PAD if=/dev/urandom of=./tmp)
		$(cat ./tmp >> ./Hidden_Key)
		$(echo -n $KBYTE >> ./Hidden_Key)
	let COUNT=COUNT+1
	let COUNT2=COUNT2+1
else
	$(rm ./tmp)
	break
fi

continue
done
