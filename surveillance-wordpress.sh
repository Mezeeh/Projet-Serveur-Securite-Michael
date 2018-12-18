#!/bin/bash

DOSSIERSAUVEGARDE="/var/surveillance"
FICHIERSAUVEGARDE="/var/surveillance/log-wordpress.$(date +'%T').txt"

[ ! -d $DOSSIERSAUVEGARDE ] && mkdir -p ${DOSSIERSAUVEGARDE}

tail -n0 -f /var/log/apache2/access.log | while read ligne
do
	if echo $ligne | grep 'HTTP/1.1" 404' -i
	then
		echo ----------------------------------------------------------------------- >> $FICHIERSAUVEGARDE
                echo "Service : apache2" >> $FICHIERSAUVEGARDE
                echo "Anomalie : Erreur 404" >> $FICHIERSAUVEGARDE
                echo "Date : $(echo $ligne | cut -c18-45)" >> $FICHIERSAUVEGARDE
                echo "IP : $(echo $ligne | cut -c1-12)" >> $FICHIERSAUVEGARDE
                echo ----------------------------------------------------------------------- >> $FICHIERSAUVEGARDE
	fi

	if echo $ligne | grep 'HTTP/1.1" 302' -i
	then
		echo ----------------------------------------------------------------------- >> $FICHIERSAUVEGARDE
                echo "Service : apache2" >> $FICHIERSAUVEGARDE
                echo "Anomalie : Erreur 302" >> $FICHIERSAUVEGARDE
                echo "Date : $(echo $ligne | cut -c18-45)" >> $FICHIERSAUVEGARDE
                echo "IP : $(echo $ligne | cut -c1-12)" >> $FICHIERSAUVEGARDE
                echo ----------------------------------------------------------------------- >> $FICHIERSAUVEGARDE
	fi
done
