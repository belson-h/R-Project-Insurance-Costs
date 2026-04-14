
glimpse(costs_raw)
summary(costs_raw)
colSums(is.na(costs_raw))

# Missing values in:
# bmi (num) - 28
# exercise_level (cat) - 22
# annual_checkups (num) - 20

# Missing values will be managed case-by-case in the calculations

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

# cleaning and transformation steps (adding age_group and risk_score as new variable)
costs <- costs_raw |> 
  mutate(
    sex =               str_trim(sex),
    sex =               str_trim(sex),
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
  mutate(
    risk_group = case_when(
      prior_claims == 0 & prior_accidents == 0 ~ "Low",
      prior_accidents >= 2 | prior_claims >= 2 ~ "High",
      TRUE ~ "Medium"
    )
  )
  
# validating cleaning steps
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

# validating new variables

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
  


