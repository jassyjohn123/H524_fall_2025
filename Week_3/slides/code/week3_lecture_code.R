################################################################################
# H524 Introduction to Biostatistics
# Week 3: Probability Distributions and Sampling Distributions
# Fall 2025
# Dr. John Molitor
#
# This code demonstrates all major concepts from Week 3 including:
# - Binomial distribution calculations and visualization
# - Normal distribution calculations and standardization
# - t-distribution for small samples
# - Sampling distributions and Central Limit Theorem
# - Confidence intervals (z and t methods)
# - Key visualizations
################################################################################

# Clear workspace and set options
rm(list = ls())
options(scipen = 999)  # Avoid scientific notation
set.seed(524)          # For reproducibility

################################################################################
# SECTION 1: BINOMIAL DISTRIBUTION
################################################################################

cat("=== BINOMIAL DISTRIBUTION ===\n\n")

# Example 1: Clinical Trial with Treatment Success Rate
cat("Example 1: Clinical Trial (n=10, p=0.75)\n")
n <- 10
p <- 0.75

# Probability of exactly 8 successes
prob_8 <- dbinom(8, n, p)
cat("P(X = 8) =", round(prob_8, 4), "\n")

# Probability of at least 8 successes
prob_at_least_8 <- pbinom(7, n, p, lower.tail=FALSE)
cat("P(X >= 8) =", round(prob_at_least_8, 4), "\n")

# Expected value and standard deviation
expected <- n * p
std_dev <- sqrt(n * p * (1 - p))
cat("Expected successes:", expected, "\n")
cat("Standard deviation:", round(std_dev, 3), "\n\n")

# Example 2: Carcinogen Exposure (from Pagano & Gauvreau)
cat("Example 2: Carcinogen Exposure (n=4, p=0.25)\n")
n_carcin <- 4
p_carcin <- 0.25

# Calculate probabilities for 0, 1, 2, 3, 4 people becoming ill
cat("k\tProbability\tFraction\n")
for (k in 0:n_carcin) {
  prob <- dbinom(k, n_carcin, p_carcin)
  cat(k, "\t", round(prob, 4), "\t\t",
      round(prob * 256), "/256\n", sep="")
}

# Probability at least one becomes ill
prob_at_least_one <- 1 - dbinom(0, n_carcin, p_carcin)
cat("P(at least one ill) =", round(prob_at_least_one, 4), "\n\n")

# Example 3: Vaccine Efficacy
cat("Example 3: Vaccine Efficacy (n=20, p=0.90)\n")
n_vaccine <- 20
p_vaccine <- 0.90

# Probability exactly 18 protected
prob_18 <- dbinom(18, n_vaccine, p_vaccine)
cat("P(X = 18) =", round(prob_18, 4), "\n")

# Probability at least 18 protected
prob_at_least_18 <- pbinom(17, n_vaccine, p_vaccine, lower.tail=FALSE)
cat("P(X >= 18) =", round(prob_at_least_18, 4), "\n")

# Expected and SD
cat("Expected protected:", n_vaccine * p_vaccine, "\n")
cat("SD:", round(sqrt(n_vaccine * p_vaccine * (1 - p_vaccine)), 3), "\n\n")

# Visualization: Binomial Distribution
x_vals <- 0:n_vaccine
probs <- dbinom(x_vals, n_vaccine, p_vaccine)

barplot(probs,
        names.arg = x_vals,
        main = "Binomial Distribution (n=20, p=0.90)",
        xlab = "Number Protected",
        ylab = "Probability",
        col = "lightblue",
        border = "white")
abline(v = n_vaccine*p_vaccine + 0.5, col = "red", lwd = 2, lty = 2)
legend("topleft", "Expected Value", col = "red", lty = 2, lwd = 2)

################################################################################
# SECTION 2: NORMAL DISTRIBUTION
################################################################################

cat("\n=== NORMAL DISTRIBUTION ===\n\n")

# Example 1: Exam Scores
cat("Example 1: Exam Scores (mu=70, sigma=10)\n")
mu_exam <- 70
sigma_exam <- 10

# Probability score > 85
z_85 <- (85 - mu_exam) / sigma_exam
prob_above_85 <- pnorm(85, mu_exam, sigma_exam, lower.tail=FALSE)
cat("Z-score for 85:", round(z_85, 2), "\n")
cat("P(Score > 85) =", round(prob_above_85, 4), "\n")

# Probability score between 60 and 85
prob_between <- pnorm(85, mu_exam, sigma_exam) - pnorm(60, mu_exam, sigma_exam)
cat("P(60 < Score < 85) =", round(prob_between, 4), "\n")

# 90th percentile
percentile_90 <- qnorm(0.90, mu_exam, sigma_exam)
cat("90th percentile:", round(percentile_90, 1), "\n\n")

# Example 2: Cholesterol Levels
cat("Example 2: Cholesterol (mu=200, sigma=40)\n")
mu_chol <- 200
sigma_chol <- 40

# Probability > 240 (high cholesterol)
prob_high <- pnorm(240, mu_chol, sigma_chol, lower.tail=FALSE)
cat("P(Cholesterol > 240) =", round(prob_high, 4), "\n")
cat("Approximately", round(prob_high * 100, 1), "% have high cholesterol\n")

# Probability between 180 and 220
prob_desirable <- pnorm(220, mu_chol, sigma_chol) - pnorm(180, mu_chol, sigma_chol)
cat("P(180 < Cholesterol < 220) =", round(prob_desirable, 4), "\n")

# Percentiles
cat("25th percentile:", round(qnorm(0.25, mu_chol, sigma_chol), 1), "\n")
cat("50th percentile:", round(qnorm(0.50, mu_chol, sigma_chol), 1), "\n")
cat("75th percentile:", round(qnorm(0.75, mu_chol, sigma_chol), 1), "\n")
cat("90th percentile:", round(qnorm(0.90, mu_chol, sigma_chol), 1), "\n\n")

# Visualization: Normal Distribution
x_norm <- seq(100, 300, length=200)
y_norm <- dnorm(x_norm, mu_chol, sigma_chol)

plot(x_norm, y_norm, type="l", lwd=2, col="blue",
     main="Cholesterol Distribution",
     xlab="Cholesterol (mg/dL)",
     ylab="Density")
abline(v=mu_chol, col="red", lwd=2)
abline(v=c(mu_chol-sigma_chol, mu_chol+sigma_chol),
       col="red", lwd=1, lty=2)
abline(v=240, col="darkred", lwd=2, lty=3)
legend("topright",
       c("Mean", "+/- 1 SD", "High (240)"),
       col=c("red", "red", "darkred"),
       lty=c(1, 2, 3),
       lwd=c(2, 1, 2))

# Example 3: Standardization
cat("Example 3: Standardization\n")
chol_value <- 260
z_score <- (chol_value - mu_chol) / sigma_chol
cat("Cholesterol value:", chol_value, "mg/dL\n")
cat("Z-score:", round(z_score, 2), "\n")
cat("This is", round(z_score, 2), "standard deviations above the mean\n")
cat("Proportion below this value:", round(pnorm(z_score), 4), "\n\n")

################################################################################
# SECTION 3: EMPIRICAL RULE
################################################################################

cat("=== EMPIRICAL RULE ===\n\n")

# Blood pressure example
mu_bp <- 120
sigma_bp <- 15

# 68% within 1 SD
range_1sd <- c(mu_bp - sigma_bp, mu_bp + sigma_bp)
prob_1sd <- pnorm(range_1sd[2], mu_bp, sigma_bp) -
            pnorm(range_1sd[1], mu_bp, sigma_bp)
cat("68% of BP values between", range_1sd[1], "and", range_1sd[2], "mmHg\n")
cat("Actual proportion:", round(prob_1sd, 4), "\n")

# 95% within 2 SDs
range_2sd <- c(mu_bp - 2*sigma_bp, mu_bp + 2*sigma_bp)
prob_2sd <- pnorm(range_2sd[2], mu_bp, sigma_bp) -
            pnorm(range_2sd[1], mu_bp, sigma_bp)
cat("95% of BP values between", range_2sd[1], "and", range_2sd[2], "mmHg\n")
cat("Actual proportion:", round(prob_2sd, 4), "\n")

# 99.7% within 3 SDs
range_3sd <- c(mu_bp - 3*sigma_bp, mu_bp + 3*sigma_bp)
prob_3sd <- pnorm(range_3sd[2], mu_bp, sigma_bp) -
            pnorm(range_3sd[1], mu_bp, sigma_bp)
cat("99.7% of BP values between", range_3sd[1], "and", range_3sd[2], "mmHg\n")
cat("Actual proportion:", round(prob_3sd, 4), "\n\n")

################################################################################
# SECTION 4: t-DISTRIBUTION
################################################################################

cat("=== t-DISTRIBUTION ===\n\n")

# Compare critical values for different sample sizes
cat("Critical values for 95% confidence:\n")
cat("Sample Size\tdf\tt-value\t\tz-value\n")
for (n in c(5, 10, 20, 30, 50, 100)) {
  df <- n - 1
  t_crit <- qt(0.975, df)
  z_crit <- qnorm(0.975)
  cat(n, "\t\t", df, "\t", round(t_crit, 3), "\t\t", round(z_crit, 3), "\n")
}
cat("\nNote: As n increases, t-values approach z-value (1.96)\n\n")

# Visualization: Compare normal and t-distributions
x_comp <- seq(-4, 4, length=200)
y_norm <- dnorm(x_comp)
y_t5 <- dt(x_comp, df=5)
y_t30 <- dt(x_comp, df=30)

plot(x_comp, y_norm, type="l", lwd=2, col="blue",
     main="Comparing Normal and t-Distributions",
     xlab="Value", ylab="Density", ylim=c(0, 0.4))
lines(x_comp, y_t5, col="red", lwd=2)
lines(x_comp, y_t30, col="orange", lwd=2)
legend("topright",
       c("Normal", "t (df=5)", "t (df=30)"),
       col=c("blue", "red", "orange"),
       lwd=2)

################################################################################
# SECTION 5: SAMPLING DISTRIBUTIONS
################################################################################

cat("\n=== SAMPLING DISTRIBUTIONS ===\n\n")

# Example: Standard Error for Different Sample Sizes
cat("Standard Error for Different Sample Sizes\n")
pop_sd <- 20
cat("Population SD:", pop_sd, "\n")
cat("n\tStandard Error\n")
for (n in c(5, 10, 25, 50, 100, 400)) {
  se <- pop_sd / sqrt(n)
  cat(n, "\t", round(se, 3), "\n")
}
cat("\nNote: To halve SE, need to quadruple sample size!\n\n")

# Example: IQ Study
cat("Example: IQ Study (n=90, known variance)\n")
pop_mean_iq <- 100
known_sd <- 10
n_iq <- 90
sample_mean <- 105

se_iq <- known_sd / sqrt(n_iq)
z_stat <- (sample_mean - pop_mean_iq) / se_iq

cat("Population mean:", pop_mean_iq, "\n")
cat("Sample mean:", sample_mean, "\n")
cat("Sample size:", n_iq, "\n")
cat("Known SD:", known_sd, "\n")
cat("Standard error:", round(se_iq, 3), "\n")
cat("Z-statistic:", round(z_stat, 3), "\n")
cat("P-value:", format(pnorm(z_stat, lower.tail=FALSE), scientific=FALSE), "\n\n")

################################################################################
# SECTION 6: CENTRAL LIMIT THEOREM DEMONSTRATION
################################################################################

cat("=== CENTRAL LIMIT THEOREM ===\n\n")

# Simulate sampling distribution for normal population
cat("Simulating CLT for Normal Population\n")
pop_mean <- 120
pop_sd <- 20
sample_size <- 30
num_samples <- 1000

sample_means_normal <- replicate(num_samples, {
  sample_data <- rnorm(sample_size, pop_mean, pop_sd)
  mean(sample_data)
})

cat("Population mean:", pop_mean, "\n")
cat("Mean of sample means:", round(mean(sample_means_normal), 2), "\n")
cat("Theoretical SE:", round(pop_sd/sqrt(sample_size), 2), "\n")
cat("Empirical SE:", round(sd(sample_means_normal), 2), "\n\n")

# Visualize
hist(sample_means_normal, breaks=30, prob=TRUE,
     main="Sampling Distribution (Normal Population)",
     xlab="Sample Mean", ylab="Density",
     col="lightblue", border="white")
se_theoretical <- pop_sd / sqrt(sample_size)
curve(dnorm(x, pop_mean, se_theoretical),
      add=TRUE, col="red", lwd=2)
legend("topright", "Theoretical Normal", col="red", lwd=2)

# CLT with non-normal (exponential) population
cat("Simulating CLT for Exponential (Skewed) Population\n")
par(mfrow=c(2,2))

for (n in c(5, 10, 30, 100)) {
  sample_means_exp <- replicate(1000, {
    mean(rexp(n, rate=1/50))
  })

  hist(sample_means_exp, breaks=30, prob=TRUE,
       main=paste("n =", n),
       xlab="Sample Mean",
       col="lightgreen", border="white")

  se_exp <- 50 / sqrt(n)
  curve(dnorm(x, 50, se_exp), add=TRUE, col="red", lwd=2)
}
par(mfrow=c(1,1))

cat("Even from skewed population, sample means become normal!\n\n")

################################################################################
# SECTION 7: CONFIDENCE INTERVALS
################################################################################

cat("=== CONFIDENCE INTERVALS ===\n\n")

# Example 1: Tumor Growth (t-distribution)
cat("Example 1: Tumor Growth (t-distribution)\n")
tumor_growth <- c(7, 10, 9, 8, 7, 6, 8, 9, 12, 13)

xbar <- mean(tumor_growth)
s <- sd(tumor_growth)
n <- length(tumor_growth)
se <- s / sqrt(n)
df <- n - 1

t_crit <- qt(0.975, df)
margin_error <- t_crit * se

ci_lower <- xbar - margin_error
ci_upper <- xbar + margin_error

cat("Sample mean:", round(xbar, 2), "mm\n")
cat("Sample SD:", round(s, 3), "mm\n")
cat("Sample size:", n, "\n")
cat("Standard error:", round(se, 3), "\n")
cat("Degrees of freedom:", df, "\n")
cat("t critical value:", round(t_crit, 3), "\n")
cat("95% CI: (", round(ci_lower, 2), ", ", round(ci_upper, 2), ") mm\n\n", sep="")

# Using t.test()
result <- t.test(tumor_growth)
cat("Using t.test():\n")
cat("95% CI:", round(result$conf.int, 2), "\n\n")

# Example 2: Large Sample (z-distribution)
cat("Example 2: IQ Study (known variance, z-distribution)\n")
xbar_iq <- 105
known_sigma <- 10
n_iq <- 90

se_iq <- known_sigma / sqrt(n_iq)
z_crit <- qnorm(0.975)
margin_z <- z_crit * se_iq

ci_iq <- xbar_iq + c(-1, 1) * margin_z

cat("Sample mean:", xbar_iq, "\n")
cat("Known sigma:", known_sigma, "\n")
cat("Sample size:", n_iq, "\n")
cat("Standard error:", round(se_iq, 3), "\n")
cat("z critical value:", round(z_crit, 3), "\n")
cat("95% CI: (", round(ci_iq[1], 2), ", ", round(ci_iq[2], 2), ")\n\n", sep="")

# Comparing confidence levels
cat("Comparing Different Confidence Levels\n")
for (conf in c(0.90, 0.95, 0.99)) {
  ci <- t.test(tumor_growth, conf.level=conf)$conf.int
  width <- ci[2] - ci[1]
  cat(conf*100, "% CI: (", round(ci[1], 2), ", ", round(ci[2], 2),
      ")  Width:", round(width, 2), "\n", sep="")
}
cat("\nHigher confidence requires wider interval!\n\n")

################################################################################
# SECTION 8: SAMPLE SIZE EFFECTS
################################################################################

cat("=== EFFECT OF SAMPLE SIZE ===\n\n")

# Generate samples of different sizes
set.seed(42)
true_mean <- 100
true_sd <- 15

sample_sizes <- c(10, 25, 50, 100)

cat("Effect of Sample Size on CI Width\n")
cat("n\tWidth\t\tReduction\n")
previous_width <- NA

for (n in sample_sizes) {
  sample_data <- rnorm(n, true_mean, true_sd)
  ci <- t.test(sample_data)$conf.int
  width <- ci[2] - ci[1]

  if (is.na(previous_width)) {
    cat(n, "\t", round(width, 2), "\t\t--\n", sep="")
  } else {
    reduction <- previous_width / width
    cat(n, "\t", round(width, 2), "\t\t", round(reduction, 2), "x\n", sep="")
  }
  previous_width <- width
}

################################################################################
# SECTION 9: PRACTICE PROBLEM SOLUTIONS
################################################################################

cat("\n=== PRACTICE PROBLEM SOLUTIONS ===\n\n")

# Problem 1: Antibiotic treatment
cat("Problem 1: Antibiotic (n=15, p=0.75)\n")
prob_12 <- dbinom(12, 15, 0.75)
prob_at_least_10 <- pbinom(9, 15, 0.75, lower.tail=FALSE)
cat("P(X = 12):", round(prob_12, 4), "\n")
cat("P(X >= 10):", round(prob_at_least_10, 4), "\n\n")

# Problem 2: Birth weights
cat("Problem 2: Birth Weights (mu=3400g, sigma=500g)\n")
prob_low <- pnorm(2500, 3400, 500)
percentile_10 <- qnorm(0.10, 3400, 500)
prob_between <- pnorm(4000, 3400, 500) - pnorm(3000, 3400, 500)
cat("P(Low birth weight < 2500g):", round(prob_low, 4), "\n")
cat("10th percentile:", round(percentile_10, 0), "g\n")
cat("P(3000 < weight < 4000):", round(prob_between, 4), "\n\n")

# Problem 3: Sampling distribution
cat("Problem 3: Blood Glucose Sampling (mu=100, sigma=20, n=36)\n")
se_glucose <- 20 / sqrt(36)
prob_above_105 <- pnorm(105, 100, se_glucose, lower.tail=FALSE)
cat("Standard error:", round(se_glucose, 3), "\n")
cat("P(sample mean > 105):", round(prob_above_105, 4), "\n\n")

# Problem 4: Cholesterol CI
cat("Problem 4: Cholesterol Reduction CI\n")
chol_reduction <- c(28, 32, 25, 30, 27, 35, 22, 29, 31, 26,
                    24, 33, 28, 30, 27, 29, 31, 25, 28, 32,
                    26, 30, 29, 27, 34, 28, 31, 25, 29, 30)
ci_chol <- t.test(chol_reduction)$conf.int
cat("95% CI:", round(ci_chol, 2), "\n")
cat("Evidence of reduction > 25? ",
    ifelse(ci_chol[1] > 25, "Yes", "Unclear"), "\n\n")

################################################################################
# SECTION 10: VISUALIZATIONS SUMMARY
################################################################################

cat("=== CREATING SUMMARY VISUALIZATIONS ===\n\n")

# Create comprehensive plot
par(mfrow=c(2,2))

# 1. Binomial distribution
x1 <- 0:20
y1 <- dbinom(x1, 20, 0.85)
barplot(y1, names.arg=x1, col="lightblue",
        main="Binomial (n=20, p=0.85)",
        xlab="Successes", ylab="Probability")

# 2. Normal distribution
x2 <- seq(100, 300, length=200)
y2 <- dnorm(x2, 200, 40)
plot(x2, y2, type="l", lwd=2, col="blue",
     main="Normal (mu=200, sigma=40)",
     xlab="Value", ylab="Density")

# 3. Sampling distribution
sample_means <- replicate(1000, mean(rnorm(30, 120, 20)))
hist(sample_means, breaks=30, prob=TRUE, col="lightgreen",
     main="Sampling Distribution (n=30)",
     xlab="Sample Mean")
curve(dnorm(x, 120, 20/sqrt(30)), add=TRUE, col="red", lwd=2)

# 4. Confidence intervals
set.seed(123)
cis <- t(replicate(50, {
  sample <- rnorm(20, 100, 15)
  t.test(sample)$conf.int
}))
plot(1, type="n", xlim=c(1, 50), ylim=c(85, 115),
     xlab="Sample", ylab="CI", main="50 Confidence Intervals")
for (i in 1:50) {
  col <- ifelse(cis[i,1] <= 100 & cis[i,2] >= 100, "blue", "red")
  lines(c(i, i), cis[i,], col=col)
  points(i, mean(cis[i,]), pch=19, col=col, cex=0.5)
}
abline(h=100, lty=2, col="darkgreen", lwd=2)

par(mfrow=c(1,1))

cat("\n", rep("=", 60), "\n", sep="")
cat("WEEK 3 DEMONSTRATIONS COMPLETE\n")
cat(rep("=", 60), "\n", sep="")
cat("\nAll PDF visualizations saved in slides/code/ directory\n")
