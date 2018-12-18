#!/bin/bash

DOSSIERSAUVEGARDE="/var/surveillance"
FICHIERSAUVEGARDE="/var/surveillance/log-ssh.$(date +'%T').txt"

[ ! -d $DOSSIERSAUVEGARDE ] && mkdir -p ${DOSSIERSAUVEGARDE}

tail -n0 -f /var/log/auth.log | while read ligne
do
        if echo $ligne | grep Failed -i 
	then
		echo ----------------------------------------------------------------------- >> $FICHIERSAUVEGARDE
                echo "Service : sshd" >> $FICHIERSAUVEGARDE
		echo "Anomalie : $(echo $ligne | cut -c40-54)" >> $FICHIERSAUVEGARDE
		echo "Date : $(echo $ligne | cut -c1-15)" >> $FICHIERSAUVEGARDE
		echo "IP : $(echo $ligne | cut -c72-83)" >> $FICHIERSAUVEGARDE
		echo ----------------------------------------------------------------------- >> $FICHIERSAUVEGARDE
        fi

	if echo $ligne | grep Failure -i
	then
		echo ----------------------------------------------------------------------- >> $FICHIERSAUVEGARDE
                echo "Service : sshd" >> $FICHIERSAUVEGARDE
                echo "Anomalie : $(echo $ligne | cut -c61-82)" >> $FICHIERSAUVEGARDE
		echo "Date : $(echo $ligne | cut -c1-15)" >> $FICHIERSAUVEGARDE
                echo "IP : $(echo $ligne | cut -c128-139)" >> $FICHIERSAUVEGARDE
                echo ----------------------------------------------------------------------- >> $FICHIERSAUVEGARDE
	fi

	if echo $ligne | grep "Did not receive"
	then
		echo ----------------------------------------------------------------------- >> $FICHIERSAUVEGARDE
		echo "Service : sshd" >> $FICHIERSAUVEGARDE
                echo "Anomalie : $(echo $ligne | cut -c41-78)" >> $FICHIERSAUVEGARDE
                echo "Date : $(echo $ligne | cut -c1-15)" >> $FICHIERSAUVEGARDE
                echo "IP : $(echo $ligne | cut -c85-96)" >> $FICHIERSAUVEGARDE
		echo ----------------------------------------------------------------------- >> $FICHIERSAUVEGARDE
	fi
done

