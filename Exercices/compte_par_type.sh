#!/usr/bin/bash

echo "Nb d'entités données en argument du programme (Location, Person, Organization, etc.) pour les trois années:"
grep '^T[0-9]\+' 201*/* | cut -f2 | cut -d' ' -f1 | wc -l
