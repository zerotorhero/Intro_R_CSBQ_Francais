# Vous pouvez utiliser le symbole "#" pour dire à R d'ingnorer le texte qui suit
# # # # Vous pouvez utiliser autant de «#» que vous souhaitez


# Vous pouvez également placer des commentaires "#" après les entrées R, par exemple:
x <-0 # blablabla ... mon entrée R est intéressante


# Il est recommandé de placer un en-tête dans chacune de vos scripts 
# fournissant des informations sur le script comme suit:
##############################################################################
# Date: vendredi 8 mars 2013
# Par: Insérez votre nom (par exemple Zofia E. Taranu)
# Description: Atelier d'introduction CSBQ
# Version de R utilisée: RStudio 0.94.92
# ...


# HOUSEKEEPING #
# Ménage: sont des fonctions qui feront en sorte que votre script fonctionne bien.
  
# Supprimer la mémoire de R
rm(list=ls())   
# Supprime toutes les variables de la mémoire
# Éviter des erreurs telles que l'utilisation d'anciennes données 

# 2. Établir le répertoire de travail
# Un répertoire est un dossier et des instructions (chemin) pour arriver à ce dossier
# Le répertoire de travail est le dossier dans lequel R peut lire les fichiers
# et où R va sauvegarder les fichiers
# setwd ("~ / Desktop / PhD / HIVER atelier 2013/Stats/Intro Jour 1")
# Ce n'est pas nécessaire lors de l'utilisation des projets RStudio
  
# 3. Importer des données
# Nous allons d'abord importer nos «propres» données d'un fichier csv

iris_data<-read.csv("./Data/iris_good.csv") 
# "iris_good.csv" est le nom de fichier complet, où «. csv» est l'extension du fichier
# 
# Regardez ...
# a. la matrice de données entière (pensez à ce que votre feuille de calcul Excel en quelque sorte)
iris_data
iris_data$Sepal.Length
  
#b. les variables incluses dans cet ensemble de données (noms de colonnes)
names(iris_data)
  
# c. les premières lignes (par défaut est 6 lignes)
head(iris_data, n = 5)     # 5 est le nombre de lignes

# d. la structure de vos données (variables, types, valeurs)
str(iris_data)
  
# e. un résumé des données
summary(iris_data)
# Noter que la fonction «summary» a des résultats utiles pour de nombreux types d'objets génériques R
# (Ex. objets ANOVA)
  
# f.un graphique avec les options établies par défauts
plot(iris_data)
# comme «summary», la fonction plot est doté de méthodes par défaut pour de nombreux types d'objets génériques R
  
# 4. Données brisées
# Essayer d'importer les données mal en point ("iris_broken")

iris_brisées<-read.csv("iris_broken.csv")
# Erreur 1: mauvaise extension (.txt et non .csv)

iris_brisées<-read.csv("iris_broken.txt")
  
# Regardez les données, head() et str() 
# ces fonctions sont particulièrement utiles à l'étape d'importation de données
head(iris_brisées)
str(iris_brisées)

# Erreur 2: Les données semblent être regroupés dans une seule ligne
# c.-à- le caractère séparation n'a pas été reconnu
  
# Essayez l'importation de nouveau avec un séparateur différent
iris_brisées<-read.csv("iris_broken.txt", sep = "")

# Utiliser l'argument sep pour indiquer quel caractère sépare les valeurs 
# de chaque ligne du fichier (ici; TAB a été utilisé)
head(iris_brisées)
str(iris_brisées)
  
# Erreur 3: Les 4 premières lignes sont inutiles
iris_brisées<-read.csv("iris_broken.txt", sep = "", skip = 4)

# Ajouter l'argument "skip" pour sauter quelques lignes
head(iris_brisées)
str(iris_brisées)
  
# Erreur 4: Regarder le fichier, nous remarquons que nos données contient 
# en minuscule «na» et «Forgot_this_value»
# Rappel: R ne reconnaît que «NA»
iris_brisées$Petal.Length
iris_brisées<-read.csv("iris_broken.txt", sep = "", skip = 4, na.strings = c("NA","na","Forgot_this_value"))
                      
head(iris_brisées)
str(iris_brisées)

# Erreur 5: Plusieurs variables apparaissent toujours comme facteurs
class(iris_brisées$Sepal.Length)  # numéric   :)!
class(iris_brisées$Sepal.Width)   # facteur  ;(
class(iris_brisées$Petal.Length)  # facteur  ;(
class(iris_brisées$Petal.Width)   # numéric   :)!

# remarquerez par exemple:
iris_brisées$Sepal.Width[23]  # pour la rangée 23, la valeur n'a pas été bien entré

iris_brisées<-read.csv("iris_broken.txt",
                      sep="",
                      skip=4,
                      na.strings=c("NA", "na","forgot_this_value"),
                      as.is=c("Sepal.Width", "Petal.Length"))
  
# Indique à R de laisser les deux colonnes seules
head(iris_brisées)
str(iris_brisées)

# Ce n'est toujours pas parfait, maintenant R pense que ces variables ne sont que des 
# caractères, et non des valeurs numériques
# utilisez «as.class wanted(argument)» où vous pouvez remplacer «class wanted" avec «numeric», «ordered» or «factor»              
iris_brisées$Sepal.Width <- as.numeric(iris_brisées$Sepal.Width)
iris_brisées$Petal.Length <- as.numeric(iris_brisées$Petal.Length)
# Notez le message d'avertissement car un NA a été introduit là où il y avait des valeurs non-numériques
# c.-à-, la 23e entrée de Sepal.Width a été changé en «NA»
iris_brisées$Sepal.Width[23]                    
  
# Les données brisées sont maintenant corrigés et importer dans R!! :)
head(iris_brisées)
str(iris_brisées)

# 5. Sauvegardez vos données  

# a. Sauvergarder un fichier R 
save(iris_brisées, file = "iris_cleaned.R")               

# Supprimer la mémoire 
rm(list = ls())
  
# b. re-importer iris_brisées
load("iris_cleaned.R")
head(iris_brisées)   # Tout est beau!
  

# 7. Réparer les données brisées du CO2_broken!
rm(list=ls())
setwd("~/Desktop/PhD/FALL 2011/Stats workshop - Day 2/Data_Intro Day 2")  
CO2_data<-read.csv("CO2_broken.csv") 

# look at the data
head(CO2_data)
str(CO2_data)

# Erreur 1: les deux premières lignes ne sont que des notes
#sur des valeurs manquantes dans le sous-ensemble du Québec
CO2_data<-read.csv("CO2_broken.csv", skip = 2)
head(CO2_data)
str(CO2_data)

# Erreur 2: prendre soin des NA; Regardons les données du Québec                                                            
CO2_sub_QC<-subset(CO2_data, CO2_data$Type == "Quebec", select=c(conc, uptake))

# remplacer le "cannot_read_notes" avec NAs
CO2_data<-read.csv("CO2_broken.csv", skip = 2, na.string = c("cannot_read_notes"))
head(CO2_data)
str(CO2_data)
                                                            
# On dirait que nous avons appelés les niveaux "chiled"au lieu de "chilled" et "nnchilled"
# au lieu de "nonchilled": fautes de frappe!
levels(CO2_data$Treatment)

# Erreur 3: prendre soin de fautes de frappe dans la variable «Treatment»                                                          
CO2_data<-as.data.frame(sapply(CO2_data,gsub,pattern="chiled",replacement="chilled"))
CO2_data<-as.data.frame(sapply(CO2_data,gsub,pattern="nnchilled",replacement="nonchilled"))
levels(CO2_data$Treatment)

str(CO2_data)


#Un autre problème, le "conc" et "uptake" variables apparaissent comme des facteurs

# Erreur 4: modifier ces variables de facteur numérique
CO2_data$conc<-as.numeric(CO2_data$conc)
CO2_data$uptake<-as.numeric(CO2_data$uptake)

str(CO2_data)

#Wow! Vous avez finit!