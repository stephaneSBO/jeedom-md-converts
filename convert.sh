#! /bin/sh
# Structure du fichier _config.yml
# 
# langs:
# Theme_version:
# nameLogo:
# dateConversion:
# 
#..........................................................................
# Fonctions
#..........................................................................

# Fonction ID du Plugin
f_idname ()
{ idname=$(cat plugin_info/info.json | grep '"id" :'|awk '{ print $3}' | sed s/\"//g | sed s/,//g |  dos2unix)
}
# Fonction Thème version
f_theme_version ()
{ if [ ! -f docs/_config.yml ]; then
	Theme_version="0"
#	echo controle A "$Theme_version" | grep -E ^\-?[0-9]*\.?[0-9]+$
else
	Theme_version=$(sed -nr '/Theme_version:/p' docs/_config.yml |awk '{ print $2}')
#	echo controle B "$Theme_version" | grep -E ^\-?[0-9]*\.?[0-9]+$
fi
}
# Fonction maj thème nécessaire : 0(non)/1(oui)
f_maj ()
{ if [ $Current_Theme_version = $Theme_version ]; then
	maj_necessaire=0
	echo "Pas de mise à jour"
else
	maj_necessaire=1
	echo "Mise à jour disponible"
fi
}
#..........................................................................
# Variables
#..........................................................................

NC='\e[0m' # Pas de couleur
RED1='\033[1;31m' # Police rouge gras
RED2='\033[1;41m' # Fond rouge gras
GREEN1='\033[1;32m' # Police verte gras
GREEN2='\033[1;42m' # Fond verte gras
BLUE1='\033[1;34m' # Police bleu gras
BLUE2='\033[1;44m' # Fond verte gras
REP_CURRENT=$(basename `pwd`)
# Récupération de l'ID du plugin dans le fichier info.json
f_idname
# Variable fin de l'icone 
endiconename=_icon.png
# Construction de la variable iconename. IMPORTANT : si le nom de l'icone de suit pas le standard Jeedom, le thème ne sera pas complet.
iconename=$idname$endiconename
# Définition de la dernière version du thème :
Current_Theme_version=1
echo Verion courrante du theme : $Current_Theme_version

# Définition de la variable Theme_version à 0 si aucun thème précédemment installé :
f_theme_version
#
f_maj
#..........................................................................
# detournement de control-c grace a trap
#..........................................................................
trap "echo 'Control-C ne peut plus etre utilise' ; sleep 1 ; clear ; continue " 1 2 3

#..........................................................................
# menu
#..........................................................................
while true
do
  #..........................................................................
  # affichage
  #..........................................................................
  clear
  echo "\t MENU OF CHOICES


\t R -- \t Usage
\t B -- \t Installation des dépendances

\t C -- \t Contrôle
\t O -- \t ${GREEN2}Convertion Plugin Officiel (réservé Team Jeedom)${NC}
\t T -- \t ${BLUE2}Convertion Plugin Tier${NC}

\t D -- \t Debug
\t A -- \t Aide
\t Q -- \t Quitter le programe 

\t Entrez une lettre (parmi les choix possibles)
\t puis tapez RETURN \c"

  #..........................................................................
  # saisie d une touche et gestion
  #..........................................................................
  read answer
  clear

  case "$answer" in
    [Aa]*) echo "Documentation disponible : https://stephanesbo.github.io/jeedom-md-converts/" ;;

    [Bb]*) apt-get install pandoc asciidoctor ;;
    [Rr]*) echo "A compléter" ;;
    [Dd]*) echo "A compléter"
  #..........................................................................
  # Débug
  #..........................................................................
	echo "Dernière version du thème disponible : ${GREEN1}$Current_Theme_version${NC}\n"
	echo "Version actuelle du thème présent : ${GREEN1}$Theme_version${NC}\n"
	echo "Répertoire courant : ${GREEN1}$REP_CURRENT${NC}\n"
	echo "ID du plugin : ${GREEN1}$idname${NC}\n"
	echo "Nom de icone : ${GREEN1}$iconename${NC}\n"
	echo -n "Mise à jour ? : ${BLUE1}"; f_maj; echo "${NC}\n"
	;;
  #..........................................................................
  # Controle
  #..........................................................................
     [Cc]*)

     echo $Current_Theme_version
    echo "${RED2}Contrôle avant exécution de la convertion ${NC}\n"
    echo "Répertoire du plucgin : ${GREEN1}$REP_CURRENT${NC}. Merci de valider que cela correspond bien à la racine du plugin à convertir"
    if [ ! -f plugin_info/info.json ]; then
        echo "${RED2}Ce plugin ne dispose pas de fichier info.json.\n Pas de convertion possible. Merci de mettre en conformité ce plugin avant de relancer la convertion.${NC}"
        exit 0
    else
        echo "Contrôle présence JSON : ${GREEN}JSON présent${NC}"
		echo "ID du plugin : ${GREEN}$idname${NC}"
	fi
    
    if [ ! -f plugin_info/$iconename ]; then
        echo "${RED2}Fichier plugin_info/$iconename absent.\n Pas de convertion possible. Merci de mettre en conformité ce plugin avant de relancer la convertion.${NC}"
        exit 0
    else
        echo "Fichier : ${GREEN}plugin_info/$iconename présent${NC}"
	fi
	
	if [ "$Theme_version_all" = 1 ]; then
        echo "Theme installé : ${GREEN}Theme présent${NC}"
        echo "Theme installé : ${GREEN}$Theme_version${NC}"
        Theme_version_maj=`expr $Theme_version \< 1.00`
        if [ "$Theme_version_all" = 1 ]; then
        	echo "${RED2}Mise à jour du thème disponible vers la version $Current_Theme_version ${NC}"
        	else
        		echo ""
        fi
        #exit 0
    else [ "$Theme_version_all" = 0 ]
        echo "${RED2}Aucun theme présent${NC}"
        echo "Theme installé : ${RED2}$Theme_version${NC}"
	fi   
    ;;
  #..........................................................................
  # Installation de la version 1 du thème de la documentation Jeedom
  #..........................................................................
    [Oo]*)
	if [ $Theme_version = 1 ]; then
		echo "${GREEN1}Pas de mise à jour disponible${NC}"
# A remettre avant diffusion     	exit 0
    else
     	echo ""
    fi	
    
    echo "${BLUE2}Mise à jour de la documentation.\n ${NC}\n"
	# controle de conformité 
	echo "${GREEN2}Contrôle avant exécution de la convertion ${NC}\n"
    # Contrôle répertoire courant
    echo "Répertoire du plugin : ${BLUE2}$REP_CURRENT${NC}. ${RED2}Merci de valider que cela correspond bien à la racine du plugin à convertir${NC}\n"
    # Contrôle Présence JSON
    if [ ! -f plugin_info/info.json ]; then
        echo "${RED2}Ce plugin ne dispose pas de fichier info.json.\n Pas de convertion possible. Merci de mettre en conformité ce plugin avant de relancer la convertion.${NC}"
        exit 0
    else
        echo "Contrôle présence JSON : ${GREEN2}JSON présent${NC}"
		echo "ID du plugin : ${BLUE2}$idname${NC}"
	fi
	
	# création du répertoire docs
	echo "${BLUE2} Copie du contenu doc => docs${NC}\n"
	cp -R /home/jeedom-md-converts/docs/ .

	# converion des fichiers asciidoc en xml
	echo "${BLUE2} Conversion des documents ASCIIDOC vers XML${NC}\n"
	asciidoctor -b docbook doc/fr_FR/* -D docs/

	# convertion des xml en md
	cd docs/
	echo "${BLUE2} Conversion des fichiers XML en Markdown${NC}\n"
	FILES=*.xml
	for f in $FILES
		do
			# extension="${f##*.}"
			filename="${f%.*}"
			echo "Converting $f to $filename.md"
  `			pandoc -f docbook $f -o $filename.md`
			# Suppression des fichiers xml  
			echo "${BLUE2} Suppression des fichiers XML${NC}\n" 
			rm $f
	done
	cd ..

	#Identification des langues présentes dans doc et génération de la variable LANGS Exemple [fr,en,ru,de,es,it,id].
	echo "${BLUE2} Identification des langues déjà traduites${NC}"
	LANGS=$(find doc -name index.asciidoc | sed 's/\doc\///' | sed 's/\/index.asciidoc//' | sed -e 's/...$//' | sed 's/$/,/' | sed '1s/^/[\n/' | sed '$ s/.$//' | sed '$a\\]' | tr -d "\n")
	#echo $LANGS
	echo "${BLUE2} Inscription des langues dans le fichier _config.yml${NC}"
	#Init variable langs dans le fichier _config.yml
	sed -i 's/\(langs: \)\(.*\)/\1/' docs/_config.yml
	#Renseignement des langues dans le fichier _config.yml
	sed -i 's/\langs:/& '$LANGS'/' docs/_config.yml

	# copie des images
	echo "${BLUE2} Copie des images dans 'docs/images'${NC}"
	x="$(mkdir docs/images/ 2>&1)"
	cp -p doc/images/* docs/images/

	#Optimation fichier md (image path)
	echo "${BLUE2} Modification des chemins des images dans les fichiers Markdown${NC}"
	sed -i 's/..\/images/images/g' docs/*.md
	
	#Init variable nameLogo dans le fichier _config.yml
	echo "${BLUE2} Inscription du nom de l'icone dans le fichier _config.yml${NC}"
	#Init variable nameLogo dans le fichier _config.yml
	sed -i 's/\(nameLogo: \)\(.*\)/\1/' docs/_config.yml
	#Renseignement variable nameLogo dans le fichier _config.yml	
	sed -i 's/nameLogo:/& '$iconename'/' docs/_config.yml
	#cat plugin_info/info.json | grep '"id" :' |awk '{ print $3}' | sed s/\"//g | sed s/,//g | sed 's/$/_icon.png/' | sed 's/^/nameLogo: /' >> docs/_config.yml

	#echo $idname
	#sed -i '/nameLogo/c\'"$idname"' _config.yml

	#variable index.md
	echo "${BLUE2} Inscription des paramètres du thème dans index.md${NC}"
	sed -i '1s/^/---\nkey_do_not_edit_lang: fr\nkey_do_not_edit_label:\n    key_do_not_edit_titreMenu: Sommaire\n    key_do_not_edit_btnAffiche: Déplier\n    key_do_not_edit_btnMasquer: Cacher\n---\n/' docs/index.md

	# correction des %22 interprété par github page
	echo "${BLUE2} Correction des chaînes de caractères pouvant être interprétées pag GitHub Page${NC}"
	echo "${BLUE2} Suppression %22 dans des URLs, ${RED2}Merci de contrôler vos liens après conversion ${NC}"
	sed -i 's/%22/"/g' docs/*.md
	echo "${BLUE2} Suppression {#. Pb conversion des titres. ${NC}"
	sed -i 's/{#.*//' docs/index.md

	# Versionning du _config.yml
	echo "${BLUE2} Insertion Date de conversion. ${NC}"
	sed -i 's/\(dateConversion: \)\(.*\)/\1/' docs/_config.yml
	dateConversion=$(date +"%Y-%m-%d-%Hh%M")
	sed -i 's/version:/& '$dateConversion'/' docs/_config.yml

	# Ajouter version de la version du thème dans _config.yml.
	echo "${BLUE2} Insertion version du thème. ${NC}"
	#Init variable Theme_version dans le fichier _config.yml
	sed -i 's/\(Theme_version: \)\(.*\)/\1/' docs/_config.yml
	# date +"%Y%m%d%H%M" | sed 's/^/dateConversion: /' >> docs/_config.yml
	sed -i 's/Theme_version:/& '$Current_Theme_version'/' docs/_config.yml

	echo "${GREEN2} Fin de conversion. Merci de valider et commit vos modifications ${NC}"
	#echo 'Theme_version: 1' >> docs/_config.yml
	# Vérification de la version du script :
	#Theme_version=$(cat docs/_config.yml | grep 'Theme_version:'|awk '{ print $2 }')
#fi

#if [ "$conv_version" = "1" ]; then
#        echo 'script pas encore disponible'
#fi

#if [ "$conv_version" = "2" ]; then
#       echo 'script pas encore disponible'
#fi
;;
    [Tt]*) echo "En construction" ;;

    [Qq]*)  echo "sortie du program" ; exit 0 ;;
    *)      echo "Choisissez une option affichee dans le menu:" ;;
  esac
  echo "tapez RETURN pour le menu"
  read dummy
done


