# CMEE 2024 HPC exercises R code main pro forma
# You don't HAVE to use this but it will be very helpful.
# If you opt to write everything yourself from scratch please ensure you use
# EXACTLY the same function and parameter names and beware that you may lose
# marks if it doesn't work properly because of not using the pro-forma.

name <- "Yibin Li"
preferred_name <- "Yibin"
email <- "yl2524@imperial.ac.uk"
username <- "yl2524"

# Please remember *not* to clear the work space here, or anywhere in this file.
# If you do, it'll wipe out your username information that you entered just
# above, and when you use this file as a 'toolbox' as intended it'll also wipe
# away everything you're doing outside of the toolbox.  For example, it would
# wipe away any automarking code that may be running and that would be annoying!

# Section One: Stochastic demographic population model
source("Demographic.R")
library(ggplot2)
# Question 0: Initialize population states
state_initialise_adult <- function(num_stages, initial_size) {
  state <- rep(0, num_stages)
  state[num_stages] <- initial_size
  return(state)
}

state_initialise_spread <- function(num_stages, initial_size) {
  base <- floor(initial_size / num_stages)
  remainder <- initial_size %% num_stages
  state <- rep(base, num_stages)
  if (remainder > 0) {
    state[1:remainder] <- state[1:remainder] + 1
  }
  return(state)
}

sum_vect <- function(x, y) {
  len_diff <- length(x) - length(y)
  
  if (len_diff > 0) {
    y <- c(y, rep(0, len_diff))  # Pad y if shorter
  } else if (len_diff < 0) {
    x <- c(x, rep(0, -len_diff))  # Pad x if shorter
  }
  
  return(x + y)
}

# Question 1: Deterministic Simulation and Plot
question_1 <- function() {

  
  initial_adult <- state_initialise_adult(4, 100)
  initial_spread <- state_initialise_spread(4, 100)
  
  growth_matrix <- matrix(c(0.1, 0.0, 0.0, 0.0,
                            0.5, 0.4, 0.0, 0.0,
                            0.0, 0.4, 0.7, 0.0,
                            0.0, 0.0, 0.25, 0.4),
                          nrow=4, ncol=4, byrow=TRUE)
  
  projection_matrix <- growth_matrix + matrix(c(0, 0, 0, 2.6,
                                                0, 0, 0, 0,
                                                0, 0, 0, 0,
                                                0, 0, 0, 0),
                                              nrow=4, ncol=4, byrow=TRUE)
  
  sim1 <- deterministic_simulation(initial_adult, projection_matrix, 24)
  sim2 <- deterministic_simulation(initial_spread, projection_matrix, 24)
  
  png("question_1.png", width=600, height=400)
  plot(0:24, sim1, type="l", col="blue", ylim=range(c(sim1, sim2)),
       xlab="Time Steps", ylab="Population Size", main="Deterministic Simulation")
  lines(0:24, sim2, col="red")
  legend("topright", legend=c("100 Adults", "100 Spread"), col=c("blue", "red"), lty=1)
  Sys.sleep(0.1)
  dev.off()
  
  return("The initial distribution of the population across life stages influences both short-term and long-term growth. A population starting with only adults experiences rapid initial growth due to immediate reproduction but may face short-term instability as the adult cohort ages. In contrast, a population spread across all life stages grows more steadily, ensuring continuous recruitment and long-term stability. A balanced life stage distribution supports sustained population growth, while an adult-heavy population benefits from an early surge but may experience fluctuations.")
}

# Question 2: Stochastic Simulation and Plot
question_2 <- function() {

  
  initial_adult <- state_initialise_adult(4, 100)
  initial_spread <- state_initialise_spread(4, 100)
  
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
  
  sim1 <- stochastic_simulation(initial_adult, growth_matrix, reproduction_matrix, clutch_distribution, 24)
  sim2 <- stochastic_simulation(initial_spread, growth_matrix, reproduction_matrix, clutch_distribution, 24)
  
  png("question_2.png", width=600, height=400)
  plot(0:24, sim1, type="l", col="blue", ylim=range(c(sim1, sim2)),
       xlab="Time Steps", ylab="Population Size", main="Stochastic Simulation")
  lines(0:24, sim2, col="red")
  legend("topright", legend=c("100 Adults", "100 Spread"), col=c("blue", "red"), lty=1)
  dev.off()
  
  return("The deterministic simulation produces smooth population growth curves because it assumes a fixed, predictable transition of individuals between life stages based on constant probabilities. In contrast, the stochastic simulation introduces random variation in survival, reproduction, and transitions between life stages, leading to fluctuations in population size over time. These variations make the stochastic simulation appear more jagged and irregular compared to the smooth deterministic model, reflecting the natural uncertainty and randomness in real-world population dynamics.")
}

# Questions 3 and 4 involve writing code elsewhere to run your simulations on the cluster


# Question 5
# Load necessary library


# Function to process results and generate the extinction probability plot
question_5 <- function() {
  
  # Define initial condition labels
  init_conditions <- c("big_adult", "small_adult", "big_spread", "small_spread")
  
  # Initialize extinction counters
  extinction_counts <- setNames(rep(0, length(init_conditions)), init_conditions)
  total_counts <- setNames(rep(0, length(init_conditions)), init_conditions)
  
  # Loop over simulation files
  for (iter in 1:100) {
    file_name <- paste0("demographic_cluster_", iter, ".rda")
    
    if (file.exists(file_name)) {
      load(file_name)  # Load the .rda file, which contains `simulation_results`
      
      # Determine the initial condition
      if (iter < 26) {
        condition <- "big_adult"
      } else if (iter < 51) {
        condition <- "small_adult"
      } else if (iter < 76) {
        condition <- "big_spread"
      } else {
        condition <- "small_spread"
      }
      
      # Count total simulations
      total_counts[condition] <- total_counts[condition] + length(simulation_results)
      
      # Count extinctions (final population size == 0)
      extinction_counts[condition] <- extinction_counts[condition] + sum(sapply(simulation_results, function(sim) tail(sim, 1) == 0))
    }
  }
  
  # Compute extinction proportions
  extinction_proportions <- extinction_counts / total_counts
  
  # Create dataframe for plotting
  df <- data.frame(
    Initial_Condition = names(extinction_proportions),
    Extinction_Probability = extinction_proportions
  )
  
  # Open PNG device with required size (600x400 pixels)
  png("question_5.png", width = 600, height = 400, units = "px", bg = "white")
  
  # Plot extinction probabilities with white background
  extinction_plot <- ggplot(df, aes(x = Initial_Condition, y = Extinction_Probability, fill = Initial_Condition)) +
    geom_bar(stat = "identity") +
    theme_minimal(base_size = 14) +
    labs(title = "Extinction Probability by Initial Condition",
         x = "Initial Condition",
         y = "Proportion of Simulations Resulting in Extinction") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1),
          panel.background = element_rect(fill = "white", colour = NA),
          plot.background = element_rect(fill = "white", colour = NA),
          panel.grid.major = element_line(colour = "gray90"),
          panel.grid.minor = element_line(colour = "gray95"))
  
  # Print the plot to save it
  print(extinction_plot)
  
  # Close PNG device
  Sys.sleep(0.1)
  dev.off()
  
  return("The small_spread population was most likely to go extinct due to its low initial size and spread across life stages, delaying reproduction and increasing vulnerability to stochastic fluctuations. Smaller populations face higher extinction risk as random mortality events can quickly lead to collapse, unlike larger or adult-concentrated populations that ensure immediate reproduction and stability.")
  
}

# Question 6
question_6 <- function() {
  # Load stochastic simulation results
  file_list <- list.files(pattern = "demographic_cluster_.*\\.rda")
  simulation_results <- list()
  
  # Identify relevant initial conditions (big_spread and small_spread)
  condition_labels <- c("big_spread", "small_spread")
  results_by_condition <- list("big_spread" = list(), "small_spread" = list())
  
  for (file in file_list) {
    load(file)  # Loads variable `simulation_results`
    
    # Determine which condition this file represents
    iter <- as.numeric(gsub("demographic_cluster_|\\.rda", "", file))
    
    if (iter > 50 && iter < 76) {
      condition <- "big_spread"
    } else if (iter >= 76) {
      condition <- "small_spread"
    } else {
      next  # Ignore files that are not of interest
    }
    
    results_by_condition[[condition]] <- append(results_by_condition[[condition]], simulation_results)
  }
  
  # Compute mean population size for each time step
  mean_population_trends <- list()
  
  for (condition in condition_labels) {
    all_sims <- do.call(rbind, results_by_condition[[condition]])  # Convert list to matrix
    mean_population_trends[[condition]] <- colMeans(all_sims, na.rm = TRUE)  # Average across simulations
  }
  
  # Compute deterministic model results
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
  
  projection_matrix <- growth_matrix + reproduction_matrix
  sim_length <- 120  # Simulation duration in months
  
  deterministic_big <- deterministic_simulation(state_initialise_spread(4, 100), projection_matrix, sim_length)
  deterministic_small <- deterministic_simulation(state_initialise_spread(4, 10), projection_matrix, sim_length)
  
  # Compute deviation (stochastic mean / deterministic)
  deviation_big <- mean_population_trends[["big_spread"]] / deterministic_big
  deviation_small <- mean_population_trends[["small_spread"]] / deterministic_small
  
  # Create plot
  png("question_6.png", width = 600, height = 400)
  plot(0:sim_length, deviation_big, type = "l", col = "blue", ylim = range(c(deviation_big, deviation_small)),
       xlab = "Time Steps", ylab = "Deviation (Stochastic/Deterministic)", 
       main = "Deviation of Stochastic Model from Deterministic Model")
  lines(0:sim_length, deviation_small, col = "red")
  legend("topright", legend = c("Large Mixed", "Small Mixed"), col = c("blue", "red"), lty = 1)
  
  Sys.sleep(0.1)
  dev.off()
  
  # Return textual explanation
  return("The Large Mixed initial condition is more appropriate for approximating the average behavior of the stochastic system with a deterministic model.The deviation for Large Mixed remains closer to 1, meaning that the average stochastic behavior closely follows the deterministic model.Larger populations are less affected by random fluctuations in survival and reproduction, making their behavior more predictable and aligning more closely with deterministic expectations. Thus, the deterministic model provides a reasonable approximation for Large Mixed.")
}


# Section Two: Individual-based ecological neutral theory simulation 

# Question 7
species_richness <- function(community){
  return(length(unique(community)))  # Count unique species in the community
}

# Question 8
# returns a sequence of 1 : max_size of community, representing an initial state 
# of the community with the maximum possible number of species, with each species
# referenced by an index number between 1 and max_size
init_community_max <- function(size){
  return(seq(1, size))  # Assign each individual a unique species ID
}

# Question 9
# returns a sequence of length max_size, containing all 1s.
# an alternative initial state of the community with the minimum possible
# number of species (monodominance of one species, with index 1)
init_community_min <- function(size){
  return(rep(1, size))
}
# Question 10

choose_two <- function(max_value){
  return(sample(1:max_value, 2, replace = FALSE))
}


# Question 11
neutral_step <- function(community){
  replace <- choose_two(length(community)) # picks two individuals at random
  # one individual is replaced by the species of the other
  community[replace[1]] <- community[replace[2]]
  return(community)
}

# Question 12
# calculate state of community after ONE generation has passed,
# where one generation is number of individuals divided by 2

neutral_generation <- function(community){
  size <- length(community)
  for (i in 1:floor(size / 2)) {  # Each generation consists of size/2 neutral steps
    community <- neutral_step(community)
  }
  return(community)
}

# Question 13
neutral_time_series <- function(community, duration){
  richness_values <- numeric(duration + 1)
  richness_values[1] <- species_richness(community)
  
  for (t in 1:duration){
    community <- neutral_generation(community)
    richness_values[t + 1] <- species_richness(community)
  }
  
  return(richness_values)
}

# Question 14
question_14 <- function(){
  initial_community <- init_community_max(100)
  duration <- 200  # Run for 200 generations
  
  richness_over_time <- neutral_time_series(initial_community, duration)
  
  png("question_14.png", width=600, height=400)
  plot(0:duration, richness_over_time, type='l', col='blue', lwd=2, xlab="Time Step", ylab="Species Richness",
       main="Neutral Model Simulation: Species Richness Over Time")
  Sys.sleep(0.1)
  dev.off()
  
  return("The system will always converge to a state of monoculture, where only one species remains. This occurs due to genetic drift in a finite population, where random fluctuations in species abundance eventually lead to the loss of all but one species. Without external forces like migration or mutation, diversity declines until only a single species persists.")
}


# Question 15
neutral_step_speciation <- function(community, speciation_rate){
  chosen <- choose_two(length(community))
  if (runif(1) < speciation_rate) {
    community[chosen[2]] <- max(community) + 1  # Introduce a new species
  } else {
    community[chosen[2]] <- community[chosen[1]]
  }
  return(community)
}

# Question 16


neutral_generation_speciation <- function(community, speciation_rate){
  size <- length(community)
  for (i in 1:floor(size / 2)) {
    community <- neutral_step_speciation(community, speciation_rate)
  }
  return(community)
}

# calculate state of community after ONE generation has passed, including the 
# possibility of speciation
neutral_generation_speciation <- function(community,speciation_rate)  {
  # if statements to ensure rounding of odd community numbers averages to
  # correct half value over time
  x <- runif(1)
  if (x < 0.5){ 
    steps <- floor((length(community) / 2))
  }
  else{
    steps <- ceiling((length(community) / 2))
  }
  # calculate state of community at each step
  for (i in 1:steps){
    community <- neutral_step_speciation(community, speciation_rate)
  }
  return(community)
}

# Question 17
neutral_time_series_speciation <- function(community, speciation_rate, duration){
  richness_values <- numeric(duration + 1)
  richness_values[1] <- species_richness(community)
  
  for (t in 1:duration){
    community <- neutral_generation_speciation(community, speciation_rate)
    richness_values[t + 1] <- species_richness(community)
  }
  
  return(richness_values)
}


# Question 18: Perform a Neutral Theory Simulation with Speciation and Compare Initial Conditions
question_18 <- function(){
  graphics.off()  # Clear any existing plots
  duration <- 200  # Set simulation duration
  speciation_rate <- 0.1  # Set speciation rate
  
  # Simulate species richness over time for two different initial conditions
  richness_max_init <- neutral_time_series_speciation(init_community_max(100), speciation_rate, duration)
  richness_min_init <- neutral_time_series_speciation(init_community_min(100), speciation_rate, duration)
  
  # Determine the y-axis range, ensuring it starts from 0
  y_min <- 0
  y_max <- max(c(richness_max_init, richness_min_init))
  
  # Plot results
  png("question_18.png", width=600, height=400)
  plot(0:duration, richness_max_init, type="l", col="#D55E00", lwd=2, xlab="Time (Generations)", 
       ylab="Species Richness", main="Neutral Model Simulation: Effect of Initial Conditions",
       ylim=c(y_min, y_max))  # Ensuring the y-axis starts from 0
  lines(0:duration, richness_min_init, col="#56B4E9", lwd=2)
  
  legend("topright", legend=c("Maximum Initial Conditions", "Minimum Initial Conditions"),
         col=c("#D55E00", "#56B4E9"), lwd=2, bty="n")
  
  dev.off()
  
  return("Initial species richness influences early diversity, but over time, both conditions converge to a similar equilibrium level of species richness. This occurs because speciation counteracts extinction, maintaining diversity regardless of starting conditions. The neutral model assumes all species are functionally equivalent, so initial differences diminish as stochastic events and speciation shape the community over generations.")
}




# Question 19
species_abundance <- function(community){
  return(sort(as.numeric(table(community)), decreasing=TRUE))  # Convert to numeric to remove species names  # Count individuals per species and sort
}


# Question 20
octaves <- function(abundance_vector){
  return(table(floor(log2(abundance_vector) + 1)))  # Compute octave bins using log base 2
}



# Question 21

sum_vect <- function(x, y) {
  len_diff <- length(x) - length(y)
  
  if (len_diff > 0) {
    y <- c(y, rep(0, len_diff))  # Pad y if shorter
  } else if (len_diff < 0) {
    x <- c(x, rep(0, -len_diff))  # Pad x if shorter
  }
  
  return(x + y)
}
# Question 22
question_22 <- function() {
  graphics.off()  # Clear any existing plots
  duration <- 200  # Burn-in period
  total_generations <- 2200  # Total simulation time (200 burn-in + 2000 recording phase)
  record_interval <- 20  # Record every 20 generations
  speciation_rate <- 0.1
  community_size <- 100
  
  # Run simulations for both initial conditions
  community_max <- init_community_max(community_size)
  community_min <- init_community_min(community_size)
  
  # Burn-in phase
  community_max <- neutral_time_series_speciation(community_max, speciation_rate, duration)
  community_min <- neutral_time_series_speciation(community_min, speciation_rate, duration)
  
  # Recording phase
  octaves_max <- list()
  octaves_min <- list()
  
  for (gen in seq(duration, total_generations, by=record_interval)) {
    community_max <- neutral_generation_speciation(community_max, speciation_rate)
    community_min <- neutral_generation_speciation(community_min, speciation_rate)
    
    octaves_max[[length(octaves_max) + 1]] <- octaves(species_abundance(community_max))
    octaves_min[[length(octaves_min) + 1]] <- octaves(species_abundance(community_min))
  }
  
  # Compute mean octaves
  mean_octaves_max <- Reduce(sum_vect, octaves_max) / length(octaves_max)
  mean_octaves_min <- Reduce(sum_vect, octaves_min) / length(octaves_min)
  
  # Plot results
  png("question_22.png", width=600, height=400)
  par(mfrow=c(1,2))
  barplot(mean_octaves_max, main="Species Abundance (Max Init)", xlab="Octave", ylab="Mean Count")
  barplot(mean_octaves_min, main="Species Abundance (Min Init)", xlab="Octave", ylab="Mean Count")
  Sys.sleep(0.1)
  dev.off()
  return("The initial condition affects early diversity but has little long-term impact on species abundance distribution. Over time, both simulations converge to a similar pattern due to stochastic drift and speciation balancing extinction. This shows that while initial diversity influences short-term dynamics, long-term community structure is primarily shaped by neutral processes.")
}



# Question 23
neutral_cluster_run <- function(speciation_rate, size, wall_time, interval_rich, 
                                interval_oct, burn_in_generations, output_file_name) {
  
  # Start the timer
  start_time <- proc.time()[3]
  
  # Initialize the community with minimal diversity (all individuals belong to one species)
  community <- rep(1, size)
  
  # Initialize data structures to store simulation results
  time_series <- c()
  abundance_list <- list()
  
  # Initialize generation counter
  generation <- 0
  
  # Run the simulation until the allotted wall time is exceeded
  repeat {
    
    # Update generation counter
    generation <- generation + 1
    
    # Perform one generation step with speciation
    community <- neutral_generation_speciation(community, speciation_rate)
    
    # Record species richness during burn-in phase
    if (generation <= burn_in_generations && generation %% interval_rich == 0) {
      time_series <- c(time_series, species_richness(community))
    }
    
    # Record species abundance as octaves after burn-in phase
    if (generation > burn_in_generations && generation %% interval_oct == 0) {
      abundance_list[[length(abundance_list) + 1]] <- octaves(species_abundance(community))
    }
    
    # Check elapsed time
    elapsed_time <- proc.time()[3] - start_time
    if (elapsed_time > wall_time * 60) {
      break
    }
  }
  
  # Save results
  total_time <- proc.time()[3] - start_time
  save(time_series, abundance_list, community, total_time, generation,
       speciation_rate, size, wall_time, interval_rich, 
       interval_oct, burn_in_generations, 
       file = output_file_name)
}





# Questions 24 and 25 involve writing code elsewhere to run your simulations on
# the cluster

# Question 26 

process_neutral_cluster_results <- function() {
  # Define the four community sizes
  community_sizes <- c(500, 1000, 2500, 5000)
  
  # Initialize lists to store summed octaves and counts
  combined_results <- setNames(vector("list", length(community_sizes)), as.character(community_sizes))
  snapshot_counts  <- setNames(rep(0, length(community_sizes)), as.character(community_sizes))
  
  # Get list of all .rda files
  file_list <- list.files(pattern = "neutral_cluster_output_.*\\.rda")
  
  # Iterate over each .rda file
  for (file in file_list) {
    load(file)  # Typically loads variables: `abundance_list`, `size`, etc.
    
    # Ensure `size` is valid and among the expected community_sizes
    if (!exists("size") || !size %in% community_sizes) {
      next
    }
    size_key <- as.character(size)
    
    # If not yet initialized, set up a long enough sum vector
    if (is.null(combined_results[[size_key]]) || length(combined_results[[size_key]]) == 0) {
      combined_results[[size_key]] <- rep(0, 50)  # 50 bins to be safe
    }
    
    # Add up all octave snapshots in `abundance_list`
    # and keep track of how many snapshots total
    for (octave_vec in abundance_list) {
      if (length(octave_vec) > 0) {
        # Pad & sum
        len_diff <- length(combined_results[[size_key]]) - length(octave_vec)
        padded_oct <- octave_vec
        if (len_diff > 0) {
          padded_oct <- c(octave_vec, rep(0, len_diff))
        } else if (len_diff < 0) {
          # If an octave is longer than combined_results
          combined_results[[size_key]] <- c(combined_results[[size_key]], rep(0, -len_diff))
        }
        combined_results[[size_key]] <- combined_results[[size_key]] + padded_oct
        
        # Increment snapshot count by 1 for each snapshot
        snapshot_counts[[size_key]] <- snapshot_counts[[size_key]] + 1
      }
    }
  }
  
  # Now divide each size's summed octaves by the total # of snapshots
  for (sz in names(combined_results)) {
    if (snapshot_counts[[sz]] > 0) {
      combined_results[[sz]] <- combined_results[[sz]] / snapshot_counts[[sz]]
      # Optionally trim trailing zeros if needed
      while (length(combined_results[[sz]]) > 0 && tail(combined_results[[sz]], 1) == 0) {
        combined_results[[sz]] <- combined_results[[sz]][-length(combined_results[[sz]])]
      }
    }
  }
  
  # Save processed data
  save(combined_results, file = "processed_neutral_results.rda")
  cat("Processed results saved in 'processed_neutral_results.rda'\n")
}

# Function to plot results from processed .rda data
plot_neutral_cluster_results <- function() {
  # Load processed data
  load("processed_neutral_results.rda")
  
  # Check if data is valid
  if (!exists("combined_results") || length(combined_results) == 0) {
    stop("Error: No processed results found. Run process_neutral_cluster_results() first.")
  }
  
  # Convert list to a data frame for ggplot2
  plot_data <- data.frame()
  
  for (size in names(combined_results)) {
    octave_vector <- combined_results[[size]]
    
    if (length(octave_vector) > 0) {
      df <- data.frame(
        Octave = seq_along(octave_vector),
        Mean_Abundance = as.numeric(octave_vector),
        Community_Size = factor(size, levels = c("500", "1000", "2500", "5000"))  # Factor to ensure correct order
      )
      plot_data <- rbind(plot_data, df)
    }
  }
  
  # Ensure dataset is not empty
  if (nrow(plot_data) == 0) {
    stop("Error: No data available for plotting. Check if process_neutral_cluster_results() worked correctly.")
  }
  
  # Open PNG device with specified size and white background
  png("plot_neutral_cluster_results.png", width = 600, height = 400, units = "px", bg = "white")
  
  # Create the multi-panel bar plot
  plot <- ggplot(plot_data, aes(x = factor(Octave), y = Mean_Abundance)) +
    geom_bar(stat = "identity", fill = "steelblue") +
    facet_wrap(~ Community_Size, scales = "free") +
    labs(title = "Mean Species Abundance Octave Distribution",
         x = "Octave",
         y = "Mean Species Abundance") +
    theme_minimal(base_size = 14) +  # Clean theme
    theme(
      panel.background = element_rect(fill = "white", colour = NA),  # White panel background
      plot.background = element_rect(fill = "white", colour = NA),   # White outer background
      panel.grid.major = element_line(colour = "gray90"),
      panel.grid.minor = element_line(colour = "gray95"),
      plot.title = element_text(hjust = 0.5, face = "bold", size = 16)  # Centered and bold title
    )
  

  print(plot)
  Sys.sleep(0.1)
  dev.off()
  return(combined_results)
}

# Run the updated plotting function




# Challenge questions - these are substantially harder and worth fewer marks.
# I suggest you only attempt these if you've done all the main questions. 

# Challenge question A
create_challenge_A_data <- function(){
  # Load ggplot2 if needed (for consistency)
  library(ggplot2)
  
  # Initialize an empty list to store all results
  all_simulations <- list()
  
  # Loop through all cluster simulation files
  file_list <- list.files(pattern = "demographic_cluster_.*\\.rda")
  sim_id <- 1
  
  for (file in file_list) {
    load(file)  # Loads `simulation_results`
    
    # Determine the initial condition based on file name or job number
    iter <- as.numeric(gsub("demographic_cluster_|\\.rda", "", file))
    
    if (iter <= 25) {
      condition <- "Large Adult"
    } else if (iter <= 50) {
      condition <- "Small Adult"
    } else if (iter <= 75) {
      condition <- "Large Mixed"
    } else {
      condition <- "Small Mixed"
    }
    
    # Convert each simulation run into long-form data
    for (sim in 1:length(simulation_results)) {
      df <- data.frame(
        simulation_number = sim_id,
        initial_condition = condition,
        time_step = seq(0, length(simulation_results[[sim]]) - 1),
        population_size = simulation_results[[sim]]
      )
      all_simulations[[length(all_simulations) + 1]] <- df
      sim_id <- sim_id + 1
    }
  }
  
  # Combine all individual data frames into a single long-form data frame
  population_size_df <- do.call(rbind, all_simulations)
  
  # Save the data frame for future use
  save(population_size_df, file = "challenge_A_results.rda")
  
}

Challenge_A <- function(){
  # Check that the RDA file exists
  if (!file.exists("challenge_A_results.rda")) {
    stop("Error: challenge_A_results.rda does not exist. Run create_challenge_A_results() first.")
  }
  
  # Load the saved data
  load("challenge_A_results.rda")  # Loads population_size_df
  
  library(ggplot2)
  
  # Define custom colors for initial conditions
  custom_colors <- c("Large Adult" = "#FF6A6A",   # Red
                     "Small Adult" = "#8B008B",   # Blue
                     "Large Mixed" = "#FFA07A",   # Green
                     "Small Mixed" = "#BFEFFF")   # Orange
  
  # Open PNG device to save the plot
  png("challenge_A.png", width = 600, height = 400)
  
  # Create the plot with ggplot2
  plot <- ggplot(population_size_df, aes(x = time_step, y = population_size, 
                                         group = simulation_number, 
                                         colour = initial_condition)) +
    geom_line(alpha = 0.1, linewidth = 0.5) +
    scale_color_manual(values = custom_colors) +
    theme_minimal(base_size = 14) +
    labs(title = "Stochastic Simulation Population Trends",
         x = "Time Step",
         y = "Population Size",
         colour = "Initial Condition") +
    theme(
      legend.position = "right",
      legend.title = element_text(size = 14),
      legend.text = element_text(size = 12),
      legend.key.size = unit(2, "lines"),
      plot.title = element_text(hjust = 0.5, face = "bold", size = 16)) +
    guides(color = guide_legend(override.aes = list(linewidth = 20)))
  
  print(plot) 
  Sys.sleep(0.1)
  dev.off()
}

# Challenge question B
create_challenge_B_results <- function() {
  # Set parameters
  num_simulations <- 100  # Number of independent simulations
  duration <- 2200        # Total generations
  speciation_rate <- 0.1
  community_size <- 100
  
  # Store species richness results
  richness_max <- matrix(NA, nrow = num_simulations, ncol = duration + 1)
  richness_min <- matrix(NA, nrow = num_simulations, ncol = duration + 1)
  
  # Run simulations for both initial conditions
  for (i in 1:num_simulations) {
    community_max <- init_community_max(community_size)
    community_min <- init_community_min(community_size)
    
    richness_max[i, ] <- neutral_time_series_speciation(community_max, speciation_rate, duration)
    richness_min[i, ] <- neutral_time_series_speciation(community_min, speciation_rate, duration)
  }
  
  # Compute mean and confidence intervals (97.2% CI)
  mean_max <- colMeans(richness_max, na.rm = TRUE)
  mean_min <- colMeans(richness_min, na.rm = TRUE)
  
  se_max <- apply(richness_max, 2, sd, na.rm = TRUE) / sqrt(num_simulations)
  se_min <- apply(richness_min, 2, sd, na.rm = TRUE) / sqrt(num_simulations)
  
  ci_max <- qnorm(0.986) * se_max  # 97.2% confidence interval
  ci_min <- qnorm(0.986) * se_min
  
  # Estimate dynamic equilibrium (when species richness stabilizes)
  equilibrium_gen <- which(abs(diff(mean_max)) < 0.01 & abs(diff(mean_min)) < 0.01)[1]
  
  # Save all the computed results into an RDA file
  save(num_simulations, duration, speciation_rate, community_size, richness_max, richness_min,
       mean_max, mean_min, se_max, se_min, ci_max, ci_min, equilibrium_gen,
       file = "challenge_B_results.rda")
  

}




Challenge_B <- function() {
  if (!file.exists("challenge_B_results.rda")) {
    stop("Error: challenge_B_results.rda does not exist. Run create_challenge_B_results() first.")
  }
  
  # Load the saved results
  load("challenge_B_results.rda")  # Loads: num_simulations, duration, speciation_rate, community_size,
  # richness_max, richness_min, mean_max, mean_min, se_max, se_min, ci_max, ci_min, equilibrium_gen
  
  # Open PNG device to generate the plot
  png("challenge_B.png", width = 600, height = 400)
  
  # Plot the mean species richness over time for both initial conditions
  plot(0:duration, mean_max, type = "l", col = "red", lwd = 2,
       ylim = range(c(mean_max - ci_max, mean_max + ci_max, mean_min - ci_min, mean_min + ci_min)),
       xlab = "Generations", ylab = "Species Richness", main = "Mean Species Richness Over Time")
  
  lines(0:duration, mean_min, col = "blue", lwd = 2)
  
  # Add confidence intervals as shaded regions
  polygon(c(0:duration, rev(0:duration)),
          c(mean_max - ci_max, rev(mean_max + ci_max)),
          col = adjustcolor("red", alpha.f = 0.2), border = NA)
  polygon(c(0:duration, rev(0:duration)),
          c(mean_min - ci_min, rev(mean_min + ci_min)),
          col = adjustcolor("blue", alpha.f = 0.2), border = NA)
  
  legend("bottomright", legend = c("Max Initial Richness", "Min Initial Richness"), col = c("red", "blue"), lwd = 2)
  Sys.sleep(0.1)
  dev.off()
  

  return(paste("The system reaches dynamic equilibrium after approximately", 
               equilibrium_gen, 
               "generations."))
  
}




# Challenge question C
create_challenge_C_results <- function() {
  # Parameters
  community_size <- 100  # Number of individuals
  duration <- 200        # Number of generations to simulate
  speciation_rate <- 0.1 # Speciation probability per replacement
  num_repeats <- 50      # Number of simulations per initial richness level
  
  # Fixed richness levels
  richness_levels <- c(1, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
  results_list <- list()
  
  # Function to initialize community with a given richness level
  init_community <- function(size, richness) {
    community <- sample(1:richness, size, replace = TRUE)  # Each individual gets a species ID
    return(community)
  }
  
  # Run simulations for each richness level
  for (richness in richness_levels) {
    time_series_matrix <- matrix(NA, nrow = num_repeats, ncol = duration + 1)
    
    for (rep in 1:num_repeats) {
      community <- init_community(community_size, richness)
      # Assumes that neutral_time_series_speciation is defined elsewhere in your workspace
      time_series_matrix[rep, ] <- neutral_time_series_speciation(community, speciation_rate, duration)
    }
    
    # Compute average species richness over time
    avg_richness <- colMeans(time_series_matrix, na.rm = TRUE)
    results_list[[as.character(richness)]] <- avg_richness
  }
  
  # Convert results to a long-form data frame for ggplot2
  results_df <- data.frame(
    Generation = rep(0:duration, times = length(richness_levels)),
    Richness = unlist(results_list),
    Initial_Richness = rep(richness_levels, each = duration + 1)
  )
  
  # Save the processed data to an RDA file
  save(results_df, file = "challenge_C_results.rda")

}


Challenge_C <- function() {
  # Check if the RDA file exists
  if (!file.exists("challenge_C_results.rda")) {
    stop("Error: challenge_C_results.rda does not exist. Run create_challenge_C_results() first.")
  }
  
  # Load the saved results (results_df)
  load("challenge_C_results.rda")  # Loads the variable: results_df
  
  # Load required package
  library(ggplot2)
  
  # Open PNG device
  png("challenge_C.png", width = 600, height = 400)
  
  # Plot with white background and centered bold title
  print(ggplot(results_df, aes(x = Generation, y = Richness, 
                               color = as.factor(Initial_Richness), group = Initial_Richness)) +
          geom_line(linewidth = 0.45, alpha = 1) +
          labs(title = "Averaged Species Richness Time Series", 
               x = "Generation", y = "Mean Species Richness", 
               color = "Initial Richness") +
          theme_minimal(base_size = 14) +
          theme(panel.background = element_rect(fill = "white", color = NA),
                plot.background = element_rect(fill = "white", color = NA),
                panel.grid.major = element_line(color = "gray90"),
                panel.grid.minor = element_line(color = "gray95"),
                legend.background = element_rect(fill = "white", color = NA),
                legend.key = element_rect(fill = "white", color = NA),
                plot.title = element_text(hjust = 0.5, face = "bold", size = 16)))
  
  # Close PNG device
  Sys.sleep(0.1)
  dev.off()
  

}

# Challenge question D
create_challenge_D_results <- function() {
  
  # Define the four community sizes
  community_sizes <- c(500, 1000, 2500, 5000)
  
  # Lists to store results
  richness_data_list <- list()
  burn_in_times <- list()
  
  # Load and process each .rda file
  file_list <- list.files(pattern = "neutral_cluster_output_.*\\.rda")
  
  for (target_size in community_sizes) {  # Loop through the expected sizes
    all_richness <- list()
    
    for (file in file_list) {
      load(file)  # Loads `time_series` and `size`
      
      if (exists("size") && exists("time_series") && is.numeric(size) && !is.null(time_series)) {
        if (size == target_size) {  # Correct filtering condition
          all_richness[[length(all_richness) + 1]] <- time_series
        }
      }
    }
    
    # Ensure data is collected for this community size
    if (length(all_richness) > 0) {
      richness_matrix <- simplify2array(all_richness)  # Handles varying lengths
      mean_richness <- rowMeans(richness_matrix, na.rm = TRUE)
      
      # Ensure all values are finite
      mean_richness <- mean_richness[is.finite(mean_richness)]
      
      # Set default stable index if burn-in not found
      stable_idx <- which(abs(diff(mean_richness)) < 0.01)[1]
      if (is.na(stable_idx)) {
        stable_idx <- 1  # Default to 1 if no stability detected
      }
      
      burn_in_times[[as.character(target_size)]] <- stable_idx
      
      # Store in a data frame
      richness_data_list[[as.character(target_size)]] <- data.frame(
        Generation = seq_len(length(mean_richness)),  # Corrected x-axis labels
        Mean_Species_Richness = mean_richness
      )
    }
  }
  
  # Save the processed results to an RDA file
  save(richness_data_list, burn_in_times, file = "challenge_D_results.rda")

}



Challenge_D <- function() {
  
  # Check if the RDA file exists
  if (!file.exists("challenge_D_results.rda")) {
    stop("Error: challenge_D_results.rda does not exist. Run create_challenge_D_results() first.")
  }
  
  # Load the processed data
  load("challenge_D_results.rda")  # Loads richness_data_list and burn_in_times
  
  # Define the four community sizes (should match those used earlier)
  community_sizes <- c(500, 1000, 2500, 5000)
  
  # Open PNG device and set 2x2 layout
  png("challenge_D.png", width = 600, height = 400)
  par(mfrow = c(2, 2))  # Arrange plots in a 2x2 grid
  
  # Define colors for each plot
  colors <- c("red", "yellow", "green", "blue")
  
  # Plot each community size in a 2x2 layout
  for (i in seq_along(community_sizes)) {
    size <- community_sizes[i]
    
    if (!is.null(richness_data_list[[as.character(size)]])) {
      df <- richness_data_list[[as.character(size)]]
      
      plot(df$Generation, df$Mean_Species_Richness, type = "l", col = colors[i], 
           xlab = "Generation", ylab = "Mean Species Richness",
           main = paste("Size", size))
      
      if (!is.null(burn_in_times[[as.character(size)]])) {
        abline(v = burn_in_times[[as.character(size)]], col = "black", lty = "dashed")
        legend("bottomright", legend = paste("Stable:", burn_in_times[[as.character(size)]]), 
               bty = "n", text.col = "black")
      }
    } else {
      plot(1, type = "n", xlab = "", ylab = "", main = paste("Size", size))
      text(1, 1, "No Data Available", cex = 1.5)
    }
  }
  
  # Close PNG device
  Sys.sleep(0.1)
  dev.off()

}


# Challenge question E

#############################################################
# 1) Create HPC summary .rda
#############################################################
create_challenge_E_data <- function(
    rda_pattern = "^neutral_cluster_output_.*\\.rda$",
    out_rda     = "Challenge_E_results.rda"
) {
  # Helper to sum two named integer vectors, padding if needed
  sum_vect <- function(x, y) {
    len_diff <- length(x) - length(y)
    if (len_diff > 0) {
      y <- c(y, rep(0, len_diff))
    } else if (len_diff < 0) {
      x <- c(x, rep(0, -len_diff))
    }
    return(x + y)
  }
  
  # 1. Find all HPC .rda files
  files <- list.files(pattern = rda_pattern)
  if (length(files) == 0) {
    stop("No .rda files found matching pattern: ", rda_pattern)
  }
  
  # 2. Initialize data structures
  #    HPC_data[["J_v"]] = list of replicate mean octaves
  HPC_data <- list()
  
  # 3. Iterate over each HPC file
  for (ff in files) {
    load(ff)  # Typically loads 'size', 'speciation_rate', 'abundance_list', ...
    
    # Check that the needed variables exist:
    if (!exists("size") || !exists("speciation_rate") || !exists("abundance_list")) {
      cat("Warning: file", ff, "is missing size/speciation_rate/abundance_list.\n")
      next
    }
    
    # Create a key like "500_0.1"
    key <- paste0(size, "_", speciation_rate)
    
    if (is.null(HPC_data[[key]])) {
      HPC_data[[key]] <- list()
    }
    
    # 4. Summarize each file's abundance_list into a single “mean octave”
    #    (in case abundance_list had multiple snapshots)
    oct_sum <- rep(0, 50)
    valid_count <- 0
    for (octv in abundance_list) {
      if (length(octv) > 0) {
        oct_sum <- sum_vect(oct_sum, octv)
        valid_count <- valid_count + 1
      }
    }
    if (valid_count > 0) {
      mean_oct <- oct_sum / valid_count
      HPC_data[[key]][[ length(HPC_data[[key]]) + 1 ]] <- mean_oct
    }
  }
  
  if (length(HPC_data) == 0) {
    stop("No valid HPC data found in the .rda files.")
  }
  
  # 5. Combine HPC replicate means for each (J, v) into HPC_final
  HPC_final <- list()
  for (k in names(HPC_data)) {
    replicates <- HPC_data[[k]]
    if (!length(replicates)) {
      cat("No HPC replicates for key =", k, "\n")
      next
    }
    # Sum all replicate means, then average
    sum_oct <- rep(0, 50)
    for (octv in replicates) {
      sum_oct <- sum_vect(sum_oct, octv)
    }
    HPC_final[[k]] <- sum_oct / length(replicates)
    
    # Trim trailing zeros
    while (length(HPC_final[[k]]) > 0 && tail(HPC_final[[k]], 1) == 0) {
      HPC_final[[k]] <- HPC_final[[k]][ -length(HPC_final[[k]]) ]
    }
  }
  
  # 6. Save the results to an .rda
  save(HPC_data, HPC_final, file = out_rda)
  cat("Created HPC summary in", out_rda, "\n")
}

#############################################################
# 2) Create Coalescence vs HPC comparison plot
#############################################################
Challenge_E <- function(
    in_rda            = "Challenge_E_results.rda",
    out_png           = "challenge_E.png",
    hpc_total_hours   = 11.5  # HPC ran in parallel for 11.5 hours
) {
  # 0) Helper functions
  sum_vect <- function(x, y) {
    len_diff <- length(x) - length(y)
    if (len_diff > 0) {
      y <- c(y, rep(0, len_diff))
    } else if (len_diff < 0) {
      x <- c(x, rep(0, -len_diff))
    }
    return(x + y)
  }
  
  octaves <- function(ab_vec) {
    return(table(floor(log2(ab_vec)) + 1))
  }
  
  coalescence_simulation <- function(J, v) {
    # "theta" = v*(J-1)/(1-v)
    lineages <- rep(1, J)
    abundances <- c()
    N <- J
    theta <- v * (J - 1) / (1 - v)
    
    while (N > 1) {
      i <- sample(seq_len(N), 1)
      # Probability of speciation
      p_speciation <- theta / (theta + N - 1)
      if (runif(1) <= p_speciation) {
        abundances <- c(abundances, lineages[i])
      } else {
        # coalescence
        j <- sample(seq_len(N)[-i], 1)
        lineages[i] <- lineages[i] + lineages[j]
        lineages <- lineages[-j]
      }
      N <- N - 1
    }
    abundances <- c(abundances, lineages[1])
    return(abundances)
  }
  
  # 1) Load HPC summary
  if (!file.exists(in_rda)) {
    stop("File does not exist: ", in_rda)
  }
  load(in_rda)  
  # => HPC_data, HPC_final
  
  if (!exists("HPC_data") || !exists("HPC_final")) {
    stop("Missing HPC_data / HPC_final in .rda file.")
  }
  
  # 2) For each (J, v), run coalescence as many times as HPC had replicates
  Coalescence_final <- list()
  Coalescence_time  <- list()
  
  for (k in names(HPC_final)) {
    # HPC_data[[k]] is the list of replicate means => # HPC replicates
    n_coal_reps <- length(HPC_data[[k]])
    if (n_coal_reps < 1) {
      cat("No HPC replicates => skip coalescence for key =", k, "\n")
      next
    }
    
    # parse (J, v)
    parts <- strsplit(k, "_")[[1]]
    J <- as.numeric(parts[1])
    v <- as.numeric(parts[2])
    
    cat("\nRunning coalescence for (J=", J, ", v=", v, "), replicates =", n_coal_reps, "\n")
    
    t0 <- proc.time()[3]
    oct_sum <- rep(0, 50)
    for (r in seq_len(n_coal_reps)) {
      ab <- coalescence_simulation(J, v)
      ab_oct <- octaves(ab)
      oct_sum <- sum_vect(oct_sum, ab_oct)
    }
    ctime <- proc.time()[3] - t0
    Coalescence_time[[k]] <- ctime
    
    coalesc_mean <- oct_sum / n_coal_reps
    # Trim trailing zeros
    while (length(coalesc_mean) > 0 && tail(coalesc_mean, 1) == 0) {
      coalesc_mean <- coalesc_mean[-length(coalesc_mean)]
    }
    Coalescence_final[[k]] <- coalesc_mean
  }
  
  # 3) Build data frame for plotting HPC vs Coalescence
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Please install ggplot2.")
  }
  library(ggplot2)
  
  plot_data <- data.frame()
  for (k in names(HPC_final)) {
    if (is.null(Coalescence_final[[k]])) next
    
    HPC_vec  <- HPC_final[[k]]
    Coal_vec <- Coalescence_final[[k]]
    
    max_len  <- max(length(HPC_vec), length(Coal_vec))
    HPC_pad  <- c(HPC_vec, rep(0, max_len - length(HPC_vec)))
    Coal_pad <- c(Coal_vec, rep(0, max_len - length(Coal_vec)))
    
    df_k <- rbind(
      data.frame(key = k, bin = seq_len(max_len), count = HPC_pad,  source = "HPC"),
      data.frame(key = k, bin = seq_len(max_len), count = Coal_pad, source = "Coalescence")
    )
    plot_data <- rbind(plot_data, df_k)
  }
  
  # Make friendlier facet labels, e.g. "J=500, v=0.1"
  plot_data$FacetLabel <- sapply(plot_data$key, function(x) {
    sp <- strsplit(x, "_")[[1]]
    sprintf("J=%s, v=%s", sp[1], sp[2])
  })
  
  # 4) Create multi‐panel barplot
  png(out_png, width=600, height=400)
  g <- ggplot(plot_data, aes(x = factor(bin), y = count, fill = source)) +
    geom_bar(position = "dodge", stat = "identity") +
    facet_wrap(~ FacetLabel, scales = "free_y") +
    labs(x = "Octave bin (log2 abundance)", 
         y = "Mean species count",
         title = "Neutral HPC vs. Coalescence: Species‐Abundance Distributions") +
    theme_minimal(base_size = 14)
  print(g)
  Sys.sleep(0.1)
  dev.off()
  
  # 5) Summarize CPU hours: HPC vs Coalescence (all with print)
  
  # Print header
  print("==========================================")
  print("         HPC vs. Coalescence TIMING       ")
  print("==========================================")
  
  # HPC total hours is 11.5 (parallel run)
  print("Total HPC CPU hours:")
  print(11.5)
  
  # Compute total coalescence hours across all keys
  total_coal_hours <- 0
  for (k in names(Coalescence_time)) {
    total_coal_hours <- total_coal_hours + (Coalescence_time[[k]] / 3600)
  }
  
  print("Total Coalescence CPU hours:")
  print(total_coal_hours)
  print("")
  
  # If you also want a detailed breakdown per (J, v), do:
  for (k in names(Coalescence_time)) {
    # Optional details for each scenario:
    coal_sec   <- Coalescence_time[[k]]
    coal_hours <- coal_sec / 3600
    print(paste("Key:", k))
    print(paste("  Coalescence seconds:", round(coal_sec, 2)))
    print(paste("  Coalescence hours:  ", round(coal_hours, 4)))
  }
  
  # Finally, print the reason coalescence is so much faster:
  print("Coalescence simulates the population backwards in time, merging lineages until only one ancestor remains. This bypasses the need to model every birth‐death event forward through many generations, drastically reducing the total number of operations. By contrast, standard neutral simulations must track each individual at every timestep, which quickly becomes very expensive as the population size and generations grow.")

}













