echo "Nombre de lieux en 2016:" >> output.txt
cat output.txt
cat 2016/* | grep Location | wc -l >> output.txt
echo "Nombre de lieux en 2017:" >> output.txt
cat 2017/* | grep Location | wc -l >> output.txt
echo "Nombre de lieux en 2018:" >> output.txt
cat 2018/* | grep Location | wc -l >> output.txt
