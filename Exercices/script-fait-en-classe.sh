echo "argument donné : $1"

CHEMIN=$1

echo "Nombre de lieux en 2016:"
cat output.txt
cat 2016/* |grep location | wc -l
echo "Nombre de lieux en 2017 :"
cat 2017/* |grep location | wc -l
echo "Nombre de lieux en 2018 :"
cat 2018/* |grep location | wc -l
cat "$CHEMIN/2018/*" |grep location | wc -l
