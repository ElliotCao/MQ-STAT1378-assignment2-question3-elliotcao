# Exercise 2

# Exercise 2 Sydney house price

# Install and load all required packages

install.packages(c("janitor","here","dplyr","lubridate"))

library(janitor)
library(here)
library(lubridate)
library(dplyr)

# Load two dataset and rename them simply
aus_prices <- read.csv("aus_median_house_price.csv")
aus_gdp <- read.csv("aus_GDP_changes.csv")

# Load and clean up aus_median_house_price.csv data 
# Load and clean column names
aus_prices <- read.csv(here("aus_median_house_price.csv")) %>%
  clean_names()

head(aus_prices)

# Clean and filter Sydney Median prices
sydney_median_prices <- aus_prices %>%
  select(x,
         contains("Median.Price.of.Established.House.Transfers..Unstratified.....Syd"))

head(sydney_median_prices)
colnames(sydney_median_prices)
str(sydney_median_prices)


# Plot Section
# Plot 1 - Median Price of Established House Transfers in Sydney
# Replace the column name in the y aesthetic with the exact name wrapped in backticks

ggplot(sydney_median_prices, aes(x = x, y = 'Median.Price.of.Established.House.Transfers..Unstratified.....Sydney..')) +
  geom_line(aes(group = 1)) +
  labs(title = "Median House Prices in Sydney") +
  theme_minimal()

# Adjust the column name accordingly based on the cleaned output ERROR
ggplot(sydney_median_prices, aes(x = x, y = 'Median.Price.of.Established.House.Transfers..Unstratified.....Sydney..')) +
  geom_line(aes(group = 1)) +
  labs(title = "Sydney Median House Price Over Time",
       y = "A$ ('000)", x = "Year") +
  theme_minimal()



filtered_data <- sydney_median_prices %>%
  filter(x == "Year") %>%
  select('median_price_of_established_house_transfers_unstratified_sydney', x)


ggplot(filtered_data, aes(x = `Median.Price.of.Established.House.Transfers..Unstratified.....Sydney..`, y = X)) +
  geom_point() +
  labs(x = "median_price_of_established_house_transfers_unstratified_sydney", y = "Year") +
  theme_minimal()


# d.Identify low GDP growth periods (GDP change less than 0.1%)
aus_gdp <- aus_gdp %>%
  mutate(low_growth = GDP_changes < 0.1)

# e.Create the second plot with shaded areas
ggplot(sydney_median_prices, aes(x = date, y = 'median_price_of_established_house_transfers_unstratified_sydney')) +
  geom_line(color = "blue") +
  geom_rect(data = aus_gdp %>% filter(low_growth),
            aes(xmin = start_date, xmax = end_date, ymin = -Inf, ymax = Inf),
            fill = "gray", alpha = 0.3) +
  labs(title = "Sydney Median House Price with Low GDP Growth Periods",
       y = "A$ ('000)", x = "Year") +
  theme_minimal()


# Run all tests
test()


# Merge the datasets based on time ERROR
merged_data <- sydney_median_prices %>%
  left_join(gdp_changes, by = "Year")

# Visualise house prices with low GDP growth periods shaded
ggplot(merged_data, aes(x = Year, y = Median_Price)) +
  geom_line() +
  geom_rect(data = merged_data %>% filter(low_growth), aes(xmin = Year, xmax = Year + 1, ymin = -Inf, ymax = Inf), alpha = 0.2) +
  labs(title = "Sydney House Prices with Low GDP Growth Periods Shaded", 
       x = "Year", y = "Median Price (in thousands)")