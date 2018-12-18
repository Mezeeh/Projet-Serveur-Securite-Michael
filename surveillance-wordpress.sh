#!/bin/bash

MAINTENANT=$(date +'%F')
DOSSIERSAUVEGARDE="/var/surveillance/$MAINTENANT"
FICHIERSAUVEGARDE="log-wordpress.$(date +'%T').txt"

[ ! -d $DOSSIERSAUVEGARDE ] && mkdir -p ${DOSSIERSAUVEGARDE}

tail -n0 -f /var/log/apache2/access.log | while read ligne
do
	if echo $ligne | grep 'HTTP/1.1" 404' -i
	then
		echo ----------------------------------------------------------------------- >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
                echo "Service : apache2" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
                echo "Anomalie : Erreur 404" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
                echo "Date : $(echo $ligne | cut -c18-45)" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
                echo "IP : $(echo $ligne | cut -c1-12)" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
                echo ----------------------------------------------------------------------- >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
	fi

	if echo $ligne | grep 'HTTP/1.1" 302' -i
	then
		echo ----------------------------------------------------------------------- >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
                echo "Service : apache2" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
                echo "Anomalie : Erreur 302" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
                echo "Date : $(echo $ligne | cut -c18-45)" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
                echo "IP : $(echo $ligne | cut -c1-12)" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
                echo ----------------------------------------------------------------------- >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
	fi
done
