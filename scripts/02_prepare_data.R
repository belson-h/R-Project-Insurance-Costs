
glimpse(costs_raw)
summary(costs_raw)
colSums(is.na(costs_raw))

# Missing values in:
# bmi (num) - 28
# exercise_level (cat) - 22
# annual_checkups (num) - 20

# Missing values will be....manage NA - e.g impute or ignore them in calculations

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
  )


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


# ----------------------
# new variables:

# age_groups
costs <- costs |> 
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
  )


