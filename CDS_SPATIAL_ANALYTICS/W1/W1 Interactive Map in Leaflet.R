#Spatial Analytics: Assignment 1

#Make a Map (option 2): 
#You wish to travel to Chicago for a study stay but wish to stay away from the most crime-ridden areas. 
#You have a friend at Evanston, who invited you in. 
#Is it safe to stay at her place? Make a map that allows both of you to explore the local situation. 


#Create a standalone .html map in Leaflet showing at least basic topography and relief, and load in the table of points.
library(leaflet)
#install.packages("leaflet.extras")
library(leaflet.extras)
library(htmlwidgets)
library(tidyr)

#set wd
setwd("C:/Users/cecil/OneDrive/AU/Spatial Analytics/Assignments/W1/cds-spatial/Week01/data")

#read csv
ccrimes <- read.csv("ChicagoCrimes2017.csv")


#filter data
#cmurders <- filter(ccrimes, Primary.Type == "HOMICIDE") <- this did not work. it couldn't find the column
cmurders <- ccrimes[ccrimes$Primary.Type == "HOMICIDE",]



murder_map_c <- leaflet() %>% 
  addTiles() %>% 
  addMarkers(lng = cmurders$Longitude, 
             lat = cmurders$Latitude,
             popup = cmurders$Description)

murder_map_c



#Adding a minimap 

esri <- grep("^Esri", providers, value = TRUE)

for (provider in esri) {
  l_cc <- l_cc %>% addProviderTiles(provider, group = provider)
}

leaflet() %>% 
  addTiles() %>% 
  addMarkers(lng = cmurders$Longitude, 
             lat = cmurders$Latitude,
             popup = cmurders$Description) %>% 
addMiniMap(tiles = esri[[1]], toggleDisplay = TRUE,
           position = "bottomright") %>% 
  addMeasure(primaryLengthUnit = "kilometers")


#There are so many point that we can barely see the map. We will try with clusters instead. 
leaflet() %>% 
  addTiles() %>% 
  addMarkers(lng = cmurders$Longitude, 
             lat = cmurders$Latitude,
             popup = cmurders$Description,
             clusterOptions = markerClusterOptions()) %>% 
  addMiniMap(tiles = esri[[1]], toggleDisplay = TRUE,
             position = "bottomright") %>% 
  addMeasure(primaryLengthUnit = "kilometers")

  #This is much better!


#Trying to make a heat map


leaflet() %>% 
  addTiles() %>% 
  addHeatmap(lng = cmurders$Longitude, 
             lat = cmurders$Latitude,
             blur = 40)
  

#This is allright but I like the cluster map better!





