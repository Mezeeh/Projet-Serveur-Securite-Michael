#!/bin/bash

MAINTENANT=$(date +'%F')
DOSSIERSAUVEGARDE="/var/surveillance/$MAINTENANT"
FICHIERSAUVEGARDE="log-ssh.$(date +'%T').txt"

[ ! -d $DOSSIERSAUVEGARDE ] && mkdir -p ${DOSSIERSAUVEGARDE}

tail -n0 -f /var/log/auth.log | while read ligne
do
        if echo $ligne | grep Failed -i 
	then
		echo ----------------------------------------------------------------------- >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
                echo "Service : sshd" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
		echo "Anomalie : $(echo $ligne | cut -c40-54)" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
		echo "Date : $(echo $ligne | cut -c1-15)" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
		echo "IP : $(echo $ligne | cut -c72-83)" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
		echo ----------------------------------------------------------------------- >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
        fi

	if echo $ligne | grep Failure -i
	then
		echo ----------------------------------------------------------------------- >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
                echo "Service : sshd" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
                echo "Anomalie : $(echo $ligne | cut -c61-82)" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
		echo "Date : $(echo $ligne | cut -c1-15)" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
                echo "IP : $(echo $ligne | cut -c128-139)" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
                echo ----------------------------------------------------------------------- >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
	fi

	if echo $ligne | grep "Did not receive"
	then
		echo ----------------------------------------------------------------------- >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
		echo "Service : sshd" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
                echo "Anomalie : $(echo $ligne | cut -c41-78)" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
                echo "Date : $(echo $ligne | cut -c1-15)" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
                echo "IP : $(echo $ligne | cut -c85-96)" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
		echo ----------------------------------------------------------------------- >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
	fi
done

