rm(list = ls())
# 0. Simulation ---------

set.seed(42)
# Create a matrix where:
#  - Each row represents a runner i=20
#  - Each column represents a race j=10
#  - The (i,j)th entry is N(mu_i, 0.2^2), and mu_i is N(10.5,0.1^2). 
nrunners <- 20
nraces <- 10
runners_means <- rnorm(20, mean = 10.5, sd = 0.1**2)

races <- matrix(rnorm(nrunners*nraces, mean = rep(runners_means,nraces), sd = 0.2**2), nrow=nrunners, ncol=nraces)
runner_names <- paste0('Runner',1:nrunners)
race_names <- paste0('Race',1:nraces)
dimnames(races) <- list(runner_names, race_names)

races_df <- data.frame(races)
races_df

# Create a matrix where:
#  - Each row represents a runner i 
#  - Each column represents a race j 
#  - The (i,j)-entry is N(mu_i, 0.2^2) with probability p = 0.8, 
#   and with probability p = 0.2 is NA. 

#Missing NA version

# 1. Simple ranking ----------------
# Get the name of the winner of each race 
# (Hint: use names() and which.min())
races_df
winners <- apply(races_df,2, function(races_df) names(races_df[which.min(races_df)]))
#### use this to get the names
# function(x) names(x[which.min(x)])
winners

# Get a ranking of runners based on their number of wins
# (Hint: use table() and sort it)

runners_rank <- sort(table(winners), decreasing = TRUE)
runners_rank

# 2. Advanced ranking -------------
# Build a function that given a named vector, 
# it returns the names of the top 3 Runners.

top_three_runners <- function(race){
  xordered <- race[order(race)]
  result <- t(names(xordered[1:3]))
  return (result)
}
top_three_runners

# Apply this function to every race

top_three_by_race <- apply(races_df, 2, top_three_runners)
unlist(as.list(top_three_by_race))

# Assign 5 points to the winner, 3 to the runner up, 
# and 1 to the third one in a dataframe format.

top_three_points <- function(){
  return(c(5,3,1))
}

top_three_by_race_w_points <- apply(top_three_by_race, 2, top_three_points)
top_three_by_race_w_points

# Apply this function to each race to obtain a list of dataframes.

# YOUR CODE

# Use rbind recursively to combine these into a single dataframe

####
# join them together in one table

# YOUR CODE

# Use the aggregate function to get the total points by Runner:

####
# function should be sum passing the ranking df to it

# YOUR CODE

# 3. Expand Grid ------------
# Generate y = Xb + e, 
# where X is n x 2 (uniform draws), b_true is 2 x 1,
# and e is N(0,1). 
# Compute the beta that minimizes mean square error by using
# expand.grid().

# Create the MSE function
###
# the MSE = mean((y-Xb)**2) where xb is a matrix multiplication
# b is free choosing
# E = rnorm(n) where n is 100 for some reason


# YOUR CODE

# Use expand.grid() to compute the combinations

# YOUR CODE

# Compute MSE for each combo and add it as a column

# YOUR CODE

# Return the betas with lowest MSE

# YOUR CODE
