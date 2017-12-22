# jeedom-md-converts

version 2

## Pré-requis :
apt-get install pandoc asciidoctor

le clone doit être fait dans le rép /home/ 

le cas contraire change le script convert.sh

## Cloner le plugin ou le fork du plugin : 
cd /home
git clone https://github.com/stephaneSBO/plugin-weather.git

## lancer le script 
 ### Se placer à la racine du plugin
 ex : 
cd /home/plugin-weather/

 ### lancer le script

/home/jeedom-md-converts/convert.sh

## ajouter le répertoire docs 

git add docs/

## commit 

git commit -m "docs"

## push

git push

## Configuration du dépôt

### Description du dépôt

La desctiption du dépôt doit être configuré 
Dans le champs description, spécifier le nom du plugin. 
Le champs Website n'est pas utilisé par la doc, donc falcutatif.

### Configuration GitHub Pages

Settings > GitHub Pages :
Souurces > choisir "/docs folder"

Theme Chooser > choisir "Cayman theme"

Un message de type "Your site is ready to be published at https://stephanesbo.github.io/plugin-weather/." vous indique que le doc est en cours de génération.

## Validation et correction

Après correction, valider le contenu convertie par ce script. Commme tous script, il est pasrfois nécessaire d'adapter le rendu.

Il est fortement recommandé de revoir les chapitres. Parfois la convertion adapte mal le format md suite à la double converstion ascidoc => xml => md

# FAQ

Erreur :
asciidoctor: WARNING: configuration.asciidoc: line 12: section title out of sequence: expected level 1, got level 2

## changelog
Mise à jour de la doc
Suppression des fichiers temporaire xml
 
