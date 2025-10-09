################################################################################
# H524 Introduction to Biostatistics
# Week 2: Probability Concepts and Applications
# Fall 2025
# Dr. John Molitor
#
# This code demonstrates all major concepts from Week 2 slides including:
# - Basic probability calculations
# - Diagnostic test performance (sensitivity, specificity, PPV, NPV)
# - Understanding odds vs probability
# - Relative risk and odds ratios
# - The counterintuitive HIV screening example
# - Binomial and normal distributions
# - Expected value and variance
# - Public health applications
# - Key visualizations
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
# SECTION 3: UNDERSTANDING ODDS
################################################################################

# Example: Probability vs Odds
# 60 smokers develop lung cancer, 440 don't

total_smokers <- 500
smokers_with_cancer <- 60
smokers_without_cancer <- 440

# Probability (Risk)
probability_cancer <- smokers_with_cancer / total_smokers
cat("\n=== Understanding Odds vs Probability ===\n")
cat("Smokers with cancer:", smokers_with_cancer, "\n")
cat("Smokers without cancer:", smokers_without_cancer, "\n")
cat("Total smokers:", total_smokers, "\n")
cat("\nProbability (Risk):", round(probability_cancer, 4),
    "(", round(probability_cancer * 100, 1), "%)\n")

# Odds
odds_cancer <- smokers_with_cancer / smokers_without_cancer
cat("Odds:", round(odds_cancer, 4), "\n")
cat("Odds can also be expressed as '60 to 440' or '3 to 22'\n")

# Relationship between probability and odds
cat("\nRelationship: Odds = p / (1 - p)\n")
cat("Verification:", round(probability_cancer / (1 - probability_cancer), 4), "\n")
cat("\nNote: When probability < 0.10, odds ≈ probability\n")

################################################################################
# SECTION 4: 2x2 CONTINGENCY TABLE AND RISK MEASURES
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
cat("\n")
addmargins(smoking_data)

# Calculate risks
risk_smokers <- smoking_data[1,1] / sum(smoking_data[1,])
risk_nonsmokers <- smoking_data[2,1] / sum(smoking_data[2,])

# Calculate odds for each group
odds_smokers <- smoking_data[1,1] / smoking_data[1,2]
odds_nonsmokers <- smoking_data[2,1] / smoking_data[2,2]

# Relative Risk
relative_risk <- risk_smokers / risk_nonsmokers

# Odds Ratio
odds_ratio <- (smoking_data[1,1] * smoking_data[2,2]) /
              (smoking_data[1,2] * smoking_data[2,1])
# Alternative: ratio of odds
odds_ratio_alt <- odds_smokers / odds_nonsmokers

cat("\n=== Smoking and Lung Cancer Risk ===\n")
cat("Risk in smokers:", round(risk_smokers * 100, 1), "%\n")
cat("Risk in non-smokers:", round(risk_nonsmokers * 100, 1), "%\n")
cat("Relative Risk:", round(relative_risk, 2), "\n")
cat("\nOdds in smokers:", round(odds_smokers, 3), "\n")
cat("Odds in non-smokers:", round(odds_nonsmokers, 3), "\n")
cat("Odds Ratio:", round(odds_ratio, 2), "\n")
cat("Odds Ratio (alternative calculation):", round(odds_ratio_alt, 2), "\n")
cat("\nInterpretation: Smokers have", round(relative_risk, 1),
    "times the risk of lung cancer\n")

################################################################################
# SECTION 5: HIV SCREENING COUNTERINTUITIVE EXAMPLE
################################################################################

# HIV screening with excellent test performance but low prevalence
sens_hiv <- 0.995   # 99.5% sensitivity
spec_hiv <- 0.985   # 98.5% specificity
prev_hiv <- 0.001   # 0.1% prevalence (1 in 1000)

# Simulate 100,000 people tested
n_tested <- 100000
n_hiv_pos <- round(n_tested * prev_hiv)
n_hiv_neg <- n_tested - n_hiv_pos

# Calculate test outcomes
TP <- round(n_hiv_pos * sens_hiv)
FN <- n_hiv_pos - TP
FP <- round(n_hiv_neg * (1 - spec_hiv))
TN <- n_hiv_neg - FP

cat("\n=== HIV Screening Example ===\n")
cat("Population tested:", n_tested, "\n")
cat("HIV prevalence:", prev_hiv * 100, "%\n")
cat("Test sensitivity:", sens_hiv * 100, "%\n")
cat("Test specificity:", spec_hiv * 100, "%\n")
cat("\nResults:\n")
cat("  True Positives:", TP, "\n")
cat("  False Positives:", FP, "\n")
cat("  False Negatives:", FN, "\n")
cat("  True Negatives:", TN, "\n")

# PPV calculation
ppv_hiv <- TP / (TP + FP)
cat("\nPositive Predictive Value:", round(ppv_hiv * 100, 1), "%\n")
cat("\nSurprising result: Only", round(ppv_hiv * 100, 1),
    "% of positive tests indicate actual infection!\n")
cat("Why? With low prevalence, false positives (", FP,
    ") vastly outnumber true positives (", TP, ")\n")

################################################################################
# SECTION 6: BINOMIAL DISTRIBUTION
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
# SECTION 7: NORMAL DISTRIBUTION
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
# SECTION 8: EXPECTED VALUE AND VARIANCE
################################################################################

# Medical Example: Number of adverse events in clinical trial
events <- 0:3
probs <- c(0.70, 0.20, 0.08, 0.02)

# Expected value
expected_events <- sum(events * probs)
cat("\n=== Adverse Events Example ===\n")
cat("Expected number of adverse events per patient:", expected_events, "\n")

# Variance and standard deviation
variance <- sum(events^2 * probs) - expected_events^2
sd_events <- sqrt(variance)
cat("Variance:", round(variance, 3), "\n")
cat("Standard deviation:", round(sd_events, 3), "\n")

################################################################################
# SECTION 9: PROBABILITY IN PUBLIC HEALTH
################################################################################

# Disease surveillance example
population <- 50000
new_cases <- 125
deaths <- 15

# Calculate probabilities
prob_disease <- new_cases / population
prob_death_given_disease <- deaths / new_cases
prob_death_and_disease <- deaths / population

cat("\n=== Disease Surveillance ===\n")
cat("Population:", population, "\n")
cat("New cases:", new_cases, "\n")
cat("Deaths:", deaths, "\n")
cat("\nProbabilities:\n")
cat("  Pr(disease):", round(prob_disease, 5),
    "(", round(prob_disease * 100, 2), "%)\n")
cat("  Pr(death | disease):", round(prob_death_given_disease, 3),
    "(", round(prob_death_given_disease * 100, 1), "%)\n")
cat("  Pr(death and disease):", round(prob_death_and_disease, 5),
    "(", round(prob_death_and_disease * 100, 3), "%)\n")
cat("\nPublic Health Metrics:\n")
cat("  Incidence rate:", round(prob_disease * 100000, 0), "per 100,000 per year\n")
cat("  Case fatality rate:", round(prob_death_given_disease * 100, 1), "%\n")
cat("  Overall mortality rate:", round(prob_death_and_disease * 100000, 0),
    "per 100,000 per year\n")

################################################################################
# SECTION 10: SAMPLING DISTRIBUTION OF THE MEAN
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
# SECTION 11: PRACTICE PROBLEMS - SOLUTIONS
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

################################################################################
# SECTION 12: VISUALIZATIONS
################################################################################

cat("\nGenerating visualizations...\n")

# Visualization 1: Binomial Distribution
par(mfrow = c(2, 2))  # 2x2 plot layout

# Binomial: Vaccine trial
n <- 20
p <- 0.7
x <- 0:n
probs <- dbinom(x, n, p)

barplot(probs,
        names.arg = x,
        col = "lightblue",
        main = "Binomial Distribution (n=20, p=0.7)",
        xlab = "Number of Successes",
        ylab = "Probability")
abline(v = n * p + 0.5, col = "red", lwd = 2, lty = 2)

# Normal Distribution: Blood Pressure
mu <- 120
sigma <- 15
x_vals <- seq(70, 170, length = 100)

plot(x_vals, dnorm(x_vals, mu, sigma),
     type = "l",
     col = "blue",
     lwd = 2,
     main = "Systolic Blood Pressure Distribution",
     xlab = "SBP (mmHg)",
     ylab = "Density")
abline(v = c(mu, 140), col = c("blue", "red"), lty = c(2, 2), lwd = 2)
legend("topright", c("Mean", "Hypertension"), col = c("blue", "red"), lty = 2)

# Comparison: Binomial vs Normal Approximation
n <- 100
p <- 0.3
x <- 0:n
binom_probs <- dbinom(x, n, p)

plot(x, binom_probs,
     type = "h",
     col = "blue",
     main = "Binomial vs Normal Approximation",
     xlab = "Number of Successes",
     ylab = "Probability")
curve(dnorm(x, n * p, sqrt(n * p * (1 - p))),
      add = TRUE,
      col = "red",
      lwd = 2)
legend("topright", c("Binomial", "Normal"), col = c("blue", "red"), lty = 1)

# PPV vs Prevalence
prevalence <- seq(0.001, 0.10, length = 100)
sens <- 0.95
spec <- 0.90
ppv <- (sens * prevalence) / (sens * prevalence + (1 - spec) * (1 - prevalence))

plot(prevalence * 100, ppv * 100,
     type = "l",
     col = "darkgreen",
     lwd = 2,
     main = "PPV vs Disease Prevalence",
     xlab = "Prevalence (%)",
     ylab = "PPV (%)")
grid()

par(mfrow = c(1, 1))  # Reset to single plot

cat("\n", rep("=", 60), "\n", sep = "")
cat("WEEK 2 DEMONSTRATIONS COMPLETE\n")
cat(rep("=", 60), "\n", sep = "")