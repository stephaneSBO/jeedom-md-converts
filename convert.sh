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

# copie des images
mkdir images/
cp -p ../doc/images/* images/

#Optimation fichier md (image path)
sed -i 's/..\/images/images/g' *.md

#variable icon name
#cat ../plugin_info/info.json | grep '"id" :' |awk '{ print $3}' | sed s/\"//g | sed s/,//g | sed 's/$/_icon.png/' | sed 's/^/nameLogo: /' >> _config.yml
end=_icon.jpg
#echo $end
idname=$(cat plugin_info/info.json | grep '"id" :'|awk '{ print $3}' | sed s/\"//g | sed s/,//g | sed 's/^/nameLogo: /' | dos2unix)$end
#echo $idname
sed -i '/nameLogo/c\'"$idname"'' docs/_config.yml

# correction des %22 interprété par github page
sed -i 's/%22/"/g' *.md

# add version
sed -i '/version:/d' _config.yml
date +"%Y%m%d%H%M" | sed 's/^/version: /' >> _config.yml

