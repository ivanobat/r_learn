# Exercise: Data pre-processing and analysis. 

# We will use the dataset aging-population.2008.csv (available in the data folder)
# to illustrate how to implement a basic data analysis project in R and 
# generate figures and tables to communicate our results

# change the working directory to your own
setwd("/home/ivanobat/gitrepos/r-tutorial-ivanobat/exercises/Rdata/")

# 1. Data pre-processing
source('source/processed/processData.R')

# 2. Perform some basic data analysis
source('source/analysis/demographics.R')

# 3. Produce figure illustrating percentage of seniors in each district
source('source/fig/seniorsPerDistrict.R')

# 4. Produce figure illustrating correlation between population size and 
# percentage of seniors. 
source('source/fig/corPopulationSeniors.R')
# evaluate the function for the districts of your choice:
corPopulationSeniors(c("Rugby", "Warwick", "Stratford-on-Avon"))

# 5. Produce regression/stats tables 
source('source/tables/statsOutput.R')