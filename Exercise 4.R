# Exercise 4

# Sample dataset D
D <- c(1, 1, 2, 2, 4, 6, 9)

# Calculate MAD
mad_value <- mad(D, constant = 1.4826)

# Compare MAD with standard deviation
sd_value <- sd(D)

# Sensitivity curves (for an arbitrary x change)

sensitivity_sd <- function(x) {
  apply(x, 1, sd)
}

sensitivity_mad <- function(x) {
  apply(x, 1, mad)
}



# Simulation study for efficiency comparison
sensitivity_curve <- function(D, T_func) {
  n <- length(D)
  curves <- numeric(n)
  for (i in 1:n) {
    sample_i <- D[-i]
    T_with_i <- T_func(c(sample_i, data[i]))
    T_without_i <- T_func(sample_i)
    curves[i] <- (T_with_i - T_without_i) / (1/n)
  }
  return(curves)
}

# HD Part
simulate_efficiency <- function(sample_size, num_samples = 10000) {
  sd_values <- numeric(num_samples)
  mad_values <- numeric(num_samples)
  
  for (i in 1:num_samples) {
    sample <- rnorm(sample_size, mean = 0, sd = 1)
    sd_values[i] <- sd(sample)
    mad_values[i] <- mad(sample)
  }
  
  sd_var <- var(sd_values)
  mad_var <- var(mad_values)
  efficiency_ratio <- mad_var / sd_var
  return(efficiency_ratio)
}

# Settings
setting1 <- simulate_efficiency(25, 10000)
setting2 <- simulate_efficiency(100, 10000)
setting3 <- simulate_efficiency(1000, 10000)

# Print results
print(setting1)
print(setting2)
print(setting3)
