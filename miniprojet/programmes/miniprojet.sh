#!/bin/bash
#Ligne de commande = bash programmes/miniprojet.sh urls/fr.txt >> tableaux/tableau-fr.tsv

numligne=0 #compteur qui permet d'afficher numéro de ligne devant url


if [ $# -ne 1 ] ; then
    echo "ce programme nécessite un argument"
        exit
fi

FICHIER_URLS=$1    #en argument 1 le nom du fichier à traiter

if [ ! -f "$FICHIER_URLS" ]; then
    echo "Erreur : le fichier `$FICHIER_URLS` n'a pas été trouvé"
    exit 1
fi

	#traitement de chaque ligne : si url semble OK == continuer ; sinon, afficher "non valide".
while read -r LINE ; do
	[ -z "$LINE" ] && continue
	((numligne++)) #incrémentation du nb de lignes.

	code_http=$(curl -s -o /dev/null -w "%{http_code}" "$LINE") #silencieux ; output ; dev/null = fichier spécial aspire+jeté ensuite ; write out - regex code HTTP.

	contenu_page=$(curl -s "$LINE")
	nb_mots=$(echo "$contenu_page" | sed 's/<[^>]*>//g' | wc -w)
	encodage=$(curl -sI "$LINE" | grep -i "Content-Type" | sed -n 's/.*charset=\([^ ;]*\).*/\1/p')
	if [ -z "$encodage" ]; then
        encodage="inconnu"
	fi


	#Affichage finale
	if [[ $LINE =~ ^(https?://)?[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/.*)?$ ]]; then
		echo -e  "$numligne\t$LINE\t$code_http\t$nb_mots\t$encodage"
	else
		echo -e "$numligne\turl non valide : $LINE"
	fi

done < "$FICHIER_URLS"
