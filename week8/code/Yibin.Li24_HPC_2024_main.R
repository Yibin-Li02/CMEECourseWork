# CMEE 2024 HPC exercises R code main pro forma
# You don't HAVE to use this but it will be very helpful.
# If you opt to write everything yourself from scratch please ensure you use
# EXACTLY the same function and parameter names and beware that you may lose
# marks if it doesn't work properly because of not using the pro-forma.

name <- "Your Name"
preferred_name <- "Name"
email <- "abc123@imperial.ac.uk"
username <- "abc123"

# Please remember *not* to clear the work space here, or anywhere in this file.
# If you do, it'll wipe out your username information that you entered just
# above, and when you use this file as a 'toolbox' as intended it'll also wipe
# away everything you're doing outside of the toolbox.  For example, it would
# wipe away any automarking code that may be running and that would be annoying!

# Section One: Stochastic demographic population model

# Function to initialize a state vector where all individuals are adults
state_initialise_adult <- function(num_stages, initial_size) {
  # Create a vector of zeros with length equal to the number of stages
  state <- rep(0, num_stages)
  # Set the last element (adult stage) to the initial size
  state[num_stages] <- initial_size
  return(state)
}

# Function to initialize a state vector with individuals spread evenly across stages
state_initialise_spread <- function(num_stages, initial_size) {
  # Calculate the base number of individuals per stage
  base_number <- floor(initial_size / num_stages)
  # Calculate the remaining individuals
  remainder <- initial_size %% num_stages
  # Create a vector with the base number of individuals in each stage
  state <- rep(base_number, num_stages)
  # Distribute the remainder starting from the youngest stage
  if (remainder > 0) {
    state[1:remainder] <- state[1:remainder] + 1
  }
  return(state)
}

sum_vect <- function(x, y) {
  if (length(x) < length(y)) {
    x <- c(x, rep(0, length(y) - length(x)))
  } else if (length(y) < length(x)) {
    y <- c(y, rep(0, length(x) - length(y)))
  }
  return(x + y)
}

# Example usage:
# state_initialise_adult(num_stages = 4, initial_size = 100)
# state_initialise_spread(num_stages = 4, initial_size = 100)


### Question 1: Deterministic Simulation with Different Initial Conditions
question_1 <- function() {
  # Load the provided demographic simulation code
  source("Demographic.R")
  
  # Define the projection matrix as given in the question
  growth_matrix <- matrix(c(0.1, 0.0, 0.0, 0.0, 
                            0.5, 0.4, 0.0, 0.0, 
                            0.0, 0.4, 0.7, 0.0, 
                            0.0, 0.0, 0.25, 0.4),
                          nrow = 4, ncol = 4, byrow = TRUE)
  reproduction_matrix <- matrix(c(0.0, 0.0, 0.0, 2.6, 
                                  0.0, 0.0, 0.0, 0.0, 
                                  0.0, 0.0, 0.0, 0.0, 
                                  0.0, 0.0, 0.0, 0.0),
                                nrow = 4, ncol = 4, byrow = TRUE)
  projection_matrix <- reproduction_matrix + growth_matrix
  
  # Set the initial conditions
  initial_state_adult <- state_initialise_adult(num_stages = 4, initial_size = 100)
  initial_state_spread <- state_initialise_spread(num_stages = 4, initial_size = 100)
  
  # Run the deterministic simulations
  sim_length <- 24
  result_adult <- deterministic_simulation(initial_state = initial_state_adult, 
                                           simulation_length = sim_length, 
                                           projection_matrix = projection_matrix)
  result_spread <- deterministic_simulation(initial_state = initial_state_spread, 
                                            simulation_length = sim_length, 
                                            projection_matrix = projection_matrix)
  
  # Plot the results
  png("question_1.png")
  plot(0:sim_length, result_adult, type = "l", col = "blue", lwd = 2, 
       ylim = range(c(result_adult, result_spread)), 
       xlab = "Time (Steps)", ylab = "Total Population Size", 
       main = "Deterministic Simulation: Population Size Time Series")
  lines(0:sim_length, result_spread, col = "red", lwd = 2)
  legend("topright", legend = c("100 Adults", "100 Spread"), 
         col = c("blue", "red"), lwd = 2)
  dev.off()
  
  # Output the answer to the question
  cat("Explain how the initial distribution of the population in different life stages affects the initial and eventual population growth.\n")
  cat("The initial distribution of the population affects the growth rate in the early stages of the simulation.\n")
  cat("When the population starts with all individuals in the adult stage, growth is initially slower due to fewer young individuals.\n")
  cat("In contrast, when the population is spread across all stages, growth is initially faster because younger individuals contribute to future adult population.\n")
}

# Example usage:
# question_1()


### Question 2: Stochastic Simulation with Different Initial Conditions
question_2 <- function() {
  # Load the provided demographic simulation code
  source("Demographic.R")
  
  # Define the projection matrix and clutch distribution as given in the question
  growth_matrix <- matrix(c(0.1, 0.0, 0.0, 0.0, 
                            0.5, 0.4, 0.0, 0.0, 
                            0.0, 0.4, 0.7, 0.0, 
                            0.0, 0.0, 0.25, 0.4),
                          nrow = 4, ncol = 4, byrow = TRUE)
  reproduction_matrix <- matrix(c(0.0, 0.0, 0.0, 2.6, 
                                  0.0, 0.0, 0.0, 0.0, 
                                  0.0, 0.0, 0.0, 0.0, 
                                  0.0, 0.0, 0.0, 0.0),
                                nrow = 4, ncol = 4, byrow = TRUE)

  clutch_distribution <- c(0.06, 0.08, 0.13, 0.15, 0.16, 0.18, 0.15, 0.06, 0.03)
  
  # Set the initial conditions
  # The initial_state_adults creates a state vector with all individuals in the adult life stage.
  initial_state_adults <- state_initialise_adult(4, 100)
  
  # The initial_state_spread creates a state vector with individuals evenly distributed across all life stages.
  initial_state_spread <- state_initialise_spread(4, 100)
  simulation_length <- 24
  
  # Run stochastic simulations
  sim1 <- stochastic_simulation(initial_state = initial_state_adults, 
                                growth_matrix = growth_matrix, 
                                reproduction_matrix = reproduction_matrix, 
                                clutch_distribution = clutch_distribution, 
                                simulation_length = simulation_length)
  
  sim2 <- stochastic_simulation(initial_state = initial_state_spread, 
                                growth_matrix = growth_matrix, 
                                reproduction_matrix = reproduction_matrix, 
                                clutch_distribution = clutch_distribution, 
                                simulation_length = simulation_length)
  
  # Create the plot
  png("question_2.png")
  plot(0:simulation_length, sim1, type="l", col="blue", lty=1, 
       xlab="Time Step", ylab="Total Population Size", 
       main="Stochastic Simulation: Population Size Over Time")
  lines(0:simulation_length, sim2, col="red", lty=2)
  legend("topright", legend=c("100 Adults", "100 Spread"), col=c("blue", "red"), lty=1:2)
  dev.off()
  
  # Output answer as plain text
  cat("The stochastic simulations exhibit more variability compared to the deterministic simulations, resulting in less smooth population trajectories. This is because the stochastic model introduces randomness in reproduction and survival, leading to fluctuations that are absent in the deterministic model.")
}
question_2()

# Questions 3 

# Function to carry out simulations on the HPC cluster
question_3 <- function() {
  # Clear the workspace and turn off graphics
  rm(list = ls())
  graphics.off()
  
  # Load the required functions from demographic.R file
  source("Demographic.R")
  
  # Read in the job number from the cluster
  iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
  
  # Set the random number seed for reproducibility
  set.seed(iter)
  
  # Determine the initial condition based on the job number
  if (iter %% 4 == 1) {
    initial_state <- state_initialise_adult(4, 100)  # Large population of 100 adults
  } else if (iter %% 4 == 2) {
    initial_state <- state_initialise_adult(4, 10)   # Small population of 10 adults
  } else if (iter %% 4 == 3) {
    initial_state <- state_initialise_spread(4, 100) # Large population of 100 spread across life stages
  } else {
    initial_state <- state_initialise_spread(4, 10)  # Small population of 10 spread across life stages
  }
  
  # Define the growth and reproduction matrices
  growth_matrix <- matrix(c(0.1, 0.0, 0.0, 0.0, 
                            0.5, 0.4, 0.0, 0.0, 
                            0.0, 0.4, 0.7, 0.0, 
                            0.0, 0.0, 0.25, 0.4), 
                          nrow=4, ncol=4, byrow=TRUE)
  
  reproduction_matrix <- matrix(c(0.0, 0.0, 0.0, 2.6, 
                                  0.0, 0.0, 0.0, 0.0, 
                                  0.0, 0.0, 0.0, 0.0, 
                                  0.0, 0.0, 0.0, 0.0), 
                                nrow=4, ncol=4, byrow=TRUE)
  
  clutch_distribution <- c(0.06, 0.08, 0.13, 0.15, 0.16, 0.18, 0.15, 0.06, 0.03)
  
  # Set up the filename for saving results
  output_file <- paste0("cluster_results_iter_", iter, ".rda")
  
  # Initialise a list to store the results of 150 simulations
  results_list <- vector("list", 150)
  
  # Run 150 stochastic simulations
  for (i in 1:150) {
    results_list[[i]] <- stochastic_simulation(initial_state = initial_state, 
                                               growth_matrix = growth_matrix, 
                                               reproduction_matrix = reproduction_matrix, 
                                               clutch_distribution = clutch_distribution, 
                                               simulation_length = 120) # Run for 120 steps (10 years)
  }
  
  # Save the results
  save(results_list, file = output_file)
}




# Question 4 


# Question 5
question_5 <- function(){
  
  png(filename="question_5", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Question 6
question_6 <- function(){
  
  png(filename="question_6", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}


# Section Two: Individual-based ecological neutral theory simulation 

# Question 7

species_richness <- function(community) {
  return(length(unique(community)))
}
# Question 8

init_community_max <- function(size) {
  return(seq(1, size))
}

# Question 9
init_community_min <- function(size){
  return(rep(1, size))
}

# Question 10
choose_two <- function(max_value){
  
}

# Question 11
neutral_step <- function(community){
  
}

# Question 12
neutral_generation <- function(community){
  
}

# Question 13
neutral_time_series <- function(community,duration)  {
  
}

# Question 14
question_8 <- function() {
  
  
  
  png(filename="question_14", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Question 15
neutral_step_speciation <- function(community,speciation_rate)  {
  
}

# Question 16
neutral_generation_speciation <- function(community,speciation_rate)  {
  
}

# Question 17
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  
}

# Question 18
question_18 <- function()  {
  
  png(filename="question_18", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Question 19
species_abundance <- function(community)  {
  
}

# Question 20
octaves <- function(abundance_vector) {
  
}

# Question 21
sum_vect <- function(x, y) {
  
}

# Question 22
question_22 <- function() {
  
  png(filename="question_22", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Question 23
neutral_cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name) {
    
}

# Questions 24 and 25 involve writing code elsewhere to run your simulations on
# the cluster

# Question 26 
process_neutral_cluster_results <- function() {
  
  
  combined_results <- list() #create your list output here to return
  # save results to an .rda file
  
}

plot_neutral_cluster_results <- function(){

    # load combined_results from your rda file
  
    png(filename="plot_neutral_cluster_results", width = 600, height = 400)
    # plot your graph here
    Sys.sleep(0.1)
    dev.off()
    
    return(combined_results)
}


# Challenge questions - these are substantially harder and worth fewer marks.
# I suggest you only attempt these if you've done all the main questions. 

# Challenge question A
Challenge_A <- function(){
  
  png(filename="Challenge_A", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
}

# Challenge question B
Challenge_B <- function() {
  
  png(filename="Challenge_B", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
}

# Challenge question C
Challenge_B <- function() {
  
  png(filename="Challenge_C", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()

}

# Challenge question D
Challenge_D <- function() {
  
  png(filename="Challenge_D", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
}

# Challenge question E
Challenge_E <- function() {
  
  png(filename="Challenge_E", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

