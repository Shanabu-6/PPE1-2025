#!/bin/bash

URLS=$1
compteur=0

if [ $# -eq 0 ]; then
    echo "Erreur"
    exit 1
fi

while read -r line; do

    code_http=$(curl -s -o /dev/null -w "%{http_code}" "$line")
if [[ "$code_http" -ge 400 ]]; then
    status="Erreur $code_http"
else
    status="$code_http"
fi

    encodage=$(curl -sI "$line" | grep -i "Content-Type" | sed -n 's/.*charset=\([^ ;]*\).*/\1/p' | tr -d '\r\n')
    if [ -z "$encodage" ]; then
        encodage="inconnu"
    fi
    contenu=$(curl -s "$line")
    nb_mots=$(echo "$contenu" | sed 's/<[^>]*>//g' | wc -w)
    echo -e "${compteur}\t${line}\t${code_http}\t${encodage}\t${nb_mots}" >> tableau.tsv
    compteur=$((compteur + 1))
done < "$URLS"
