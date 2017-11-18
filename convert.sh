# Le répertoire courant doit être la racine du plugin

# création du répertoire docs
mkdir docs

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
rm $f
done

# copie des images
mkdir images/
cp -p ../doc/images/* images/

