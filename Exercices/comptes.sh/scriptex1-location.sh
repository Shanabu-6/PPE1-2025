#!/usr/bin/bash

# Ce programme écrit son résultat sur la sortie std.
# > Ajouter ">> output-ex1.txt" pour rédiriger la sortie vers un fichier .txt


echo "Nombre de lieux mentionnés en 2016 :"
cat 2016/* | grep Location | wc -l

echo "Nombre de lieux mentionnés en 2017 : "
cat 2017/* | grep Location | wc -l

echo "Nombre de lieux mentionnés en 2018 : "
cat 2018/* | grep Location | wc -l
