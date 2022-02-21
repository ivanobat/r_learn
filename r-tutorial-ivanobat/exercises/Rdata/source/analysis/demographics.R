# ----------------------------------------------------------------------
# Information
# ----------------------------------------------------------------------

# This script is for doing a basic data analysis. 


# ----------------------------------------------------------------------
# Loading data
# ----------------------------------------------------------------------

# house cleaning
rm(list = ls())
setwd("/home/ivanobat/gitrepos/r-tutorial-ivanobat/exercises/Rdata/")

# load the data

load("processed/procData.RData")
head(ag_pop)
str(ag_pop)
# ----------------------------------------------------------------------
# Basic demographic information 
# ----------------------------------------------------------------------

# output of this analysis will be printed out to a text file called "demographics.txt"
# start writing to an output file with the function sink()
sink('analysis/demographics.txt')


# ----
# 1. Compute the average population in each district
# ----

# - tip: check out "tapply" command

# it helps to print a message what the part is about to delimit output
# in the resulting text file
print("1. The average population in each district")

# analysis

result <- tapply(ag_pop$Population, ag_pop$District, mean)

# print out
print(result)


# ----
# 2. Compute the mean and variance of Seniors in North Warwickshire,
#    Arley and Whitacre ward
# ----

print("2. The mean and variance of Seniors in North Warwickshire, Arley and Whitacre ward")

# analysis
filtered_ag_pop <- ag_pop[ag_pop$District == "North Warwickshire" & ag_pop$Ward.Name == "Arley and Whitacre",]

result <- aggregate(filtered_ag_pop$Seniors~
                    filtered_ag_pop$Ward.Name + filtered_ag_pop$District, 
                    data = filtered_ag_pop , 
                    FUN = function(x) c(mean(x), sd(x)))
names(result) <- c('Ward Name', 'District', 'Variable')
# print out
print(result)

# ----
# 3. Compute the correlation between the Population and Seniors
# ----

print("3. The correlation between the Population and Seniors")

# analysis
result <- cor(ag_pop$Population, ag_pop$Seniors)
# Scatterplot
plot(x = ag_pop$Population, y = ag_pop$Seniors, ylab = "% Seniors",
     xlab = "Population", pch = 16, col='black' )

# Linear regression line
# Intercept ~ Slope
abline(lm(Seniors ~ Population, data=ag_pop), col = "red")

# print out
print(result)

# stop writing to the file
sink()