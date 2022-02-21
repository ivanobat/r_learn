# ----------------------------------------------------------------------
# Information
# ----------------------------------------------------------------------

# This script produces figure that illustrates  
# percentage of seniors in each district

# see "seniorsPerDistrict.pdf" for how the final result should look like

# house cleaning
rm(list=ls())
setwd("/home/ivanobat/gitrepos/r-tutorial-ivanobat/exercises/Rdata/")
# 0. Loading data and packages --------------------------------------------

# load ggplot2 for plotting
library('ggplot2')
# load processed data
load('processed/procData.RData')
head(ag_pop)
# 1. Preparing data for the plots ---------

# Renaming the values in the District variable

# Use "unique" command to get the list of all district names in the dataset
unique(ag_pop$District)

# Notice that some values, like "North Warwickshire" are quite long, this
# will not look good on a figure, so it would be good if we would shorten
# the names a bit. Change the following values in District variable:
# 
# "Stratford-on-Avon" -> "Strat. Avon"
# "Nuneaton & Bedworth" -> "Nun. Bedw."
# "North Warwickshire" -> "N. Warwick."

labels <- c(
  "Stratford-on-Avon" = "Strat. Avon",
  "Nuneaton & Bedworth" = "Nun. Bedw.",
  "North Warwickshire" = "N. Warwick."
)
labels
# create a short for loop that would iterate over the labels vector,
# check for those elements in the District variable (in the aging data frame)
# that have value on the left hand side (element names) and change it with 
# the value on the right hand side (elements in the labels vector)

for (name in names(labels)){
  ag_pop[ag_pop$District == name,]$District <- labels[name]
}

# check the result using unique function
unique(ag_pop$District)
# you should get 
# [1] "Rugby" "Strat. Avon" "Nun. Bedw." "Warwick" "N. Warwick."

# 2. Overall mean percentage of seniors---------

aggregate(ag_pop$Seniors~1,
          data = ag_pop , 
          FUN = mean)

# 3. Figure -------
# Using ggplot2, write a code that will generate the figure:
# - use the "aging" data frame
# - you will find more comments interspersed within figure code, 
#   ggplot figures consist of layers, each layer connected with + 
#   operator, e.g. layer that plots boxplots, layer that plots points etc
#figure <- 
  
# boxplot(ag_pop$Seniors ~ ag_pop$District, 
#          data = ag_pop, 
#          ylab = "% Seniors from Population",
#          xlab = "UK District",
#          notch = F,
#          plot = T)  


  figure <- ggplot(ag_pop, aes(x=District, y=Seniors)) +
  geom_boxplot() +
  geom_jitter(color="black", size=0.4, alpha=0.9) +
  stat_summary(fun = mean, color = "green", position = position_dodge(0.75),
               geom = "point", shape = 18, size = 3,
               show.legend = FALSE) +
  theme(
    legend.position="none",
    plot.title = element_text(size=11)
  ) +
  ggtitle("% Seniors by District") +
  xlab("UK district") +
  ylab("% Seniors from Population") +
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 5))
  
figure

  # you need at least one layer to plot a figure with the ggplot
  # as a first layer we will plot the box plots of the distributions 
  # of observations for districts

  
  # plot the points and apply the so called jitter - displace the 
  # position of points horizontally in random fashion

  
  # set the names for the x and y axis
  # set the limits of the y axis to 0 to 50, and set the breaks
  # to go from 0 to 50 in steps of 5 

  # create a horizontal illustrating the mean percentage of seniors
  # set it to the value you have computed above, "meanSeniors"
  
  # the figure already looks quite good, but you can use the "theme" to 
  # specify some details further, like color of the background etc
  # I use it to make the figures correspond more to Tufte's prescriptions
  # for good graphics (see https://www.edwardtufte.com/tufte/books_vdqi)



# 4. Save it in png format ---------

# - first set the filename and its extension - png
# - then call the png device with this filename and print the figure,
#   you might want to check height, width and resolution parameters 
ggsave("SeniorsByDistrict.png", device = "png")
# 5. save it in a PDF format--------

# - do the same as above, but now for pdf format
# tip: use the cairo_pdf device.

ggsave("SeniorsByDistrict.pdf", device="pdf")