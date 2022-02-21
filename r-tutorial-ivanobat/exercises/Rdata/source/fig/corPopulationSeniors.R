rm(list=ls())
setwd("/home/ivanobat/gitrepos/r-tutorial-ivanobat/exercises/Rdata/")
library(ggplot2)
load('processed/procData.RData')
head(ag_pop)
corPopulationSeniors <- function(districts){
  print("just something to test")
  filtered_ag_pop <- ag_pop[ag_pop$District %in% districts,]
  figure <- ggplot(filtered_ag_pop, aes(x=Population, y=Seniors)) + 
    geom_point() + 
    geom_smooth(method="lm", se = FALSE) +
    facet_wrap(~District)
  return(figure)
}
corPopulationSeniors(c("North Warwickshire","Rugby"))
  # Preparing data for plots
  # 1. Subset the data frame ----
  # filter out districts not listed in districts
  #
  # 2. Plot with ggplot2 ----
  # use the "agingFiltered" data frame.
  # you will find more comments interspersed within figure code

    # you need at least one layer to plot a figure with the ggplot
    #
    # as a first layer we will plot the observations as points
    #
    # add a linear model fit to the data
    #
    # to plot scatter 
    # to plot scatter plot separately for each district, you can use
    # "facet_wrap", this is one of the biggest advantages of ggplot over 
    # base graphics
  # 
    
    # set the names for the x and y axis
    # set the limits of the y axis to 1 to 4.5, and set the breaks
    # to go from 1 to 4.5 in steps of 0.5 
  # YOUR CODE
    
    # you can use the "theme" to specify some details further
  # YOUR CODE
  
  # 3. Save the figure ----
  # png format
  # YOUR CODE
  # pdf format
  # YOUR CODE

