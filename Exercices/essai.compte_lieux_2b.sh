#!/usr/bin/bash

CHEMIN=$1
ANNEE=$2
#MOIS = $3
#NB_LIEUX = $3

#cat $CHEMIN/$ANNEE/* | cut -f5  >> lieux.txt

cat $CHEMIN/$ANNEE/* | awk '{ if ($2 == "Location") print $5 }' | sort | uniq -c > lieux.txt

#cat #lire contenu
#tail #fin fichier
#cut #selectionne colonne
#sort #trier les lignes (alphabetiq)
#uniq #supprimer les lignes qui se répétent
#grep #
