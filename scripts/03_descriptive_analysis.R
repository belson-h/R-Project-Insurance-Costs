# Du ska skapa minst 4 relevanta figurer och/eller tabeller, och varje figur eller tabell ska följas av en kort tolkning.
# Question 1: How costs are distributed?
# Question 2: What variables are interesting to further explore?
# Question 3: If there are interesting distinctions between groups?

# Summary statistics table (missing values removed)

charges_summary <- costs |>
  summarise(
    n_charges       = n(),
    mean_charges    = mean(charges, na.rm = TRUE),
    median_charges  = median(charges, na.rm = TRUE),
    sd_charges      = sd(charges, na.rm = TRUE),
    min_charges     = min(charges, na.rm = TRUE),
    max_charges     = max(charges, na.rm = TRUE),
    iq_r_charges    = IQR(charges, na.rm = TRUE)
  ) |> 
  knitr::kable(digits = 0)

# -----------------------------------

# Histogram: Distribution of charges

charges_distribution <- ggplot(costs, aes(x = charges)) +
  geom_histogram(bins = 40, fill = "turquoise", color = "white") +
  labs(title = "Distribution of insurance charges", 
       x = "Charges",
       y = "Count")

# -----------------------------------

# Boxplots: Charges per group

# Gender
ggplot(costs, aes(x = sex, y = charges, fill = sex)) +
  geom_boxplot() +
  labs(title = "Charges by gender",
       x = NULL,
       y = "Charges") +
  theme(legend.position = "none")

# Smoking status
ggplot(costs, aes(x = smoker, y = charges, fill = smoker)) +
  geom_boxplot() +
  labs(title = "Charges by smoking status",
       x = NULL,
       y = "Charges") +
  theme(legend.position = "none")

# Region
ggplot(costs, aes(x = region, y = charges, fill = region)) +
  geom_boxplot() +
  labs(title = "Charges by region",
       x = NULL,
       y = "Charges") +
  theme(legend.position = "none")

# Insurance plan type
ggplot(costs, aes(x = plan_type, y = charges, fill = plan_type)) +
  geom_boxplot() +
  labs(title = "Charges by insurance plan type",
       x = NULL,
       y = "Charges") +
  theme(legend.position = "none")

# Chronic condition status
ggplot(costs, aes(x = chronic_condition, y = charges, fill = chronic_condition)) +
  geom_boxplot() +
  labs(title = "Charges by chronic condition status",
       x = NULL,
       y = "Charges") +
  theme(legend.position = "none")

# Exercise level
ggplot(costs, aes(x = exercise_level, y = charges, fill = exercise_level)) +
  geom_boxplot() +
  labs(title = "Charges by exercise level status",
       x = NULL,
       y = "Charges") +
  theme(legend.position = "none")

# Age groups
ggplot(costs, aes(x = age_group, y = charges, fill = age_group)) +
  geom_boxplot() +
  labs(title = "Charges by age group",
       x = NULL,
       y = "Charges") +
  theme(legend.position = "none")

# -----------------------------------

# Scatter plot: continuous predictors vs charges

# Age vs charges, inc smoker
ggplot(costs, aes(x = age, y = charges, color = smoker)) +
  geom_point(alpha = 0.4) + 
  geom_smooth(method = "lm", se = FALSE, color = "tomato") +
  labs(title = "Age vs insurance charges")

# Age vs charges, inc chronic condition
ggplot(costs, aes(x = age, y = charges, color = chronic_condition)) +
  geom_point(alpha = 0.4) + 
  geom_smooth(method = "lm", se = FALSE, color = "tomato") +
  labs(title = "Age vs insurance charges")

# bmi vs charges
ggplot(costs, aes(x = bmi, y = charges)) +
  geom_point(alpha = 0.4) + 
  geom_smooth(method = "lm", se = FALSE, color = "tomato") +
  labs(title = "bmi vs insurance charges")




