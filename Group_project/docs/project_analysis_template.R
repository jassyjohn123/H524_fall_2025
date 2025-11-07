# ==============================================================================
# H524 Group Project Analysis Template
# Fall 2025
# ==============================================================================

# This template provides a structured framework for your group project analysis
# Customize and expand based on your specific research question and dataset

# ==============================================================================
# SETUP AND CONFIGURATION
# ==============================================================================

# Clear workspace
rm(list = ls())

# Set working directory (adjust to your project folder)
# setwd("~/your_project_folder")

# Load required libraries
library(tidyverse)     # Data manipulation and visualization
library(readr)         # Data import
library(ggplot2)       # Advanced plotting
library(dplyr)         # Data manipulation
library(car)           # Regression diagnostics
library(tableone)      # Descriptive statistics tables
library(corrplot)      # Correlation visualization
library(knitr)         # Reporting
# library(survey)      # Only needed for complex survey data (not used in this course)

# Set options
options(scipen = 999)  # Disable scientific notation
set.seed(524)          # Set seed for reproducibility

# ==============================================================================
# AI USAGE DOCUMENTATION
# ==============================================================================

# Create AI usage log data frame
ai_log <- data.frame(
  date = character(),
  tool = character(),
  task = character(),
  prompt = character(),
  verification = character(),
  stringsAsFactors = FALSE
)

# Function to log AI usage
log_ai_usage <- function(tool, task, prompt, verification) {
  new_entry <- data.frame(
    date = Sys.Date(),
    tool = tool,
    task = task,
    prompt = prompt,
    verification = verification,
    stringsAsFactors = FALSE
  )
  ai_log <<- rbind(ai_log, new_entry)
  message("AI usage logged")
}

# Example usage:
# log_ai_usage(
#   tool = "GitHub Copilot",
#   task = "Generate correlation matrix",
#   prompt = "Create correlation matrix with p-values",
#   verification = "Manually checked against cor.test() results"
# )

# ==============================================================================
# DATA IMPORT AND INITIAL EXPLORATION
# ==============================================================================

# Load your dataset (modify based on your selected dataset)
# Example for CSV file:
# data <- read_csv("your_data_file.csv")

# For this template, we'll create a simulated dataset
# REPLACE THIS WITH YOUR ACTUAL DATA IMPORT
n <- 1000
data <- data.frame(
  id = 1:n,
  age = round(rnorm(n, 45, 15)),
  gender = sample(c("Male", "Female"), n, replace = TRUE),
  bmi = round(rnorm(n, 27, 5), 1),
  smoking = sample(c("Never", "Former", "Current"), n, replace = TRUE,
                   prob = c(0.5, 0.3, 0.2)),
  diabetes = sample(c(0, 1), n, replace = TRUE, prob = c(0.85, 0.15)),
  sbp = round(rnorm(n, 120, 15)),
  cholesterol = round(rnorm(n, 200, 40)),
  outcome = sample(c(0, 1), n, replace = TRUE, prob = c(0.7, 0.3))
)

# Display structure and summary
str(data)
summary(data)

# Check for missing values
missing_summary <- data.frame(
  Variable = names(data),
  Missing_Count = colSums(is.na(data)),
  Missing_Percent = round(colSums(is.na(data))/nrow(data) * 100, 2)
)
print(missing_summary)

# ==============================================================================
# DATA CLEANING AND PREPROCESSING
# ==============================================================================

# Handle missing values (example strategies)
# Option 1: Complete case analysis
# data_complete <- na.omit(data)

# Option 2: Imputation (if appropriate)
# library(mice)
# imputed_data <- mice(data, m = 5, method = 'pmm', seed = 524)
# data_imputed <- complete(imputed_data)

# Create derived variables if needed
data <- data %>%
  mutate(
    age_group = cut(age, breaks = c(0, 30, 50, 65, Inf),
                    labels = c("<30", "30-49", "50-64", "65+")),
    bmi_category = cut(bmi, breaks = c(0, 18.5, 25, 30, Inf),
                       labels = c("Underweight", "Normal", "Overweight", "Obese")),
    hypertension = ifelse(sbp >= 140, 1, 0)
  )

# ==============================================================================
# DESCRIPTIVE STATISTICS
# ==============================================================================

# Create Table 1 using tableone package
vars_to_summarize <- c("age", "bmi", "sbp", "cholesterol",
                       "gender", "smoking", "diabetes", "hypertension")
categorical_vars <- c("gender", "smoking", "diabetes", "hypertension")

# Overall summary
table1_overall <- CreateTableOne(vars = vars_to_summarize,
                                 data = data,
                                 factorVars = categorical_vars)
print(table1_overall, showAllLevels = TRUE)

# Stratified by outcome
table1_stratified <- CreateTableOne(vars = vars_to_summarize,
                                    strata = "outcome",
                                    data = data,
                                    factorVars = categorical_vars)
print(table1_stratified, showAllLevels = TRUE, test = TRUE)

# ==============================================================================
# DATA VISUALIZATION
# ==============================================================================

# Set theme for consistent plot appearance
theme_set(theme_minimal() +
          theme(plot.title = element_text(size = 14, face = "bold"),
                axis.title = element_text(size = 12)))

# 1. Distribution of continuous variables
continuous_vars <- c("age", "bmi", "sbp", "cholesterol")

for(var in continuous_vars) {
  p <- ggplot(data, aes_string(x = var)) +
    geom_histogram(bins = 30, fill = "steelblue", color = "white", alpha = 0.7) +
    geom_vline(aes_string(xintercept = paste0("mean(", var, ", na.rm = TRUE)")),
               color = "red", linetype = "dashed", size = 1) +
    labs(title = paste("Distribution of", var),
         x = var,
         y = "Frequency") +
    theme_minimal()
  print(p)
}

# 2. Bar plots for categorical variables
categorical_plot_vars <- c("gender", "smoking", "diabetes")

for(var in categorical_plot_vars) {
  p <- ggplot(data, aes_string(x = var, fill = var)) +
    geom_bar(alpha = 0.7) +
    labs(title = paste("Distribution of", var),
         x = var,
         y = "Count") +
    scale_fill_brewer(palette = "Set2") +
    theme(legend.position = "none")
  print(p)
}

# 3. Box plots by outcome
for(var in continuous_vars) {
  p <- ggplot(data, aes_string(x = "factor(outcome)", y = var, fill = "factor(outcome)")) +
    geom_boxplot(alpha = 0.7) +
    labs(title = paste(var, "by Outcome"),
         x = "Outcome",
         y = var) +
    scale_fill_manual(values = c("0" = "lightblue", "1" = "coral"),
                      name = "Outcome",
                      labels = c("No", "Yes")) +
    theme_minimal()
  print(p)
}

# 4. Correlation matrix
numeric_data <- data %>%
  select(age, bmi, sbp, cholesterol, outcome)

correlation_matrix <- cor(numeric_data, use = "complete.obs")
corrplot(correlation_matrix,
         method = "color",
         type = "upper",
         order = "hclust",
         addCoef.col = "black",
         tl.col = "black",
         tl.srt = 45,
         diag = FALSE)


# ==============================================================================
# STATISTICAL ANALYSIS
# ==============================================================================

# 1. Bivariate analyses
# Continuous variables - t-tests
continuous_tests <- list()
for(var in continuous_vars) {
  formula <- as.formula(paste(var, "~ outcome"))
  test_result <- t.test(formula, data = data)
  continuous_tests[[var]] <- test_result
  cat("\nT-test for", var, "by outcome:\n")
  print(test_result)
}

# Categorical variables - chi-square tests
categorical_test_vars <- c("gender", "smoking", "diabetes", "hypertension")
categorical_tests <- list()
for(var in categorical_test_vars) {
  test_result <- chisq.test(table(data[[var]], data$outcome))
  categorical_tests[[var]] <- test_result
  cat("\nChi-square test for", var, "and outcome:\n")
  print(test_result)
}

# 2. Multivariable logistic regression
# Full model
model_full <- glm(outcome ~ age + gender + bmi + smoking + diabetes + sbp + cholesterol,
                  data = data,
                  family = binomial())

summary(model_full)

# Calculate odds ratios and confidence intervals
OR_CI <- exp(cbind(OR = coef(model_full), confint(model_full)))
print(round(OR_CI, 3))

# Model diagnostics
# Check for multicollinearity
vif_values <- vif(model_full)
print("Variance Inflation Factors:")
print(vif_values)

# 3. Model selection (if appropriate)
# Backward selection example
model_backward <- step(model_full, direction = "backward", trace = 0)
summary(model_backward)

# ==============================================================================
# SENSITIVITY ANALYSES
# ==============================================================================

# Example: Analyze complete cases only
data_complete <- na.omit(data)
model_complete <- glm(outcome ~ age + gender + bmi + smoking + diabetes,
                     data = data_complete,
                     family = binomial())

cat("\nSensitivity Analysis - Complete Cases Only:\n")
summary(model_complete)

# Example: Subgroup analysis by gender
model_male <- glm(outcome ~ age + bmi + smoking + diabetes,
                 data = filter(data, gender == "Male"),
                 family = binomial())

model_female <- glm(outcome ~ age + bmi + smoking + diabetes,
                   data = filter(data, gender == "Female"),
                   family = binomial())

cat("\nSubgroup Analysis - Males:\n")
summary(model_male)
cat("\nSubgroup Analysis - Females:\n")
summary(model_female)

# ==============================================================================
# RESULTS SUMMARY AND EXPORT
# ==============================================================================

# Create results summary table
results_summary <- data.frame(
  Analysis = c("Sample Size", "Outcome Prevalence", "Mean Age", "Mean BMI",
               "Diabetes Prevalence", "Primary Association"),
  Result = c(
    nrow(data),
    paste0(round(mean(data$outcome) * 100, 1), "%"),
    round(mean(data$age, na.rm = TRUE), 1),
    round(mean(data$bmi, na.rm = TRUE), 1),
    paste0(round(mean(data$diabetes) * 100, 1), "%"),
    "See regression results"
  )
)

# Export key results
write.csv(results_summary, "results_summary.csv", row.names = FALSE)
write.csv(OR_CI, "odds_ratios.csv")

# Export AI usage log
write.csv(ai_log, "ai_usage_log.csv", row.names = FALSE)

# ==============================================================================
# GENERATE REPORT COMPONENTS
# ==============================================================================

# Function to create formatted table for report
create_formatted_table <- function(model) {
  coef_summary <- summary(model)$coefficients
  or_ci <- exp(cbind(OR = coef(model), confint(model)))

  result_table <- data.frame(
    Variable = rownames(coef_summary),
    OR = round(or_ci[, "OR"], 2),
    CI_Lower = round(or_ci[, "2.5 %"], 2),
    CI_Upper = round(or_ci[, "97.5 %"], 2),
    P_Value = round(coef_summary[, "Pr(>|z|)"], 4)
  )

  return(result_table)
}

# Create final results table
final_results <- create_formatted_table(model_full)
print(kable(final_results, caption = "Multivariable Logistic Regression Results"))

# ==============================================================================
# SESSION INFO
# ==============================================================================

# Document R session for reproducibility
cat("\n========== SESSION INFORMATION ==========\n")
sessionInfo()

# ==============================================================================
# PRESENTATION VISUALIZATIONS
# ==============================================================================

# Create high-quality plots for presentation

# 1. Main results visualization
main_results_plot <- ggplot(final_results[-1,],
                           aes(x = reorder(Variable, OR), y = OR)) +
  geom_point(size = 3) +
  geom_errorbar(aes(ymin = CI_Lower, ymax = CI_Upper), width = 0.2) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "red") +
  coord_flip() +
  labs(title = "Adjusted Odds Ratios for Outcome",
       x = "Variable",
       y = "Odds Ratio (95% CI)") +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold"))

print(main_results_plot)
ggsave("main_results.png", main_results_plot, width = 10, height = 6, dpi = 300)

# 2. Create summary infographic data
summary_stats <- list(
  total_n = nrow(data),
  outcome_rate = round(mean(data$outcome) * 100, 1),
  mean_age = round(mean(data$age), 1),
  gender_split = round(prop.table(table(data$gender)) * 100, 1)
)

cat("\n========== ANALYSIS COMPLETE ==========\n")
cat("Remember to:\n")
cat("1. Document all AI usage in the log\n")
cat("2. Verify all results independently\n")
cat("3. Create presentation slides\n")
cat("4. Write final report\n")
cat("5. Prepare for Q&A session\n")

# ==============================================================================
# END OF ANALYSIS TEMPLATE
# ==============================================================================