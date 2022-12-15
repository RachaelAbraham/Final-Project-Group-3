library(caret)
library(dplyr)
library(stringr)
library(tidyr)

SNAP <- read.csv("C:/Users/96209/Documents/GitHub/Final-Project-Group-3/SNAP Benefits_County Level_2013 edit.csv")
Fin <- read.csv("C:/Users/96209/Documents/GitHub/Final-Project-Group-3/Finances2013.csv")
State <- read.csv("C:/Users/96209/Documents/GitHub/Final-Project-Group-3/sdlist-1314-updated.csv")

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
SNAP<-SNAP[-c(1:2),]
names(SNAP)[names(SNAP)=='Table.with.column.headers.in.row.3'] <- 'State_Code'
names(SNAP)[names(SNAP)=='X'] <- 'County_Code'
names(SNAP)[names(SNAP)=='X.1'] <- 'County_Name'
names(SNAP)[names(SNAP)=='X.2'] <- 'SNAP'

#State <- State[,-c(1:1)]
State<-State[-c(1:2),]
names(State)[names(State)=='X'] <- 'State_Code'
names(State)[names(State)=='X.1'] <- 'School_Dis_Code'
names(State)[names(State)=='X.2'] <- 'School_Dis_Name'
names(State)[names(State)=='X.3'] <- 'County_Name'
names(State)[names(State)=='X.4'] <- 'County_Code'
names(State)[names(State)=='Table.with.column.headers.in.row.3.'] <- 'Abbe'
State$School_Dis_Name <- tolower(State$School_Dis_Name)

#Com State Code and County Code
SNAP<-tidyr::unite(SNAP,"State_County_Code","State_Code","County_Code")
State<-tidyr::unite(State,"State_County_Code","State_Code","County_Code")
State<-tidyr::unite(State,"State_School_Dis_Name","Abbe","School_Dis_Name")

#Merge State and SNAP by County Name
df <- left_join(State,SNAP,by='State_County_Code')
df<- select(df,-c('County_Name.y'))
names(df)[names(df)=='County_Name.x'] <- 'County_Name'
df <- df[-c(2:3)]



#Fin
Fin <- Fin[,-c(1:1)]
Fin <- Fin[-c(14:17)]
names(Fin)[names(Fin)=='NAME'] <- 'School_Dis_Name'
Fin$School_Dis_Name <- tolower(Fin$School_Dis_Name)
Fin<-tidyr::unite(Fin,"State_School_Dis_Name","Abbe","School_Dis_Name")

df <- left_join(Fin,State,by='State_School_Dis_Name')

#Rename data frame
names(df)[names(df)=='TOTALREV'] <- 'TOTAL_REVENUE'
names(df)[names(df)=='TFEDREV'] <- 'FEDERAL_REVENUE'
names(df)[names(df)=='TSTREV'] <- 'STATE_REVENUE'
names(df)[names(df)=='TLOCREV'] <- 'LOCAL_REVENUE'
names(df)[names(df)=='TOTALEXP'] <- 'TOTAL_EXPENDITURE'
names(df)[names(df)=='TCURINST'] <- 'INSTRUCTION_EXPENDITURE'
names(df)[names(df)=='TCURSSVC'] <- 'SUPPORT_SERVICES_EXPENDITURE'
names(df)[names(df)=='TCURONON'] <- 'OTHER_EXPENDITURE'
names(df)[names(df)=='TCAPOUT'] <- 'CAPITAL_OUTLAY_EXPENDITURE'
df = df %>% select(State_County_Code, everything())
df = df %>% select(County_Name, everything())
df = df %>% select(STATE, everything())
df = df %>% select(YRDATE, everything())
df = df %>% select(School_Dis_Code, everything())
df = df %>% select(State_School_Dis_Name, everything())

df = na.omit(df)
write.csv(df,"C:/Users/96209/Documents/GitHub/Final-Project-Group-3/Data.csv")