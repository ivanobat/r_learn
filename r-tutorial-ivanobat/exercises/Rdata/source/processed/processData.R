
# 0. Description -------------------------------------------------------------

# This script does some processing on the data in the data folder.
# 
# OUTPUT:
# dProcessed/procData.RData file  

rm(list = ls())

# 1. Loading the data --------

# - load the csv file using "read.csv" or "read.table" command 
# - you can connect the folder name with file name by using "paste" command
# - you will need to set some options in the "read.csv" to read the
#   data correctly
setwd("/home/ivanobat/gitrepos/r-tutorial-ivanobat/exercises/Rdata/")
dirName <- "data/"
fileName <- "aging-population-2008.csv" 
saveFileName <- "processed/procData.RData"

ag_pop <- read.table(paste0("data/",fileName), header = TRUE, sep = ",", quote = "\"")
# 2. Initial examination of the data -----------

# Use the "str", "head", "tail", "names" and "summary" commands 
# to take a first look at the data

str(ag_pop)
head(ag_pop)
names(ag_pop)
summary(ag_pop)
# 3. Renaming the variables -----

# Rename the last three columns to: 
# District, Population, Seniors

names(ag_pop)[5:7] <- c("District", "Population","Seniors")

# 4. Converting variables to correct format -----------

# you will notice that the "Seniors" variable is in text format and contains %
# we need it in numeric format to continue working with it

ag_pop$Seniors <- as.numeric(gsub("%","",ag_pop$Seniors))
ag_pop$Population <- as.numeric(gsub(",","",ag_pop$Population))

# 5. Computing new variables ----

# Add a new variable to the data frame, "PopulationSeniors",
# which is Population multiplied with Seniors divided by 100

ag_pop$PopulationSeniors <- (ag_pop$Population*ag_pop$Seniors)/100
head(ag_pop)
str(ag_pop)

# 6. Saving -------

# save the data in RData format with the name stored in saveFileName

#write.table(saveFileName, row.names = FALSE, sep = ",")
save(ag_pop, file = saveFileName)
