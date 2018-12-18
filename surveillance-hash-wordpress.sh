#!/bin/bash

MAINTENANT=$(date +"%F")
DOSSIERSAUVEGARDE="/var/surveillance/$MAINTENANT"
FICHIERSAUVEGARDE="log-hash-wordpress.$(date +'%T').txt"
DOSSIERWORDPRESS="/var/www/html/turcotte/"

[ ! -d $DOSSIERSAUVEGARDE ] && mkdir -p ${DOSSIERSAUVEGARDE}

ANCIENTHASH=$(head -1 ./hash-wordpress.txt | tail -1)
NOUVEAUHASH=$(find ${DOSSIERWORDPRESS} -type f -exec md5sum {} \; | sort -k 2 | md5sum)

ANCIENNETAILLE=$(head -n 2 ./hash-wordpress.txt | tail -1)
NOUVELLETAILLE=$(du -sh $DOSSIERWORDPRESS | cut -f1)

if [ "$NOUVEAUHASH" != "$ANCIENTHASH" ]
then
	echo ----------------------------------------------------------------------- >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
	echo "Une modification a ete faite aux fichiers Wordpress"  >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
	echo ----------------------------------------------------------------------- >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
	echo "minute : $(date +'%c')" >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
	echo "md5 avant : $ANCIENTHASH"  >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
	echo "md5 apres : $NOUVEAUHASH"  >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
	echo "taille avant : $ANCIENNETAILLE"  >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
	echo "taille apres : $NOUVELLETAILLE"  >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
	echo "journal systeme :"  >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
	echo ----------------------------------------------------------------------- >> ${DOSSIERSAUVEGARDE}/${FICHIERSAUVEGARDE}
fi
