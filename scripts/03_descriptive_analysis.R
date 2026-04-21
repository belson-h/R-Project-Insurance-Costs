# The descriptive analysis aims to answer the following questions: 
# - How costs are distributed?
# - What variables are interesting to further explore?
# - If there are interesting distinctions between groups?

# Creates a summary statistics table (any missing values removed)

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
  pivot_longer(
    cols      = everything(),
    names_to  = "Statistic",
    values_to = "Value"
  ) |> 
  knitr::kable(digits = 0)

# -----------------------------------

# Histogram: Distribution of charges

fig_charges_distribution <- ggplot(costs, aes(x = charges)) +
  geom_histogram(bins = 40, fill = "turquoise", color = "white") +
  labs(title = "Distribution of insurance charges", 
       x = "Charges",
       y = "Count")

ggsave(
  filename = ("output/fig_charges_distribution.png"),
  plot     = fig_charges_distribution
)

# -----------------------------------

# Boxplots: Charges per group

# Gender
fig_charges_gender <- ggplot(costs, aes(x = sex, y = charges, fill = sex)) +
  geom_boxplot() +
  labs(title = "Charges by gender",
       x = NULL,
       y = "Charges") +
  theme(legend.position = "none")

ggsave(
  filename = ("output/fig_charges_gender.png"),
  plot     = fig_charges_gender
)

# Smoking status
fig_charges_smoking <- ggplot(costs, aes(x = smoker, y = charges, fill = smoker)) +
  geom_boxplot() +
  labs(title = "Charges by smoking status",
       x = NULL,
       y = "Charges") +
  theme(legend.position = "none")

ggsave(
  filename = ("output/fig_charges_smoking.png"),
  plot     = fig_charges_smoking
)

# Region
fig_charges_region <- ggplot(costs, aes(x = region, y = charges, fill = region)) +
  geom_boxplot() +
  labs(title = "Charges by region",
       x = NULL,
       y = "Charges") +
  theme(legend.position = "none")

ggsave(
  filename = ("output/fig_charges_region.png"),
  plot     = fig_charges_region
)

# Insurance plan type
fig_charges_plan <- ggplot(costs, aes(x = plan_type, y = charges, fill = plan_type)) +
  geom_boxplot() +
  labs(title = "Charges by insurance plan type",
       x = NULL,
       y = "Charges") +
  theme(legend.position = "none")

ggsave(
  filename = ("output/fig_charges_plan.png"),
  plot     = fig_charges_plan
)

# Chronic condition status
fig_charges_condition <- ggplot(costs, aes(x = chronic_condition, y = charges, fill = chronic_condition)) +
  geom_boxplot() +
  labs(title = "Charges by chronic condition status",
       x = NULL,
       y = "Charges") +
  theme(legend.position = "none")

ggsave(
  filename = ("output/fig_charges_condition.png"),
  plot     = fig_charges_condition
)

# Exercise level
fig_charges_exercise <- ggplot(costs, aes(x = exercise_level, y = charges, fill = exercise_level)) +
  geom_boxplot() +
  labs(title = "Charges by exercise level status",
       x = NULL,
       y = "Charges") +
  theme(legend.position = "none")

ggsave(
  filename = ("output/fig_charges_exercise.png"),
  plot     = fig_charges_exercise
)

# Age groups
fig_charges_age_group <- ggplot(costs, aes(x = age_group, y = charges, fill = age_group)) +
  geom_boxplot() +
  labs(title = "Charges by age group",
       x = NULL,
       y = "Charges") +
  theme(legend.position = "none")

ggsave(
  filename = ("output/fig_charges_age_group.png"),
  plot     = fig_charges_age_group
)

# risk_group
fig_charges_risk_group <- ggplot(costs, aes(x = risk_group, y = charges, fill = risk_group)) +
  geom_boxplot() +
  labs(title = "Charges by risk group",
       x = NULL,
       y = "Charges") +
  theme(legend.position = "none")

ggsave(
  filename = ("output/fig_charges_risk_group.png"),
  plot     = fig_charges_risk_group
)

# -----------------------------------

# Scatter plot: continuous predictors vs charges

# Age vs charges, inc smoker
fig_age_smoker_charges <- ggplot(costs, aes(x = age, y = charges, color = smoker)) +
  geom_point(alpha = 0.4) + 
  geom_smooth(method = "lm", se = FALSE, color = "tomato") +
  labs(title = "Age vs insurance charges with cronic condition")

ggsave(
  filename = ("output/fig_age_smoker_charges.png"),
  plot     = fig_age_smoker_charges
)

# Age vs charges, inc chronic condition
fig_age_condition_charges <- ggplot(costs, aes(x = age, y = charges, color = chronic_condition)) +
  geom_point(alpha = 0.4) + 
  geom_smooth(method = "lm", se = FALSE, color = "tomato") +
  labs(title = "Age vs insurance charges with chronic condition")

ggsave(
  filename = ("output/fig_age_condition_charges.png"),
  plot     = fig_age_condition_charges
)

# bmi vs charges
fig_bmi_charges <- ggplot(costs, aes(x = bmi, y = charges)) +
  geom_point(alpha = 0.4) + 
  geom_smooth(method = "lm", se = FALSE, color = "tomato") +
  labs(title = "Bmi vs insurance charges")

ggsave(
  filename = ("output/fig_bmi_charges.png"),
  plot     = fig_bmi_charges
)


