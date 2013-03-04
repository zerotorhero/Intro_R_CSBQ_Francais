##
#The Hadley Ecosystem: reshape,plyr and ggplot
#by: Etienne Low-Decarie
##

################################################################################

##
# Housekeeping
##

rm(list=ls())

##
#Load libraries (or install and load)
##
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
# ggplot:  grammar of graphics
##

###################
#Example 1
###################

#Most basic plot

basic.plot<-qplot(data=iris,
                  x=Sepal.Length,
                  y=Sepal.Width)

print(basic.plot)


categorical.plot<-qplot(data=iris,
                  x=Species,
                  y=Sepal.Width)

print(categorical.plot)


#Edited most basic plot

basic.plot<-qplot(data=iris,
                  x=Sepal.Length,
                  xlab="Sepal Width (mm)",
                  y=Sepal.Width,
                  ylab="Sepal Length (mm)",
                  main="Sepal dimensions")

print(basic.plot)



#Add aesthetics

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


#Add geoms

plot.with.line<-basic.plot+geom_line()
print(plot.with.line)

plot.with.linear.smooth<-basic.plot+geom_smooth(method="lm", se=F)
print(plot.with.linear.smooth)

plot.smooth.on.all<-basic.plot+geom_smooth(method="lm", aes(group=1))
print(plot.smooth.on.all)

plot.with.smooth.on.all.and.species<-plot.with.linear.smooth+geom_smooth(method="lm", aes(group=1))
print(plot.with.smooth.on.all.and.species)


###################
#Example 2
###################

CO2.plot<-qplot(data=CO2,
                x=conc,
                y=uptake,
                colour=Treatment)

print(CO2.plot)

CO2.plot<-CO2.plot+facet_grid(.~Type)
print(CO2.plot)


#More than one data point per x value
#Need to either specify group
print(CO2.plot+geom_line())

CO2.plot.group<-CO2.plot+geom_line(aes(group=Plant))
print(CO2.plot.group)


#Or add an extra aes
CO2.plot.shape<-qplot(data=CO2,
                x=conc,
                y=uptake,
                colour=Treatment,
                shape=Plant)+
                  facet_grid(.~Type)+
                  geom_line()+
                  scale_shape_manual(values=1:length(unique(CO2$Plant)))
print(CO2.plot.shape)

#Or calculate a statistic
CO2.plot.mean<-CO2.plot+geom_line(stat="summary", fun.y="mean", size=I(3), alpha=I(0.3))
print(CO2.plot.mean)

CO2.plot.group.mean<-CO2.plot.group+geom_line(stat="summary", fun.y="mean", size=I(3), alpha=I(0.3))
print(CO2.plot.group.mean)





