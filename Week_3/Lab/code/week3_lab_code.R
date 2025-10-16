# =============================================================================
# H524 Introduction to Biostatistics
# Week 3 Lab: Probability Distributions and Sampling
# Fall 2025
# =============================================================================

# This R script contains complete solutions for all Week 3 lab exercises
# Topics: Binomial, Normal, Sampling Distributions, CLT, Confidence Intervals

# Clear workspace
rm(list = ls())

# Set working directory (adjust as needed)
# setwd("~/H524/Week3")

cat("Week 3 Lab: Probability Distributions and Sampling\n")
cat("==================================================\n\n")

# =============================================================================
# PART 1: BINOMIAL DISTRIBUTION
# =============================================================================

cat("PART 1: BINOMIAL DISTRIBUTION\n")
cat("==============================\n\n")

# -----------------------------------------------------------------------------
# Exercise 1.1: Basic Binomial Calculations
# -----------------------------------------------------------------------------
cat("Exercise 1.1: Vaccine Efficacy (n=20, p=0.85)\n")
cat("----------------------------------------------\n")

# Binomial distribution: n=20, p=0.85
n <- 20
p <- 0.85

# Probability of exactly 17 protected
prob_17 <- dbinom(17, size=n, prob=p)
cat("P(X = 17):", round(prob_17, 4), "\n")

# Probability of 17 or fewer protected
prob_at_most_17 <- pbinom(17, n, p)
cat("P(X <= 17):", round(prob_at_most_17, 4), "\n")

# Probability of at least 18 protected
prob_at_least_18 <- pbinom(17, n, p, lower.tail=FALSE)
# OR: 1 - pbinom(17, n, p)
cat("P(X >= 18):", round(prob_at_least_18, 4), "\n")

# Expected value and standard deviation
expected <- n * p
std_dev <- sqrt(n * p * (1 - p))
cat("\nExpected value:", expected, "\n")
cat("Standard deviation:", round(std_dev, 3), "\n\n")

# Try it yourself: p = 0.90
cat("With p = 0.90:\n")
p <- 0.90
prob_17 <- dbinom(17, size=n, prob=p)
prob_at_most_17 <- pbinom(17, n, p)
prob_at_least_18 <- pbinom(17, n, p, lower.tail=FALSE)
expected <- n * p
std_dev <- sqrt(n * p * (1 - p))

cat("P(X = 17):", round(prob_17, 4), "\n")
cat("P(X <= 17):", round(prob_at_most_17, 4), "\n")
cat("P(X >= 18):", round(prob_at_least_18, 4), "\n")
cat("Expected value:", expected, "\n")
cat("Standard deviation:", round(std_dev, 3), "\n\n")

# -----------------------------------------------------------------------------
# Exercise 1.2: Visualizing the Binomial Distribution
# -----------------------------------------------------------------------------
cat("Exercise 1.2: Binomial Visualization\n")
cat("------------------------------------\n")

# Create a visualization of the binomial distribution
n <- 20
p <- 0.85

# Create vector of possible values
x_values <- 0:n

# Calculate probabilities for each value
probabilities <- dbinom(x_values, n, p)

# Create barplot
bp <- barplot(probabilities,
        names.arg = x_values,
        main = "Binomial Distribution (n=20, p=0.85)",
        xlab = "Number of Successes",
        ylab = "Probability",
        col = "lightblue",
        border = "white")

# Add vertical line at expected value
abline(v = bp[which(x_values == n*p)], col = "red", lwd = 2, lty = 2)

# Add legend
legend("topleft",
       legend = "Expected Value",
       col = "red",
       lty = 2,
       lwd = 2)

cat("The distribution is slightly left-skewed because p is high (0.85)\n")
cat("Most values are concentrated near the expected value of 17\n\n")

# -----------------------------------------------------------------------------
# Exercise 1.3: Binomial Scenarios
# -----------------------------------------------------------------------------
cat("Exercise 1.3: Antibiotic Scenario (n=15, p=0.75)\n")
cat("------------------------------------------------\n")

# Antibiotic treatment: 75% success rate, treat 15 patients
antibiotic_prob <- dbinom(12, size=15, prob=0.75)
cat("P(exactly 12 successes):", round(antibiotic_prob, 4), "\n")

# At least 10 successes
at_least_10 <- sum(dbinom(10:15, size=15, prob=0.75))
# OR: pbinom(9, 15, 0.75, lower.tail=FALSE)
at_least_10_alt <- pbinom(9, 15, 0.75, lower.tail=FALSE)
cat("P(at least 10 successes):", round(at_least_10, 4), "\n")
cat("Alternative calculation:", round(at_least_10_alt, 4), "\n\n")

# Practice: Clinical trial (n=25, p=0.70)
cat("Practice: Clinical Trial (n=25, p=0.70)\n")
cat("----------------------------------------\n")

n_trial <- 25
p_trial <- 0.70

# a) P(exactly 18 successes)
prob_18 <- dbinom(18, size=n_trial, prob=p_trial)
cat("a) P(exactly 18 successes):", round(prob_18, 4), "\n")

# b) P(fewer than 15 successes)
prob_fewer_15 <- pbinom(14, n_trial, p_trial)
cat("b) P(fewer than 15 successes):", round(prob_fewer_15, 4), "\n")

# c) P(between 15 and 20 successes, inclusive)
prob_between <- sum(dbinom(15:20, n_trial, p_trial))
# OR: pbinom(20, n_trial, p_trial) - pbinom(14, n_trial, p_trial)
prob_between_alt <- pbinom(20, n_trial, p_trial) - pbinom(14, n_trial, p_trial)
cat("c) P(between 15 and 20, inclusive):", round(prob_between, 4), "\n")
cat("   Alternative calculation:", round(prob_between_alt, 4), "\n\n")

# =============================================================================
# PART 2: NORMAL DISTRIBUTION
# =============================================================================

cat("\n\nPART 2: NORMAL DISTRIBUTION\n")
cat("============================\n\n")

# -----------------------------------------------------------------------------
# Exercise 2.1: Basic Normal Calculations
# -----------------------------------------------------------------------------
cat("Exercise 2.1: Cholesterol Levels (mu=200, sigma=40)\n")
cat("----------------------------------------------------\n")

# Normal distribution parameters
mu <- 200      # mean
sigma <- 40    # standard deviation

# Probability that cholesterol < 240
prob_below_240 <- pnorm(240, mean=mu, sd=sigma)
cat("P(X < 240):", round(prob_below_240, 4), "\n")

# Probability that cholesterol > 240
prob_above_240 <- pnorm(240, mu, sigma, lower.tail=FALSE)
# OR: 1 - pnorm(240, mu, sigma)
cat("P(X > 240):", round(prob_above_240, 4), "\n")

# Probability between 180 and 220
prob_between <- pnorm(220, mu, sigma) - pnorm(180, mu, sigma)
cat("P(180 < X < 220):", round(prob_between, 4), "\n")

cat("\nAnswer: About", round(prob_above_240*100, 1), "% have high cholesterol (>240)\n\n")

# -----------------------------------------------------------------------------
# Exercise 2.2: Finding Percentiles
# -----------------------------------------------------------------------------
cat("Exercise 2.2: Cholesterol Percentiles\n")
cat("--------------------------------------\n")

# Find the 90th percentile of cholesterol
percentile_90 <- qnorm(0.90, mean=mu, sd=sigma)
cat("90th percentile:", round(percentile_90, 1), "mg/dL\n")

# Find the 25th, 50th (median), and 75th percentiles
quartiles <- qnorm(c(0.25, 0.50, 0.75), mu, sigma)
names(quartiles) <- c("Q1", "Median", "Q3")
print(round(quartiles, 1))

# Verify: what proportion is below the 90th percentile?
check <- pnorm(percentile_90, mu, sigma)
cat("\nVerification:", round(check, 2), "\n\n")

# Try it yourself
cat("Try it yourself:\n")
percentile_10 <- qnorm(0.10, mu, sigma)
percentile_95 <- qnorm(0.95, mu, sigma)
cat("10th percentile (bottom 10%):", round(percentile_10, 1), "mg/dL\n")
cat("95th percentile (top 5%):", round(percentile_95, 1), "mg/dL\n\n")

# -----------------------------------------------------------------------------
# Exercise 2.3: Standardization (Z-scores)
# -----------------------------------------------------------------------------
cat("Exercise 2.3: Z-scores and Standardization\n")
cat("------------------------------------------\n")

# Convert a cholesterol value to a Z-score
chol_value <- 260   # mg/dL

# Calculate Z-score manually
z_score <- (chol_value - mu) / sigma
cat("Z-score for", chol_value, "mg/dL:", round(z_score, 2), "\n")

# Interpretation
cat("This value is", round(z_score, 2),
    "standard deviations above the mean\n")

# Use the standard normal to find probability
prob <- pnorm(z_score)
cat("Proportion below", chol_value, ":", round(prob, 4), "\n")

# Alternative: use original scale directly
prob_direct <- pnorm(chol_value, mu, sigma)
cat("Direct calculation:", round(prob_direct, 4), "\n\n")

# R also has a scale() function for vectors
cholesterol_data <- c(180, 220, 195, 240, 175, 210)
z_scores <- scale(cholesterol_data, center=mu, scale=sigma)
cat("Z-scores for data vector:\n")
print(round(z_scores, 2))

# Question: If Z = 1.5, what is cholesterol?
z_given <- 1.5
chol_from_z <- mu + z_given * sigma
cat("\nIf Z-score = 1.5, then cholesterol =", chol_from_z, "mg/dL\n\n")

# -----------------------------------------------------------------------------
# Exercise 2.4: Visualizing the Normal Distribution
# -----------------------------------------------------------------------------
cat("Exercise 2.4: Normal Distribution Visualization\n")
cat("-----------------------------------------------\n")

# Create a normal distribution plot
x <- seq(100, 300, length=200)
y <- dnorm(x, mean=mu, sd=sigma)

plot(x, y, type="l", lwd=2, col="blue",
     main="Normal Distribution of Cholesterol",
     xlab="Cholesterol (mg/dL)",
     ylab="Density")

# Add vertical lines for mean and +/- 1 SD
abline(v=mu, col="red", lwd=2, lty=1)
abline(v=c(mu-sigma, mu+sigma), col="red", lwd=1, lty=2)

# Shade region above 240
x_high <- seq(240, 300, length=100)
y_high <- dnorm(x_high, mu, sigma)
polygon(c(240, x_high, 300), c(0, y_high, 0),
        col=rgb(1,0,0,0.3), border=NA)

# Add text
text(mu, max(y)*0.9, "Mean", pos=3)
text(240, max(y)*0.5, "High\nCholesterol", pos=4)

# Add legend
legend("topright",
       legend=c("Mean", "+/- 1 SD"),
       col="red",
       lty=c(1,2),
       lwd=c(2,1))

cat("Visualization complete!\n\n")

# =============================================================================
# PART 3: SAMPLING DISTRIBUTIONS AND CENTRAL LIMIT THEOREM
# =============================================================================

cat("\n\nPART 3: SAMPLING DISTRIBUTIONS AND CLT\n")
cat("========================================\n\n")

# -----------------------------------------------------------------------------
# Exercise 3.1: Understanding Standard Error
# -----------------------------------------------------------------------------
cat("Exercise 3.1: Standard Error for Different Sample Sizes\n")
cat("--------------------------------------------------------\n")

# Population parameters
pop_mean <- 120        # mean blood pressure
pop_sd <- 20           # population SD

# Calculate standard error for different sample sizes
sample_sizes <- c(5, 10, 25, 50, 100)

cat("Sample Size\tStandard Error\n")
cat("-------------------------------\n")
for (n in sample_sizes) {
  se <- pop_sd / sqrt(n)
  cat("n =", n, "\t\t SE =", round(se, 2), "\n")
}

cat("\nNotice: SE decreases as n increases!\n")
cat("To cut SE in half, you must QUADRUPLE the sample size\n")
cat("Example: SE at n=25 is", round(pop_sd/sqrt(25), 2),
    ", SE at n=100 is", round(pop_sd/sqrt(100), 2), "\n\n")

# -----------------------------------------------------------------------------
# Exercise 3.2: Simulating the Sampling Distribution
# -----------------------------------------------------------------------------
cat("Exercise 3.2: Simulating Sampling Distribution\n")
cat("-----------------------------------------------\n")

# Simulate drawing many samples and computing their means
set.seed(524)

pop_mean <- 120
pop_sd <- 20
sample_size <- 30
num_samples <- 1000

# Draw 1000 samples, each of size 30, and compute their means
sample_means <- replicate(num_samples, {
  sample_data <- rnorm(sample_size, mean=pop_mean, sd=pop_sd)
  mean(sample_data)
})

# Summary of the sampling distribution
cat("Mean of sample means:", round(mean(sample_means), 2), "\n")
cat("SD of sample means (empirical SE):", round(sd(sample_means), 2), "\n")
cat("Theoretical SE:", round(pop_sd/sqrt(sample_size), 2), "\n")
cat("Close match! This confirms the Central Limit Theorem\n\n")

# Visualize the sampling distribution
hist(sample_means, breaks=30, prob=TRUE,
     main=paste("Sampling Distribution of Mean (n=", sample_size, ")", sep=""),
     xlab="Sample Mean",
     ylab="Density",
     col="lightblue",
     border="white")

# Overlay theoretical normal distribution
se_theoretical <- pop_sd / sqrt(sample_size)
curve(dnorm(x, mean=pop_mean, sd=se_theoretical),
      add=TRUE, col="red", lwd=2)

legend("topright",
       legend="Theoretical (CLT)",
       col="red",
       lwd=2)

# -----------------------------------------------------------------------------
# Exercise 3.3: CLT with Non-Normal Data
# -----------------------------------------------------------------------------
cat("Exercise 3.3: CLT with Non-Normal (Exponential) Data\n")
cat("----------------------------------------------------\n")

# Population: Exponential distribution (highly skewed!)
set.seed(123)

# Compare sampling distributions for different sample sizes
par(mfrow=c(2,2))  # 2x2 plot layout

sample_sizes_clt <- c(5, 10, 30, 100)

for (n in sample_sizes_clt) {
  # Draw 1000 sample means
  sample_means_exp <- replicate(1000, {
    mean(rexp(n, rate=1/50))  # exponential with mean=50
  })

  # Plot histogram
  hist(sample_means_exp, breaks=30, prob=TRUE,
       main=paste("n =", n),
       xlab="Sample Mean",
       col="lightblue",
       border="white")

  # Overlay theoretical normal
  se <- 50 / sqrt(n)  # SE for exponential(mean=50)
  curve(dnorm(x, mean=50, sd=se), add=TRUE, col="red", lwd=2)
}

par(mfrow=c(1,1))  # Reset plot layout

cat("Amazing! Even with a highly skewed population,\n")
cat("the sampling distribution becomes normal as n increases!\n\n")

# -----------------------------------------------------------------------------
# Exercise 3.4: Probability Calculations with Sample Means
# -----------------------------------------------------------------------------
cat("Exercise 3.4: Probabilities for Sample Means\n")
cat("--------------------------------------------\n")

# Population: cholesterol with mean=200, SD=40
# Sample size: n=64

pop_mean_chol <- 200
pop_sd_chol <- 40
n_chol <- 64

# Standard error
se_chol <- pop_sd_chol / sqrt(n_chol)
cat("Standard Error:", se_chol, "\n")

# Probability that sample mean > 210
prob_above_210 <- pnorm(210, mean=pop_mean_chol, sd=se_chol, lower.tail=FALSE)
cat("P(sample mean > 210):", round(prob_above_210, 4), "\n")

# Probability that sample mean is between 195 and 205
prob_between_means <- pnorm(205, pop_mean_chol, se_chol) - pnorm(195, pop_mean_chol, se_chol)
cat("P(195 < sample mean < 205):", round(prob_between_means, 4), "\n")

# Compare with individual probability
prob_individual <- pnorm(205, pop_mean_chol, pop_sd_chol) - pnorm(195, pop_mean_chol, pop_sd_chol)
cat("\nFor comparison, P(195 < individual < 205):",
    round(prob_individual, 4), "\n")
cat("Sample means are MUCH more concentrated around the population mean!\n\n")

# =============================================================================
# PART 4: CONFIDENCE INTERVALS
# =============================================================================

cat("\n\nPART 4: CONFIDENCE INTERVALS\n")
cat("=============================\n\n")

# -----------------------------------------------------------------------------
# Exercise 4.1: Manual CI Calculation
# -----------------------------------------------------------------------------
cat("Exercise 4.1: Manual Confidence Interval Calculation\n")
cat("-----------------------------------------------------\n")

# Sample data: tumor growth measurements (mm)
tumor_growth <- c(7, 10, 9, 8, 7, 6, 8, 9, 12, 13)

# Calculate sample statistics
xbar <- mean(tumor_growth)
s <- sd(tumor_growth)
n <- length(tumor_growth)

cat("Sample mean:", round(xbar, 2), "mm\n")
cat("Sample SD:", round(s, 3), "mm\n")
cat("Sample size:", n, "\n\n")

# Calculate standard error
se <- s / sqrt(n)
cat("Standard error:", round(se, 3), "mm\n\n")

# 95% Confidence Interval using t-distribution
alpha <- 0.05
df <- n - 1
t_critical <- qt(1 - alpha/2, df)

cat("Degrees of freedom:", df, "\n")
cat("t critical value:", round(t_critical, 3), "\n\n")

# Margin of error
margin_error <- t_critical * se

# Confidence interval
ci_lower <- xbar - margin_error
ci_upper <- xbar + margin_error

cat("Margin of error:", round(margin_error, 3), "mm\n")
cat("\n95% Confidence Interval:\n")
cat("(", round(ci_lower, 2), ", ", round(ci_upper, 2), ") mm\n", sep="")
cat("\nInterpretation: We are 95% confident that the true mean tumor growth\n")
cat("is between", round(ci_lower, 2), "and", round(ci_upper, 2), "mm.\n\n")

# -----------------------------------------------------------------------------
# Exercise 4.2: Using t.test() for CIs
# -----------------------------------------------------------------------------
cat("Exercise 4.2: Confidence Intervals using t.test()\n")
cat("--------------------------------------------------\n")

# Much easier method: use t.test()
result <- t.test(tumor_growth, conf.level=0.95)

# Extract confidence interval
ci <- result$conf.int
cat("95% CI from t.test():", round(ci, 2), "mm\n\n")

# The t.test() function gives us additional info
cat("Full t.test() output:\n")
print(result)

# For 99% CI, just change conf.level
result_99 <- t.test(tumor_growth, conf.level=0.99)
cat("\n99% CI:", round(result_99$conf.int, 2), "mm\n\n")

# -----------------------------------------------------------------------------
# Exercise 4.3: Comparing Different Confidence Levels
# -----------------------------------------------------------------------------
cat("Exercise 4.3: Comparing Confidence Levels\n")
cat("-----------------------------------------\n")

# Compare 90%, 95%, and 99% confidence intervals
confidence_levels <- c(0.90, 0.95, 0.99)

cat("Confidence Level\tInterval\t\t\tWidth\n")
cat("--------------------------------------------------------\n")
for (conf in confidence_levels) {
  ci <- t.test(tumor_growth, conf.level=conf)$conf.int
  width <- ci[2] - ci[1]

  cat(conf*100, "%\t\t\t(", round(ci[1], 2), ", ", round(ci[2], 2),
      ")\t\t", round(width, 2), "\n", sep="")
}

cat("\nNotice: Higher confidence level = wider interval\n")
cat("Trade-off: More confidence requires less precision\n\n")

# -----------------------------------------------------------------------------
# Exercise 4.4: Effect of Sample Size on CIs
# -----------------------------------------------------------------------------
cat("Exercise 4.4: Effect of Sample Size on CI Width\n")
cat("------------------------------------------------\n")

# Generate larger sample from same population
set.seed(42)

# Small sample (n=10)
small_sample <- rnorm(10, mean=100, sd=15)
ci_small <- t.test(small_sample)$conf.int
width_small <- ci_small[2] - ci_small[1]

# Large sample (n=100)
large_sample <- rnorm(100, mean=100, sd=15)
ci_large <- t.test(large_sample)$conf.int
width_large <- ci_large[2] - ci_large[1]

cat("Small sample (n=10):\n")
cat("  95% CI:", round(ci_small, 2), "\n")
cat("  Width:", round(width_small, 2), "\n\n")

cat("Large sample (n=100):\n")
cat("  95% CI:", round(ci_large, 2), "\n")
cat("  Width:", round(width_large, 2), "\n\n")

cat("Larger sample gives narrower (more precise) CI!\n")
cat("Width ratio:", round(width_small/width_large, 2), "\n")
cat("The small sample CI is about", round(width_small/width_large, 1),
    "times wider\n\n")

# =============================================================================
# PRACTICE PROBLEMS
# =============================================================================

cat("\n\nPRACTICE PROBLEMS - SOLUTIONS\n")
cat("==============================\n\n")

# -----------------------------------------------------------------------------
# Problem 1: Vaccine Efficacy
# -----------------------------------------------------------------------------
cat("Problem 1: COVID-19 Vaccine (n=50, p=0.92)\n")
cat("-------------------------------------------\n")

n_vaccine <- 50
p_vaccine <- 0.92

# a) Probability at least 45 protected
prob_at_least_45 <- pbinom(44, n_vaccine, p_vaccine, lower.tail=FALSE)
cat("a) P(X >= 45):", round(prob_at_least_45, 4), "\n")

# b) Expected number protected
expected_protected <- n_vaccine * p_vaccine
cat("b) Expected number protected:", expected_protected, "\n\n")

# c) Visualization
x_vals <- 0:n_vaccine
probs <- dbinom(x_vals, n_vaccine, p_vaccine)

bp <- barplot(probs,
        names.arg = x_vals,
        main = "COVID-19 Vaccine Efficacy (n=50, p=0.92)",
        xlab = "Number Protected",
        ylab = "Probability",
        col = "lightgreen",
        border = "white")

abline(v = bp[which(x_vals == expected_protected)], col = "red", lwd = 2, lty = 2)
legend("topleft", legend = "Expected Value", col = "red", lty = 2, lwd = 2)

cat("c) Visualization created!\n\n")

# -----------------------------------------------------------------------------
# Problem 2: Birth Weights
# -----------------------------------------------------------------------------
cat("Problem 2: Birth Weights (mu=3400g, sigma=500g)\n")
cat("-----------------------------------------------\n")

mu_birth <- 3400
sigma_birth <- 500

# a) Proportion with low birth weight (< 2500g)
prob_low_birth <- pnorm(2500, mu_birth, sigma_birth)
cat("a) P(X < 2500):", round(prob_low_birth, 4), "\n")
cat("   About", round(prob_low_birth*100, 1), "% have low birth weight\n\n")

# b) 10th percentile
percentile_10_birth <- qnorm(0.10, mu_birth, sigma_birth)
cat("b) 10th percentile:", round(percentile_10_birth, 1), "g\n\n")

# c) Proportion between 3000g and 4000g
prob_between_birth <- pnorm(4000, mu_birth, sigma_birth) - pnorm(3000, mu_birth, sigma_birth)
cat("c) P(3000 < X < 4000):", round(prob_between_birth, 4), "\n")
cat("   About", round(prob_between_birth*100, 1), "% have birth weight in this range\n\n")

# -----------------------------------------------------------------------------
# Problem 3: Sampling Distribution (Blood Glucose)
# -----------------------------------------------------------------------------
cat("Problem 3: Blood Glucose Sampling (mu=100, sigma=20, n=36)\n")
cat("----------------------------------------------------------\n")

mu_glucose <- 100
sigma_glucose <- 20
n_glucose <- 36

# a) Distribution of sample mean
se_glucose <- sigma_glucose / sqrt(n_glucose)
cat("a) Sample mean follows N(mu=", mu_glucose, ", SE=",
    round(se_glucose, 3), ")\n\n", sep="")

# b) Probability sample mean exceeds 105
prob_exceed_105 <- pnorm(105, mu_glucose, se_glucose, lower.tail=FALSE)
cat("b) P(sample mean > 105):", round(prob_exceed_105, 4), "\n\n")

# c) Range containing 95% of sample means
# This is mean +/- 1.96*SE
lower_95 <- mu_glucose - 1.96 * se_glucose
upper_95 <- mu_glucose + 1.96 * se_glucose
cat("c) 95% of sample means fall between:",
    round(lower_95, 2), "and", round(upper_95, 2), "mg/dL\n")
cat("   OR: 100 +/- 1.96(", round(se_glucose, 3),
    ") = (", round(lower_95, 2), ", ", round(upper_95, 2), ")\n\n", sep="")

# -----------------------------------------------------------------------------
# Problem 4: Confidence Interval (Pain Reduction)
# -----------------------------------------------------------------------------
cat("Problem 4: Pain Reduction Study (n=25, mean=5.2, sd=2.1)\n")
cat("--------------------------------------------------------\n")

xbar_pain <- 5.2
s_pain <- 2.1
n_pain <- 25

# a) 95% confidence interval
se_pain <- s_pain / sqrt(n_pain)
df_pain <- n_pain - 1
t_crit_pain <- qt(0.975, df_pain)
me_pain <- t_crit_pain * se_pain

ci_lower_pain <- xbar_pain - me_pain
ci_upper_pain <- xbar_pain + me_pain

cat("a) 95% CI: (", round(ci_lower_pain, 2), ", ",
    round(ci_upper_pain, 2), ") points\n\n", sep="")

# b) Interpretation
cat("b) We are 95% confident that the true mean pain reduction\n")
cat("   is between", round(ci_lower_pain, 2), "and",
    round(ci_upper_pain, 2), "points.\n\n")

# c) 90% CI width comparison
t_crit_90 <- qt(0.95, df_pain)
me_90 <- t_crit_90 * se_pain
width_95 <- ci_upper_pain - ci_lower_pain
width_90 <- 2 * me_90
width_diff <- width_95 - width_90

cat("c) A 90% CI would be NARROWER than the 95% CI\n")
cat("   95% CI width:", round(width_95, 3), "\n")
cat("   90% CI width:", round(width_90, 3), "\n")
cat("   Difference:", round(width_diff, 3), "points narrower\n\n")

# -----------------------------------------------------------------------------
# Problem 5: CLT Simulation
# -----------------------------------------------------------------------------
cat("Problem 5: CLT Simulation (mu=75, sigma=12, n=40)\n")
cat("-------------------------------------------------\n")

set.seed(999)

mu_sim <- 75
sigma_sim <- 12
n_sim <- 40
num_samples_sim <- 1000

# a) Generate 1000 samples of size 40
sample_means_sim <- replicate(num_samples_sim, {
  mean(rnorm(n_sim, mean=mu_sim, sd=sigma_sim))
})

cat("a) Generated", num_samples_sim, "sample means\n\n")

# b) Plot histogram
hist(sample_means_sim, breaks=30, prob=TRUE,
     main="CLT Simulation: Sampling Distribution of Mean",
     xlab="Sample Mean",
     ylab="Density",
     col="lightblue",
     border="white")

# c) Compare empirical vs theoretical SE
empirical_se <- sd(sample_means_sim)
theoretical_se <- sigma_sim / sqrt(n_sim)

cat("b) Histogram created\n\n")
cat("c) Empirical SE:", round(empirical_se, 3), "\n")
cat("   Theoretical SE:", round(theoretical_se, 3), "\n")
cat("   Very close match!\n\n")

# d) Overlay theoretical normal curve
curve(dnorm(x, mean=mu_sim, sd=theoretical_se),
      add=TRUE, col="red", lwd=2)

legend("topright",
       legend=c("Empirical", "Theoretical CLT"),
       fill=c("lightblue", NA),
       border=c("black", NA),
       col=c(NA, "red"),
       lty=c(NA, 1),
       lwd=c(NA, 2))

cat("d) Theoretical normal curve overlaid\n")
cat("   Perfect match! This demonstrates the Central Limit Theorem!\n\n")

# =============================================================================
# SUMMARY
# =============================================================================

cat("\n\n=============================================================================\n")
cat("LAB COMPLETE!\n")
cat("=============================================================================\n\n")

cat("Key Concepts Covered:\n")
cat("1. Binomial Distribution: dbinom(), pbinom()\n")
cat("2. Normal Distribution: pnorm(), qnorm(), dnorm()\n")
cat("3. Standardization: Z-scores and scale()\n")
cat("4. Sampling Distributions: SE = sigma / sqrt(n)\n")
cat("5. Central Limit Theorem: Works even for non-normal populations!\n")
cat("6. Confidence Intervals: t.test() and manual calculation\n")
cat("7. Effect of sample size: Larger n = narrower CI, smaller SE\n\n")

cat("Remember:\n")
cat("- Use 'd' functions for probability/density at specific values\n")
cat("- Use 'p' functions for cumulative probability\n")
cat("- Use 'q' functions for quantiles (inverse probability)\n")
cat("- Use 'r' functions for random generation\n")
cat("- Always check lower.tail=TRUE or FALSE!\n\n")

cat("Save your workspace:\n")
cat('save.image("week3_lab.RData")\n\n')

# Optionally save workspace
# save.image("week3_lab.RData")

cat("Great work! You've mastered probability distributions and sampling!\n")
