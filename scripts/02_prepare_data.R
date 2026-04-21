
# Cleaning and transformation steps:
# - manages NA-values
# - cleans values
# - converts categorical values to factor
# - creates new variables: age_group, risk_group

costs <- costs_raw |> 
  # managing na-values:
  # creates missingness indicator variables for each column with NA values (good for regression)
  mutate(
    bmi_missing =             if_else(is.na(bmi), 1, 0),
    annual_checkup_missing =  if_else(is.na(annual_checkups), 1, 0),
    exercise_level_missing =  if_else(is.na(exercise_level), 1, 0),
    # imputing columns with NA values
    bmi =               replace_na(bmi, median(bmi, na.rm = TRUE)),
    exercise_level =    replace_na(exercise_level, "Unknown"),
    annual_checkups =   replace_na(
      annual_checkups, 
      median(annual_checkups, na.rm = TRUE))
  ) |> 
  # trim & to_title -> cleans values
  # as.factor -> makes categorical values a factor
  mutate(
    sex =               str_trim(sex),
    sex =               str_to_title(sex),
    region =            str_trim(region),
    region =            str_to_title(region),
    smoker =            str_trim(smoker),
    smoker =            str_to_title(smoker),
    chronic_condition = str_trim(chronic_condition),
    chronic_condition = str_to_title(chronic_condition),
    exercise_level =    str_trim(exercise_level),
    exercise_level =    str_to_title(exercise_level),
    plan_type =         str_trim(plan_type),
    plan_type =         str_to_title(plan_type),
    sex =               as.factor(sex),
    region =            as.factor(region),
    smoker =            as.factor(smoker),
    chronic_condition = as.factor(chronic_condition),
    exercise_level =    as.factor(exercise_level),
    plan_type =         as.factor(plan_type)
  ) |> 
  # creates a new variable: age_group 
  mutate(
    age_group = case_when(
      age >= 18 & age <= 30 ~ "18-30",
      age >= 31 & age <= 40 ~ "31-40",
      age >= 41 & age <= 50 ~ "41-50",
      age >= 51 & age <= 60 ~ "51-60",
      age >= 61 & age <= 75 ~ "61-75",
      TRUE ~ NA_character_
    ),
    age_group = factor(
      age_group,
      levels = c("18-30", "31-40", "41-50", "51-60", "61-75"),
      ordered = TRUE
    ) 
  ) |> 
  # creates a new variable: risk_group
  mutate(
    risk_group = case_when(
      prior_claims == 0 & prior_accidents == 0 ~ "Low",
      prior_accidents >= 2 | prior_claims >= 2 ~ "High",
      TRUE ~ "Medium"
    )
  )

# -------------------------------------------
# Validating transformation steps:

# Validating values i transformed columns
costs |> 
  count(sex)
costs |> 
  count(region)
costs |> 
  count(smoker)
costs |> 
  count(chronic_condition)
costs |> 
  count(exercise_level)
costs |> 
  count(plan_type)

# Validating missing values
colSums(is.na(costs))

# Validating new variables:

# age_group
costs |> 
  group_by(age_group) |> 
  summarise(
    n = n(),
    avg_cost = mean(charges, na.rm = TRUE)
  )

# risk_group
costs |> 
  group_by(risk_group) |> 
  summarise(
    n = n(),
    avg_cost = mean(charges, na.rm = TRUE)
  )
  


