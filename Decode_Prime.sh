COUNT=1
while true; do

if [[ $COUNT -lt 65 ]]; then
	PRIME=$(head -n$COUNT ./Prime | tail -n1)
	PAD=$(echo $(( $PRIME - 1 )) )
	$(dd bs=1 skip=$PAD if=Hidden_Key of=testing 2>/dev/null)
	KEY=$(cat ./testing | head -c1)
	echo $(echo -n $KEY)
	let COUNT=COUNT+1
else
	break
fi
continue
done
