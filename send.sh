#!/bin/bash

PDF_DIR=./PDF
PDF_FILE=pg_*.pdf
PDF_FILES="$PDF_DIR/$PDF_FILE"

MAIL_SUBJECT="Platna lista"
MAIL_FROM="noreply@irb.hr"
MAIL_BODY="Platna lista u privitku\n\n--Ovo je racunalno generirana poruka, molimo da ne odgovarate na nju."


for FILE in $PDF_FILES
do
	TIME=`/bin/date +%Y-%m-%dT%H:%M:%S`
	MAIL=''
	OIB=`pdftotext $FILE - | grep -Po 'OIB:\s[0-9]{11}\s' | cut -d' ' -f2`

	echo "$TIME - Obrađujem datoteku: $FILE"
	
	if [ ! -z "$OIB" -a "$OIB" != " " ]; # OIB is not null or space
	then
		MAIL=`ldapsearch -x -H ldap://ldap.irb.hr -b dc=irb,dc=hr hrEduPersonOIB=$OIB mail | grep -e '^mail:' | cut -d ' ' -f2`
		
		if [ ! -z "$OIB" -a "$OIB" != " " ]; # OIB is not null or space
		then
			echo "$TIME - Pronađena je E-mail adresa za OIB: $OIB i glasi: $MAIL"

			#mail -s "$MAIL_SUBJECT" -r "$MAIL_FROM" $FILE "$MAIL" <<< "$MAIL_BODY"
			echo "$MAIL_BODY" | mutt -a "$FILE" -s "$MAIL_SUBJECT" -- $MAIL


		else
			echo "$TIME - Nije pronađena E-mail adresa za osobu s OIB-om: $OIB"
		fi

	else
		echo "$TIME - U datoteci $FILE nije pronađen OIB."
	fi

	sleep 1
done
