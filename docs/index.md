# jeedom-md-converts

version 2

## Pré-requis :
apt-get install pandoc asciidoctor (possibilité d'installer les dépendances via le script)

L répertoire du clone de votre plugin doit être fait au même niveau que le répertoire du script de conversion.
Exemple : 

```
/home# ls -l
drwxr-xr-x 4 root    root     4096 déc.  26 16:43 jeedom-md-converts
drwxr-xr-x 8 root    root     4096 déc.  21 18:29 plugin-virtual
```

## Contenu du depôt "jeedom-md-convert"
- README
- docs/ (répertoire contenant les fichiers js, css, html, yml nécessaire à la future doc).
- Convert.sh (script de conversion des documents ancien format ASCIIDOC vers Markdown.

## Utilisation

### Installer le script de conversion 

Dans l'exemple ci dessous, le script de conversion et le plugin à convertir seront installer dans le répertoire home/
```
/home# Git clone https://github.com/stephaneSBO/jeedom-md-converts.git
```
Vous devrier avoir : 
```
/home# ls -l
drwxr-xr-x 4 root    root     4096 déc.  26 16:43 jeedom-md-converts
```

### Cloner le plugin ou le fork du plugin : 

Exemple avec le plugin-weather :
```
git clone https://github.com/stephaneSBO/plugin-weather.git
```

Vous devrier avoir : 
```
/home# ls -l
drwxr-xr-x 4 root    root     4096 déc.  26 16:43 jeedom-md-converts
drwxr-xr-x 8 root    root     4096 déc.  21 18:29 plugin-virtual
```

### Exécution du script 

- Se placer à la racine du plugin

```cd /home/plugin-weather/```

- lancer le script

```../jeedom-md-converts/convert.sh```

### Convertir la documentation

Si c'est la première exécution, il vous sera peut êtes nécessaire d'installer les dépendances du script =>  [lien afficher](#tocAnchor-1-1-9) 

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

## Installation des dépendances

# FAQ

Erreur :
asciidoctor: WARNING: configuration.asciidoc: line 12: section title out of sequence: expected level 1, got level 2

## changelog
Mise à jour de la doc
Suppression des fichiers temporaire xml
 
