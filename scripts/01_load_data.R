
library(tidyverse)
library(patchwork)

# Loads the data set to an object
costs_raw <- read_csv("data/insurance_costs.csv")

# Gives an overview of the data set
glimpse(costs_raw)
summary(costs_raw)

# Checks number of NA per column
colSums(is.na(costs_raw))

# Shows number of distinct values per column
costs_raw |> 
  count(sex)
costs_raw |> 
  count(region)
costs_raw |> 
  count(smoker)
costs_raw |> 
  count(chronic_condition)
costs_raw |> 
  count(exercise_level)
costs_raw |> 
  count(plan_type)


