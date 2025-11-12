#!/bin/bash

echo "<html><body><table border='1'>" > sortie.html

while IFS=$'\t' read -r a b c d e
do
  echo "<tr><td>$a</td><td>$b</td><td>$c</td><td>$d</td><td>$e</td></tr>" >> sortie.html
done < tableau.tsv

echo "</table></body></html>" >> sortie.html
