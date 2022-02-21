rm(list=ls())
# Load/Install stargazer to produce nice R regression outputs
if (!require(stargazer)) {
  install.packages("stargazer") 
  library(stargazer)
}

# Load the data
load('processed/procData.RData')
labels <- c(
  "Stratford-on-Avon" = "Strat. Avon",
  "Nuneaton & Bedworth" = "Nun. Bedw.",
  "North Warwickshire" = "N. Warwick."
)
for (i in names(labels)) {
  aging$District[ which( aging$District == i ) ] <- labels[i]
}

# To output the contents of the first four rows of some data frame, 
# specify the part of the data you would like to use, and set the 
# summary option to FALSE:
stargazer(aging[1:4, 5:8], summary=F, rownames = F, 
          out = 'tables/dataExploration.tex')

# To compute some summary statistics (it ignores non-numeric columns)
stargazer(aging, out = 'tables/summaryStats.tex')
# which is equivalent to 
# YOUR CODE
summaryStats <- round(summaryStats, 3)

# Create a simple regression table with 3 side-by-side models:
# 1. OLS Population (y) on Seniors (x). 
# 2. OLS Population (y) on Seniors (x) controlling by Districts
# 3. Logistic regression High Population (y) on Seniors (x) controlling by Districts,
# where High Population = Population > median(Population).

# Create High Population as new column
# YOUR CODE
# OLS 1:
# YOUR CODE
# OLS 2:
# YOUR CODE
# Logistic Regression:
# YOUR CODE

# create tex table and save it in tables/ as regResults.tex. 
stargazer(ols1, ols2, lr, 
          title = "Results", align=TRUE, out='tables/regResults.tex')

# we can also report the content of vectors and matrices. 
# For instance, let's create a table that contains the correlation matrix
# for Population, Seniors and PopulationSeniors. 
# YOUR CODE
stargazer(correlation.matrix, title = 'Correlation Matrix',
          out = 'tables/corMatrix.tex')

# Alternatively, if you do not want to use latex and just see the results in Rstudio,
# you could simply save the objects of interest as an .Rdata file that you can 
# retrieve later:
save(summaryStats, ols1, ols2, lr, correlation.matrix, 
     file = 'tables/tables.Rdata')