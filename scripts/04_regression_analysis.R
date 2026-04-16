# Regression analysis
#----------------------------------------


# Prep
# ---------------------------------------
# Make sure categorical variables are factors 
costs <- costs |>
  mutate(
    smoker            = as.factor(smoker),
    chronic_condition = as.factor(chronic_condition),
    risk_group        = factor(risk_group, levels = c("Low", "Medium", "High")),
    plan_type         = as.factor(plan_type),
    exercise_level    = as.factor(exercise_level)
  )


# Creating regression models
#-----------------------------------------
# Model 1 - Simple: three strongest predictors (chronic_condition, smoker, age)

model1 <- lm(charges ~ age + smoker + chronic_condition, data = costs)
summary(model1)

# Model 2 - Extended: builds on model 1 + bmi, risk_group, plan_type, exercise level

model2 <- lm(charges ~ age + smoker + chronic_condition +
               bmi + risk_group + plan_type + exercise_level,
             data = costs)
summary(model2)

# Model 3 - With interaction term: builds on model 2 but add an interaction between smoker and age

model3 <- lm(charges ~ age * smoker + chronic_condition +
               bmi + risk_group + plan_type + exercise_level,
             data = costs)
summary(model3)


# Comparing models
#---------------------------------------

# Adjusted R-squared and AIC side by side
tibble(
  model   = c("Model 1", "Model 2", "Model 3"),
  adj_r2  = c(summary(model1)$adj.r.squared,
              summary(model2)$adj.r.squared,
              summary(model3)$adj.r.squared),
  aic     = c(AIC(model1), AIC(model2), AIC(model3))
) |> 
  knitr::kable(
    digits = c(0, 3, 0),
    col.names = c("Model", "Adjusted R²", "AIC"),
    caption = "Model comparision - Adjusted R² and AIC"
  )


# Diagnostics
#---------------------------------------

# Residual vs fitted:

# model2$model manages NA as it only contains the rows lm() actually used

# Model 1: 
model1_diagnostics <- model1$model |> 
  mutate(
    fitted_value = fitted(model1),
    residual     = residuals(model1)
  )

# Model 2: 
model2_diagnostics <- model2$model |> 
  mutate(
    fitted_value = fitted(model2),
    residual     = residuals(model2)
  )

# Model 3:
model3_diagnostics <- model3$model |> 
  mutate(
    fitted_value = fitted(model3),
    residual     = residuals(model3)
  )


# Model 2: Table of first five observations
model2_diagnostics |>  
  select(charges, fitted_value, residual) |> 
  slice_head(n = 5) |> 
  knitr::kable(
    digits = 0,
    col.names = c("Actual charges", "Fitted value", "Residual"),
    caption = "Actual vs predicted charges - first 5 observations"
  )


# Plot over residuals vs fitted for all three models

p1_res_fitted <- ggplot(model1_diagnostics, aes(x = fitted_value, y = residual)) + 
  geom_point(alpha = 0.4) +
  geom_hline(yintercept = 0, color = "tomato", linetype = "dashed") +
  labs(title = "Model 1", x = "Fitted values", y = "Residuals")

p2_res_fitted <- ggplot(model2_diagnostics, aes(x = fitted_value, y = residual)) + 
  geom_point(alpha = 0.4) +
  geom_hline(yintercept = 0, color = "tomato", linetype = "dashed") +
  labs(title = "Model 2", x = "Fitted values", y = "Residuals")

p3_res_fitted <- ggplot(model3_diagnostics, aes(x = fitted_value, y = residual)) + 
  geom_point(alpha = 0.4) +
  geom_hline(yintercept = 0, color = "tomato", linetype = "dashed") +
  labs(title = "Model 3", x = "Fitted values", y = "Residuals")

p1_res_fitted | p2_res_fitted | p3_res_fitted

# QQ-plot - checks if residuals are normally distributed

qqnorm(resid(model2))
qqline(resid(model2), col = "tomato")

# Actual vs predicted charges

ggplot (model2_diagnostics, aes(x = charges, y = fitted_value)) +
  geom_point(alpha = 0.4) +
  geom_abline(slope = 1, intercept = 0, color = "tomato", linetype = "dashed") +
  labs(title = "Model 2 - Actual vs Predicted",
       x = "Actual charges", y = "Predicted charges")








