################################################################################
# H524 Introduction to Biostatistics
# Week 2: Probability Concepts and Applications
# Fall 2025
# Dr. John Molitor
################################################################################

# Clear workspace and set options
rm(list = ls())
options(scipen = 999)  # Avoid scientific notation
set.seed(123)         # For reproducibility

################################################################################
# SECTION 1: BASIC PROBABILITY CALCULATIONS
################################################################################

# Example 1: Sample Space for Two Dice
dice1 <- 1:6
dice2 <- 1:6
sample_space <- expand.grid(Die1 = dice1, Die2 = dice2)
sample_space$Sum <- sample_space$Die1 + sample_space$Die2

# Calculate probabilities
p_seven <- sum(sample_space$Sum == 7) / nrow(sample_space)
cat("Probability of sum = 7:", round(p_seven, 3), "\n")

# Conditional probability: P(sum > 8 | first die = 4)
subset_data <- sample_space[sample_space$Die1 == 4, ]
p_conditional <- sum(subset_data$Sum > 8) / nrow(subset_data)
cat("P(sum > 8 | first die = 4):", round(p_conditional, 3), "\n")

################################################################################
# SECTION 2: MEDICAL DIAGNOSTIC TESTING
################################################################################

# Function to calculate diagnostic test metrics
diagnostic_metrics <- function(sensitivity, specificity, prevalence) {
  # Positive Predictive Value (PPV)
  ppv <- (sensitivity * prevalence) /
         (sensitivity * prevalence + (1 - specificity) * (1 - prevalence))

  # Negative Predictive Value (NPV)
  npv <- (specificity * (1 - prevalence)) /
         ((1 - sensitivity) * prevalence + specificity * (1 - prevalence))

  # Return results
  list(
    PPV = round(ppv * 100, 1),
    NPV = round(npv * 100, 1),
    Sensitivity = sensitivity * 100,
    Specificity = specificity * 100,
    Prevalence = prevalence * 100
  )
}

# COVID-19 rapid test example
covid_test <- diagnostic_metrics(
  sensitivity = 0.85,
  specificity = 0.97,
  prevalence = 0.05
)

cat("\n=== COVID-19 Rapid Test Performance ===\n")
cat("Sensitivity:", covid_test$Sensitivity, "%\n")
cat("Specificity:", covid_test$Specificity, "%\n")
cat("Prevalence:", covid_test$Prevalence, "%\n")
cat("Positive Predictive Value:", covid_test$PPV, "%\n")
cat("Negative Predictive Value:", covid_test$NPV, "%\n")

# Mammogram example
mammogram <- diagnostic_metrics(
  sensitivity = 0.90,
  specificity = 0.95,
  prevalence = 0.008
)

cat("\n=== Mammogram for Breast Cancer ===\n")
cat("Sensitivity:", mammogram$Sensitivity, "%\n")
cat("Specificity:", mammogram$Specificity, "%\n")
cat("Prevalence:", mammogram$Prevalence, "%\n")
cat("Positive Predictive Value:", mammogram$PPV, "%\n")
cat("Negative Predictive Value:", mammogram$NPV, "%\n")

################################################################################
# SECTION 3: 2x2 CONTINGENCY TABLE AND RISK MEASURES
################################################################################

# Smoking and lung cancer study
smoking_data <- matrix(
  c(60, 440,   # Smokers: cancer, no cancer
    10, 490),  # Non-smokers: cancer, no cancer
  nrow = 2, byrow = TRUE,
  dimnames = list(
    c("Smokers", "Non-smokers"),
    c("Lung Cancer", "No Cancer")
  )
)

print(smoking_data)

# Calculate risks
risk_smokers <- smoking_data[1,1] / sum(smoking_data[1,])
risk_nonsmokers <- smoking_data[2,1] / sum(smoking_data[2,])

# Relative Risk
relative_risk <- risk_smokers / risk_nonsmokers

# Odds Ratio
odds_ratio <- (smoking_data[1,1] * smoking_data[2,2]) /
              (smoking_data[1,2] * smoking_data[2,1])

cat("\n=== Smoking and Lung Cancer Risk ===\n")
cat("Risk in smokers:", round(risk_smokers * 100, 1), "%\n")
cat("Risk in non-smokers:", round(risk_nonsmokers * 100, 1), "%\n")
cat("Relative Risk:", round(relative_risk, 2), "\n")
cat("Odds Ratio:", round(odds_ratio, 2), "\n")

################################################################################
# SECTION 4: BINOMIAL DISTRIBUTION
################################################################################

# Vaccine efficacy trial
n <- 20         # Number of individuals
p <- 0.90       # Probability of protection

# Probability of exactly 18 protected
p_18 <- dbinom(18, n, p)
cat("\n=== Vaccine Efficacy Trial ===\n")
cat("P(exactly 18 protected):", round(p_18, 3), "\n")

# Probability of at least 18 protected
p_atleast_18 <- pbinom(17, n, p, lower.tail = FALSE)
cat("P(at least 18 protected):", round(p_atleast_18, 3), "\n")

# Expected value and standard deviation
expected_protected <- n * p
sd_protected <- sqrt(n * p * (1 - p))
cat("Expected number protected:", expected_protected, "\n")
cat("Standard deviation:", round(sd_protected, 2), "\n")

################################################################################
# SECTION 5: NORMAL DISTRIBUTION
################################################################################

# Systolic blood pressure in adults
mu_bp <- 120      # Mean
sigma_bp <- 15    # Standard deviation

# Probability of hypertension (BP > 140)
p_hypertension <- pnorm(140, mu_bp, sigma_bp, lower.tail = FALSE)
cat("\n=== Blood Pressure Distribution ===\n")
cat("Mean:", mu_bp, "mmHg\n")
cat("Standard deviation:", sigma_bp, "mmHg\n")
cat("P(BP > 140):", round(p_hypertension * 100, 1), "%\n")

# Find percentiles
percentiles <- c(0.05, 0.25, 0.50, 0.75, 0.95)
bp_percentiles <- qnorm(percentiles, mu_bp, sigma_bp)
cat("\nBlood Pressure Percentiles:\n")
for (i in 1:length(percentiles)) {
  cat(sprintf("  %2.0fth percentile: %.1f mmHg\n",
              percentiles[i] * 100, bp_percentiles[i]))
}

################################################################################
# SECTION 6: SAMPLING DISTRIBUTION OF THE MEAN
################################################################################

# Cholesterol study
mu_chol <- 200      # Population mean
sigma_chol <- 30    # Population SD
n_sample <- 100     # Sample size

# Standard error
se <- sigma_chol / sqrt(n_sample)

cat("\n=== Sampling Distribution of Mean Cholesterol ===\n")
cat("Population mean:", mu_chol, "mg/dL\n")
cat("Population SD:", sigma_chol, "mg/dL\n")
cat("Sample size:", n_sample, "\n")
cat("Standard error:", se, "mg/dL\n")

# 95% CI for sample means
ci_lower <- mu_chol - 1.96 * se
ci_upper <- mu_chol + 1.96 * se
cat("95% of sample means fall between:",
    round(ci_lower, 1), "and", round(ci_upper, 1), "mg/dL\n")

################################################################################
# SECTION 7: PRACTICE PROBLEMS - SOLUTIONS
################################################################################

cat("\n", rep("=", 60), "\n", sep = "")
cat("PRACTICE PROBLEM SOLUTIONS\n")
cat(rep("=", 60), "\n", sep = "")

# Problem 1: Diagnostic Test NPV
sens_strep <- 0.85
spec_strep <- 0.95
prev_strep <- 0.15

npv_strep <- (spec_strep * (1 - prev_strep)) /
             ((1 - sens_strep) * prev_strep + spec_strep * (1 - prev_strep))

cat("\n1. Strep Test NPV:", round(npv_strep * 100, 1), "%\n")

# Problem 2: Relative Risk Calculation
# 200 smokers: 30 with heart disease
# 800 non-smokers: 20 with heart disease
risk_smokers_hd <- 30/200
risk_nonsmokers_hd <- 20/800
rr_hd <- risk_smokers_hd / risk_nonsmokers_hd

cat("\n2. Relative Risk for Heart Disease:", round(rr_hd, 2), "\n")

# Problem 3: Binomial Probability
p_atleast_8 <- pbinom(7, 10, 0.6, lower.tail = FALSE)
cat("\n3. P(at least 8 successes out of 10):", round(p_atleast_8, 3), "\n")

# Problem 4: Normal Distribution
p_between <- pnorm(220, 200, 40) - pnorm(180, 200, 40)
cat("\n4. Proportion with cholesterol 180-220:", round(p_between * 100, 1), "%\n")

cat("\n", rep("=", 60), "\n", sep = "")
cat("WEEK 2 DEMONSTRATIONS COMPLETE\n")
cat(rep("=", 60), "\n", sep = "")