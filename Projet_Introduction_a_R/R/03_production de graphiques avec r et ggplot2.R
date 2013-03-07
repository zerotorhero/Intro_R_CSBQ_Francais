##
#03_production de graphiques avec r et ggplot2.R
#par: Etienne Low-Decarie
##

################################################################################

##
# Ménage
##

rm(list=ls())  #Vider la mémoires

##
#Mise en mémoire des librairies/extensions
##

#Nous utilison ici une formulation qui vérifie si une extension est installée
# require(plyr)  retournera vrai si l'extension est installée
# !require(plyr)  retournera vrai si l'extension n'est pas installée
# if() n'execute la commande entre {} que si la condition évalué est vrai
# donc {install.packages("plyr")} sera évalué que si l'extension plyr n'est pas installée
if(!require(plyr)){install.packages("plyr")}
require(plyr)

if(!require(reshape)){install.packages("reshape")}
require(reshape)

if(!require(ggplot2)){install.packages("ggplot2")}
require(ggplot2)

if(!require(vegetarian)){install.packages("vegetarian")}
require(vegetarian)

if(!require(vegan)){install.packages("vegan")}
require(vegan)

if(!require(gridExtra)){install.packages("plyr")}
require(gridExtra)
 

##
# ggplot:  grammaire des graphique
##

###################
#Exemple 1
###################

#Graphique de base

basic.plot<-qplot(data=iris,
                  x=Sepal.Length,
                  y=Sepal.Width)

print(basic.plot) #Imprime l'objet contenant le graphique à l'écran


categorical.plot<-qplot(data=iris,
                  x=Species,
                  y=Sepal.Width)

print(categorical.plot) #qplot reconnait les variables catégoriques


#Modification du graphique de base

basic.plot<-qplot(data=iris,
                  x=Sepal.Length,
                  xlab="Sepal Width (mm)",  #le titre de l'axe des x
                  y=Sepal.Width,
                  ylab="Sepal Length (mm)", # le titre de l'axe des y
                  main="Sepal dimensions")  # le titre principal

print(basic.plot)



#Ajout de correspondances esthétiques 
#contrairement au fonction de base de R qplot convertie
#les facteurs directement à une correspondances esthétiques
#il n'est donc pas nécessaire de convertir les facteurs à 
#des valeurs esthétique au préalable

basic.plot<-qplot(data=iris,
                  x=Sepal.Length,
                  xlab="Sepal Width (mm)",
                  y=Sepal.Width,
                  ylab="Sepal Length (mm)",
                  main="Sepal dimensions",
                  colour=Species,       
                  shape=Species,
                  alpha=I(0.5))

print(basic.plot)


#Ajouter des élément geométriques

plot.with.line<-basic.plot+geom_line()  #ajout d'une ligne
print(plot.with.line)

plot.with.linear.smooth<-basic.plot+geom_smooth(method="lm", se=F)
print(plot.with.linear.smooth)

plot.smooth.on.all<-basic.plot+geom_smooth(method="lm", aes(group=1))
print(plot.smooth.on.all)

plot.with.smooth.on.all.and.species<-plot.with.linear.smooth+geom_smooth(method="lm", aes(group=1))
print(plot.with.smooth.on.all.and.species)


###################
#Exemple 2
###################

CO2.plot<-qplot(data=CO2,
                x=conc,
                y=uptake,
                colour=Treatment)

print(CO2.plot)

CO2.plot<-CO2.plot+facet_grid(.~Type)
print(CO2.plot)


#Lorsque l'on utilise «line» et que plus d'une valeur de y apparait pour chaque x
#Il faut spécifier les groupes
print(CO2.plot+geom_line())

CO2.plot.group<-CO2.plot+geom_line(aes(group=Plant))
print(CO2.plot.group)


#Ou séparer les données en utilisant des correspondances esthétiques additionelles
CO2.plot.shape<-qplot(data=CO2,
                x=conc,
                y=uptake,
                colour=Treatment,
                shape=Plant)+
                  facet_grid(.~Type)+
                  geom_line()+
                  scale_shape_manual(values=1:length(unique(CO2$Plant)))
print(CO2.plot.shape)

#Ou encore faire le calcule d'une statistique
CO2.plot.mean<-CO2.plot+geom_line(stat="summary", fun.y="mean", size=I(3), alpha=I(0.3))
print(CO2.plot.mean)

CO2.plot.group.mean<-CO2.plot.group+geom_line(stat="summary", fun.y="mean", size=I(3), alpha=I(0.3))
print(CO2.plot.group.mean)



#Pour sovegarder un graphique, il s'agit de l'imprimer lorsqu'un fichier PDF est ouvert

pdf("./Plots/examples de graphiques.pdf") #Ouvrir un PDF, noter l'extension .pdf est incluse
print(CO2.plot.shape)  #Imprimer les graphiques que vous voulez intégré au fichier
print(CO2.plot.group.mean)
graphics.off()  #Fermer tous les dispositifs graphiques incluant le pdf
#pour ne fermer que le dernier dispositif graphique, utiliser dev.off()