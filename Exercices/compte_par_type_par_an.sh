#!/usr/bin/bash

# Ce script compte le nombre d'entités donnés en argument du programme (Location, Person, Organization, etc.) pour chaque année. Son résultat est simplement un nombre.
# J'ai cherché un moyen de ne pas uniquement prendre les entités "Location, Person, etc.", mais créer un script qui puisse restranscrire à chaque fois la seconde colonne.


echo "Nb d'entités donnés en argument du programme (Location, Person, Organization, etc.) pour l'année 2016 :"
grep '^T[0-9]\+' 2016/* | cut -f2 | cut -d' ' -f1 | wc -l #>> nbEntites.txt

# Avec une regex, on identifie la première colonne de chaque fichiers, qui commence toujours par T*. La commande cut -f2 isole la deuxième colonne (où se trouve toutes les entités voulues), cut -d' ' -f1 isole le premier mot de cette 2e colonne (au cas où s'il y a deux mots sur la même colonne). Le résultat obtenu est la liste de toutes les entités ; avec la commande wc, on compte chaque apparition textuelle, que l'on redirige vers une sortie fichier.
echo " "
echo "Dont :"
grep '^T[0-9]\+' 2016/* | cut -f2 | cut -d' ' -f1 | sort | uniq -c          # ce script permet d'afficher tout d'abord la liste dans ordre alphabétique (sort) + ensuite regrouper les lignes consécutives de même occurence (uniq -c), l'option -c signigie count, donc compte le nb d'occurence de chaque.
echo " "



echo "Nb d'entités donnés en argument du programme (Location, Person, Organization, etc.) pour l'année 2017 :"
grep '^T[0-9]\+' 2017/* | cut -f2 | cut -d' ' -f1 | wc -l
echo " "
echo "Dont :"
grep '^T[0-9]\+' 2017/* | cut -f2 | cut -d' ' -f1 | sort | uniq -c
echo " "


echo "Nb d'entités donnés en argument du programme (Location, Person, Organization, etc.) pour l'année 2017 :"
grep '^T[0-9]\+' 2018/* | cut -f2 | cut -d' ' -f1 | wc -l
echo " "
echo "Dont :"
grep '^T[0-9]\+' 2018/* | cut -f2 | cut -d' ' -f1 | sort | uniq -c
echo " "
