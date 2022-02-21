# ----------------------------------------------------------------------
# Information
# ----------------------------------------------------------------------

# This script is defining exercises with basic concepts in programming
# with R - drawing random numbers. 


# ----------------------------------------------------------------------
# Exercises
# ----------------------------------------------------------------------

# house keeping, its a good practice to clean the workspace
rm(list = ls())

# Lets first draw some (say, 1000) random numbers from Uniform distribution,
# you would usually use histogram to check the shape of the distribution
x <- runif(1000)
hist(x)

# It is enough to have Uniform random numbers and we can create other 
# distributions given uniform. How do we get uniformly distributed numbers?
# one algorithm is Linear Congruential Generator
# see: https://en.wikipedia.org/wiki/Linear_congruential_generator


# ----
# 1. Create a function that generates Bernoulli draws. 
# ----

# For details on Bernoulli distributions, see:
# https://en.wikipedia.org/wiki/Bernoulli_process

# We will use this example to illustrate the acceptance-rejection method
# for drawing random numbers from arbitrary distribution (von Neumann, 1951). 
# see: https://en.wikipedia.org/wiki/Rejection_sampling

# function arguments:
# n = number of draws (0's and 1's)
# p = probability with which 1 will be drawn

bernoulli <- function(n, p){
    x <- runif(n)
    return(ifelse(x < p, 1, 0))
}

rbinom(10,1, 0.2)
# check it out
set.seed(1234)
bernoulli(10, 0.2)

# try to verify whether it really draws them correctly more thoroughly
all.equal(
    mean(bernoulli(100000, 0.2)),
    0.2, 
    tolerance = 0.01
)


# ----
# 2. Created an artifical dataset
# ----

# Creating artificial datasets is important for testing the algorithms, 
# because here you know the ground truth and you can evaluate clearly how well
# a method is performing.

# function arguments:
# n = number of observations
# w = weights of the linear model
# sd = sd of the error term

rlinmod <- function(n, w, sd) {
    y = c()
    x = c()
    # check that w has length of 2
    stopifnot(is.numeric(w) && length(w) == 2)

    # lets draw observations for x from a uniform distribution
    x = runif(n)

    # and then generate y as a function of x and some optional error
    # a linear model of the form: w0 + w1*x1 + u
    # use matrix multiplication operator    

    #normal method
    #y = w[1] + w[2] * x + rnorm(n, sd=sd)
    #matrix method
    e <- rnorm(n, sd=sd)
    w <- c(w[1],w[2],1)
    M <- cbind(rep(1,n), x, e)
    w <- c(w[1], w[2], 1)
    y <- c(M %*% w)
    # put x and y in a dataframe
    df <- data.frame(y, x)
    # return the dataframe
    return(df)
}

# lets try it out
set.seed(1234)
data <- rlinmod(200, c(5,3), 2)
head(data)

# output should be:
#          y         x
# 1 6.170157 0.1137034
# 2 5.917461 0.6222994
# 3 6.959811 0.6092747
# 4 5.865183 0.6233794
# 5 5.930749 0.8609154
# 6 7.254910 0.6403106
# ...

# scatterplot of the data
plot(data)


# ----
# 3. Monte Carlo simulations: Law of Large Numbers
# ----

# define a dice of 12 faces and use "sample" function to draw 4 dice throws
dice <- 1:12
sample(dice, 4, replace = TRUE)

# What is the expected value?

# using analytical formula: if U[a,b], E[X] = [a + b ]/2
m <- mean(range(dice))
# variance is V[X] = [(b-a+1)^2 -1]/12
vx <- ((max(dice)-min(dice)+1)**2-1)/12

# simulate draws (many) to check the veracity of these formulae
# these are called monte carlo simulations.
# Simulate 4000 draws, obtain the sample average and sample variance.
# Plot a barplot of the draws.
# YOUR CODE

# now compute the distribution of the mean of a sample of size n = 3? 
# Save the simulated sample means in a vector named MC
# 1. set seed
# 2. set repetition
# 3. loop through all elements of the repetition

# what happens if you increase the sample size to 20?
# recognize the Law of Large Numbers
# YOUR CODE

