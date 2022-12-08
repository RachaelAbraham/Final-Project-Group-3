library(caret)
library(dplyr)
library(stringr)

SNAP <- read.csv("C:/Users/96209/Documents/GitHub/Final-Project-Group-3/SNAP Benefits_County Level_2013 edit.csv")
Fin <- read.csv("C:/Users/96209/Documents/GitHub/Final-Project-Group-3/Finances2013.csv")

#Delet State total
SNAP<-SNAP[SNAP$X.1 != "Alabama",]
SNAP<-SNAP[SNAP$X.1 != "Alaska",]
SNAP<-SNAP[SNAP$X.1 != "Arizona",]
SNAP<-SNAP[SNAP$X.1 != "Arkansas",]
SNAP<-SNAP[SNAP$X.1 != "California",]
SNAP<-SNAP[SNAP$X.1 != "Colorado",]
SNAP<-SNAP[SNAP$X.1 != "Connecticut",]
SNAP<-SNAP[SNAP$X.1 != "Delaware",]
SNAP<-SNAP[SNAP$X.1 != "Florida",]
SNAP<-SNAP[SNAP$X.1 != "Georgia",]
SNAP<-SNAP[SNAP$X.1 != "Hawaii",]
SNAP<-SNAP[SNAP$X.1 != "Idaho",]
SNAP<-SNAP[SNAP$X.1 != "Illinois",]
SNAP<-SNAP[SNAP$X.1 != "Indiana",]
SNAP<-SNAP[SNAP$X.1 != "Iowa",]
SNAP<-SNAP[SNAP$X.1 != "Kansas",]
SNAP<-SNAP[SNAP$X.1 != "Kentucky",]
SNAP<-SNAP[SNAP$X.1 != "Louisiana",]
SNAP<-SNAP[SNAP$X.1 != "Maine",]
SNAP<-SNAP[SNAP$X.1 != "Maryland",]
SNAP<-SNAP[SNAP$X.1 != "Massachusetts",]
SNAP<-SNAP[SNAP$X.1 != "Michigan",]
SNAP<-SNAP[SNAP$X.1 != "Minnesota",]
SNAP<-SNAP[SNAP$X.1 != "Mississippi",]
SNAP<-SNAP[SNAP$X.1 != "Missouri",]
SNAP<-SNAP[SNAP$X.1 != "Montana",]
SNAP<-SNAP[SNAP$X.1 != "Nebraska",]
SNAP<-SNAP[SNAP$X.1 != "Nevada",]
SNAP<-SNAP[SNAP$X.1 != "New Hampshire",]
SNAP<-SNAP[SNAP$X.1 != "New Jersey",]
SNAP<-SNAP[SNAP$X.1 != "New Mexico",]
SNAP<-SNAP[SNAP$X.1 != "New York",]
SNAP<-SNAP[SNAP$X.1 != "North Carolina",]
SNAP<-SNAP[SNAP$X.1 != "North Dakota",]
SNAP<-SNAP[SNAP$X.1 != "Ohio",]
SNAP<-SNAP[SNAP$X.1 != "Oklahoma",]
SNAP<-SNAP[SNAP$X.1 != "Oregon",]
SNAP<-SNAP[SNAP$X.1 != "Pennsylvania",]
SNAP<-SNAP[SNAP$X.1 != "Rhode Island",]
SNAP<-SNAP[SNAP$X.1 != "South Carolina",]
SNAP<-SNAP[SNAP$X.1 != "South Dakota",]
SNAP<-SNAP[SNAP$X.1 != "Tennessee",]
SNAP<-SNAP[SNAP$X.1 != "Texas",]
SNAP<-SNAP[SNAP$X.1 != "Utah",]
SNAP<-SNAP[SNAP$X.1 != "Vermont",]
SNAP<-SNAP[SNAP$X.1 != "Virginia",]
SNAP<-SNAP[SNAP$X.1 != "Washington",]
SNAP<-SNAP[SNAP$X.1 != "West Virginia",]
SNAP<-SNAP[SNAP$X.1 != "Wisconsin",]
SNAP<-SNAP[SNAP$X.1 != "Wyoming",]

#Delete state abbreviation
SNAP$X.1 <- str_sub(SNAP$X.1,end=-4)
SNAP$X.1 <- gsub(',','',SNAP$X.1)

#SNAP
SNAP<-SNAP[,-c(1:2)]
SNAP<-SNAP[-c(1:2),]
names(SNAP)[names(SNAP)=='X.1'] <- 'State_Name'
names(SNAP)[names(SNAP)=='X.2'] <- 'SNAP'

#Fin
Fin <- Fin[,-c(1:1)]


State <- read.csv("C:/Users/96209/Documents/GitHub/Final-Project-Group-3/sdlist-1314.csv")