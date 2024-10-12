# STAT1378_Assignment_2_Problem Set_2
# This assignment was created on the Posit Cloud, and therefore 
# I installed all required packages for it in every single time

# Exercise 1

# Load all required packages and dataset
install.packages("tidyverse")
library(tidyverse)

# Do several simple analysis/check
records <- read.csv("records.csv")
str(records)

# Data Wrangling
records_filtered <- records %>%
  filter(type == "three lap", shortcut == "no shortcut")

# Plots Section
# Plot 1 - How the three lap, with no shortcut world record develop over time

# Filter for 'Three Lap' and 'No Shortcut' records
three_lap_no_shortcut <- records %>%
  filter(type == "Three Lap", shortcut == "No Shortcut")

head(three_lap_no_shortcut)


# Plot part
ggplot(three_lap_no_shortcut, aes(x = date, y = time, color = track)) +
  geom_line() +
  facet_wrap(~ track, scales = "free_y") +
  theme_minimal() +
  labs(title = "How the three lap, with no shortcut world record develop over time")


# Plot 2 - How the WR for Rainbow Road develop over time
rainbow_road_records <- records %>%
  filter(track == "Rainbow Road")

ggplot(rainbow_road_records, aes(x = date, y = time, color = type)) +
  geom_line() +
  facet_wrap(~ shortcut, scales = "free_y") +
  labs(title = "Rainbow Road World Records Over Time by Record Type",
       x = "Date", y = "Time (seconds)") +
  theme_minimal()












