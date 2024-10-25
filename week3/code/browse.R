#__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
#__version__ = '0.0.1'

Exponential <- function(N0 = 1, r = 1, generations = 10) {
  # Runs a simulation of exponential growth
  # Returns a vector of length generations
  
  N <- rep(NA, generations)    # Creates a vector of NA
  
  N[1] <- N0
  for (t in 2:generations) {
    N[t] <- N[t-1] * exp(r)
    browser()
  }
  return (N)
}

plot(Exponential(), type="l", main="Exponential growth")