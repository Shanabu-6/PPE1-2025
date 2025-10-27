# Journal de bord Projet Encadré M1 2025/26, cours PPE1

## Un journal ?
##### ***Écrit au fur et à mesure des séances du cours "Projet programmation encadré", ce journal se veut être un témoignage de mes avancées personnelles, de mes tâtonnements face aux différents exercices.***

**[Pour l'instant, la rédaction n'en est qu'au stade d'ébauche]**

### **> 22 septembre 2025 : la première séance !**

- Groupe formé avec deux autres étudiant.e.s de Paris Nanterre et Inalco.
- Je suis impatient de commencer.
- J'avais déjà un peu, au cours de l'été, expérimenté le fonctionnement du terminal et de bash.
- J'ai installé quelques modules, obligatoires (jupyter-lab, homebrew), et plus accessoires (fish pour personnaliser le shell, colorer notamment les commandes bash sur le terminal, enregistrer en mémoire les chemins récurrents, tel que "cd Documents/SCOLAIRE/master_TAL/")
- J'ai beaucoup apprécié la partie du cours sur l'histoire des logiciels libres, sur la programmation commune et open-source [je regrette un peu de ne pas être sous Linux]. J'ai d'ailleurs bien noté la bibliographie du cours, et espère avoir un peu de temps pour m'y plonger. 


 **>Comment organiser et prendre ses notes ?**

En discutant avec une camarade, j'ai découvert l'application "Obsidian", qui permet de mettre en commun toutes ses notes, documents, outils, ressources, au sein d'un même espace, au format markdown. Cela permet de créer un "second cerveau", une sorte d'encyclopédie numérique personnelle, d'ailleurs visualisable sous la forme de nuages de points, afin de mieux se rendre compte des interconnexions entre des sujets en apparence éloignés. J'ai décidé d'alimenter mon journal de bord depuis Obsidian, et y regrouper toutes mes trouvailles, mes recherches au cours de ce master. 


### **> 29 septembre 2025 : Avant la séance 2 :** 

-> j'ai revu la partie du cours à propos des chemins absolus et relatifs. Y-a-t-il un moyen d'aller directement dans un dossier sans faire tout le chemin ? 

- J'ai regardé cette vidéo : https://www.youtube.com/watch?v=QFA0VKrQ3zk

- J'ai finalisé la clé et l'ai déposé sur Git de mon côté. J'ai créé un alias git. 
j'ai revu les wildcards

- Installation de wget depuis Homebrew, pour télécharger le .zip.


### **> 6 octobre 2025 ; Avant la séance 3 :**

- Maj de ce journal de bord.

  ###  **> 8 octobre 2025 ; séance 3 :**


###  **> 15 octobre 2025 ; séance 4 :**


###  **> 22 octobre 2025 ; séance 5 :**
(absent)



###  **> 27 octobre 2025 ; miniprojet :


**Exercice 1 : lire les lignes d’un fichier en bash** :

Questions :
1. Pourquoi ne pas utiliser cat ?

```
while read -r line;
do
echo ${line};
done < "urls/fr.txt";
```

Le code ci-dessus permet de lire un fichier ligne par ligne en bash - dans notre exercice, ce fichier est une liste d'url.
On remarquera l'utilisation de la boucle "while" : les instructions doivent être répétées tant qu'une condition donnée est vraie. 
Dans notre cas, tant que la commande `read -r line`réussit à lire une ligne depuis le fichier, alors on exécute `echo`.


2. Comment transformer "urls/fr.txt" en paramètre du script ?

Dans notre code, la ligne "urls/fr.txt" correspond au chemin relatif du fichier "fr.txt" par rapport à l'emplacement de l'exécution du scrip, dans le sous-fichier "url" ; en effet, l'emplacement de travail princiapl se situe dans le fichier "miniprojet".

Mais dans notre code, cette ligne est écrite en "dur" ; c'est une valeur fixe dans le code du script. Si l'on souhaite que notre code soit plus "agile" et puisse être adapté à la situation, nous devons remplacer ce nom de fichier par un argument, rentré directement dans la ligne de commande su shell. 

Ainsi, notre objectif, exécuter le script comme ceci :

```bash
./notre_script urls/fr.txt
```

Pour réaliser ceci, il suffit de procéder à quelques modifications. 

- Premièrement, nous devons inviter l'utilisateur.trice à renter un argument. En utilisant l'instruction conditionnelle `if`, nous allons "contrôler" la présence ou non d'un argument lors de l'exécution du programme.

**En pseudo-code** :

```
si présence argument != OUI
    alors
       afficher "besoin d'un argument"
        stop
```

**Ce qui donnera en bash** :
  
```bash
if [ $# -ne 1] ; then
    echo "ce programme nécessite un argument"
        exit
fi
```

- Une fois cela fait, il est maintenant nécessaire de prendre en compte cet argument, et de le réutiliser. Pour cela, nous stoquerons le chemin du fichier, rentré à l'instant en argument, dans une variable.

```bash
FICHIER_URLS=$1
```

Que signigie $1 ? Le $ précise l'argument, et "1" sa position. L'appel du script étant au rang 0 dans la commande (./script [0] url.txt [2] ... [3]), le second argument rentré est égal à la position 1. 


- Si l'on veut un script "verbeux" et précis sur son exécution, on peut également utiliser `if`pour contrôler l'existence ou non du fichier, demandé en argument, dans l'environement de travail. 

```bash
if [ ! -f "$FICHIER_URLS" ]; then
    echo "Erreur : le fichier `$FICHIER_URLS` n'a pas été trouvé"
    exit 1
fi
```

Rappel : utiliser `-f`devant `nom_de_fichier` répond vrai (0) si le fichier existe. L'opérateur `!` correspond à la négation. Donc : s'il n'y a pas de fichier $FICHIER_URLS, alors envoyer le message error. 

3. Comment afficher le numéro de ligne avant chaque URL (sur la même ligne) ?

Pour afficher le numéro de la ligne avant chaque url, il faut déjà pouvoir être en mesure d'afficher chaque url. On va donc utiliser le code `while read` déjà à notre disposition. 

Dans un premier temps, j'aimerais tester chaque url, et voir si celui semble valide. On peut donc utiliser une expression régulière pour "détecter" le format "https". 

Ce qui nous donne tout d'abord :

```bash
while read -r LINE ; do 
    echo " la ligne : $LINE " 
    if [[ $LINE =~ ^https?:// ]] 
    then 
        echo "ressemble à un url valide" 
    else 
        echo "ne ressemble pas à un url valide" 
    fi
```

Ainsi, ici chaque ligne apparait dans la sortie standard. 
Maintenant, j'aimerais qu'apparaisse dans la sortie standard seulement les erreurs. 

Pour cela, nous allons utiliser entre autre l'option `-z` :

```bash
while read -r LINE ; do
	[ -z "$LINE" ] && continue

	if [[ $LINE =~ ^https?:// ]]; then
		:
	else
		echo "url non valide : $LINE"
	fi
```

Comme on peut le voir, si l'url est valide, rien ne sort sur la sortie standard, puisque rien n'est attendu après le `then`.

- On exécutant le code, on remarque un problème : l'url `fr.wikipedia.org/wiki/Robot_d%27indexation`est annoncé comme un url non valide, puisqu'il ne respecte par la syntaxe appelé par l'expression régulière "https" ; en effet, il commence par `.fr`puisqu'il est un sous-domaine français du site wikipedia.org. 
**Je reporte ce problème à plus tard**.

- Oublions l'affichage ou non des lignes. Dorénavant, la consigne nous demande d'afficher un numéro de ligne devant chaque url. Il va donc falloir afficher toutes les lignes.
Il faut donc ajouter une variable compteur `numligne`, qui s'affiche en tête de ligne et s'incrémente de +1 à chaque ligne, ainsi que `\t`pour la tabulation. 

Ainsi : 

```bash
numligne=0

while read -r LINE ; do
	[ -z "$LINE" ] && continue
	((numligne++))

if [[ $LINE =~ ^https?:// ]]; then
		echo -e  "$numligne\t$LINE"
	else
		echo -e "$numligne\turl non valide : $LINE"
fi

```

Ce qui donne bien :

```bash
1	https://fr.wikipedia.org/wiki/Robot
2	https://fr.wikipedia.org/wiki/Robot_de_cuisine
3	url non valide : fr.wikipedia.org/wiki/Robot_d%27indexation
4	https://fr.wikipedia.org/wiki/Bot_informatique
5	https://fr.wikipedia.org/wiki/Atlas_(robot)
6	https://roboty.magistry.fr
7	https://fr.wikipedia.org/wiki/Robot_(Leonard_de_Vinci)
8	https://fr.wiktionary.org/wiki/robot
9	https://fr.wikipedia.org/wiki/Protocole_d%27exclusion_des_robots
```

Il restera à trouver une solution pour la ligne 3. 

## Quelques obstacles rencontrés durant l'exercice, et leur solution :

- Localiser l'encodage (charset) ou bien compter les mots : ces actions requièrent des besoins spécifiques puisque il faut mettre de côté une partie du texte afin d'extraire uniquement le format voulu.
Ainsi, j'ai fais quelques recherches en lignes pour améliorer mes connaissances en Regex. Cela m'a servit pour isoler les balises html, et compter uniquement les mots par exemple.  




### CONCLUSION
Voici le code obtenu après reponsé à toutes les parties de l'énoncé :

```bash
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
	nb_mots=$(echo "$contenu_page" | sed 's/<[^>]*>//g' | wc -w) #enlève le html pour compter uniquement les mots.
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
```


Je relève un **problème majeur** : la lenteur.

Et pour cause, mon code effectue à de nombreuses reprises l'action `curl`.
Pour résoudre ce défaut et optimiser mon code, je devrais : faire un seul `curl`complet puis stocker le résultat complet dans une variable temporaire, que j'effacerai à la fin du script.
Ainsi, chaque action, comme par exemple `encodage`, viendrait travailler en local grâce à la variable, et non en refaisant une nouvelle requête en ligne. 

