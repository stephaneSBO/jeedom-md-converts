#!/bin/bash

#variables
pwd

conv_version=$(sed -nr '/conv_version:/p' _config.yml |awk '{ print $2}')
echo $conv_version
langs=$(find ../doc -name index.asciidoc | sed 's/..\/doc\///' | sed 's/\/index.asciidoc//' | sed -e 's/...$//' | sed 's/$/,/' | sed '1s/^/langs: [\n/' | sed '$ s/.$//' | sed '$a\\]' | tr -d "\n")

if [ "$conv_version" = "" ]; then
        echo 'script '
# Le répertoire courant doit être la racine du plugin

# création du répertoire docs

cp -R /home/jeedom-md-converts/docs/ .

# converion des fichiers asciidoc en xml 
asciidoctor -b docbook doc/fr_FR/* -D docs/

# convertion des xml en md
cd docs/
FILES=*.xml
for f in $FILES
do
  # extension="${f##*.}"
  filename="${f%.*}"
  echo "Converting $f to $filename.md"
  `pandoc -f docbook $f -o $filename.md`

# Suppression des fichiers xml  
#rm $f
done

#définition du fichier lang.yml
find ../doc -name index.asciidoc | sed 's/..\/doc\///' | sed 's/\/index.asciidoc//' > lang.yml

# copie des images
mkdir images/
cp -p ../doc/images/* images/

#Optimation fichier md (image path)
sed -i 's/..\/images/images/g' *.md

#variable icon name
#cat ../plugin_info/info.json | grep '"id" :' |awk '{ print $3}' | sed s/\"//g | sed s/,//g | sed 's/$/_icon.png/' | sed 's/^/nameLogo: /' >> _config.yml
end=_icon.png
#echo $end
pwd
idname=$(cat ../plugin_info/info.json | grep '"id" :'|awk '{ print $3}' | sed s/\"//g | sed s/,//g | sed 's/^/nameLogo: /' | dos2unix)$end
#echo $idname
sed -i '/nameLogo/c\'"$idname"'' _config.yml

#variable index.md
sed -i '1s/^/---\nkey_do_not_edit_lang: fr\nkey_do_not_edit_label:\n    key_do_not_edit_titreMenu: Sommaire\n    key_do_not_edit_btnAffiche: Déplier\n    key_do_not_edit_btnMasquer: Cacher\n---\n/' index.md

# correction des %22 interprété par github page
sed -i 's/%22/"/g' *.md
sed -i 's/{#.*//' index.md
# add version
sed -i '/version:/d' _config.yml
date +"%Y%m%d%H%M" | sed 's/^/version: /' >> _config.yml
fi

if [ "$conv_version" = "1" ]; then
        echo 'script pas encore disponible'
fi

if [ "$conv_version" = "2" ]; then
        echo 'script pas encore disponible'
fi

