# Exercise 3
# Install and load required packages

install.packages("usethis")
install.packages("devtools")
install.packages("testthat")
install.packages("tibble")

library(usethis)
library(devtools)
library(testthat)
library(tibble)

# Create a new package by using usethis
usethis::create_package("MyMultiserverPackage")


usethis::use_testthat()

usethis::use_test("Multiserver")





# Include the bank dataset and document it
usethis::use_data(bank)

# Set up unit tests using testthat
usethis::use_testthat()
test_that("Arrival time is correct", {
  expect_true(all(arrival_time >= 0))
})


# Load bank.csv
usethis::use_data_raw("bank")
bank_data <- read.csv("data-raw/bank.csv")
usethis::use_data(bank_data, overwrite = TRUE)

# Use usethat to test


# documents
devtools::document()


# Git section

# git init

# git add .

# git commit -m "Initial commit of Multiserver package"

# git remote add origin https://github.com/ElliotCao/MQ-STAT1378-assignment2-question3-elliotcao
# git branch -M main
# git push -u origin main



# test new package

library(MyMultiserverPackage)

arrival <- c(0, 60, 120)
service <- c(30, 45, 40)
Multiserver(arrival, service, servers = 2)


# Final check
devtools::check()
