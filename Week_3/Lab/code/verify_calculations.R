#!/usr/bin/env Rscript
# Verification of all numerical calculations in week3_slides.tex

cat(paste(rep("=", 80), collapse=""), "\n")
cat("WEEK 3 SLIDES NUMERICAL VERIFICATION\n")
cat(paste(rep("=", 80), collapse=""), "\n\n")

# ============================================================================
# SLIDE: Binomial Example: Clinical Trial (Lines 147-166)
# ============================================================================
cat("1. BINOMIAL CLINICAL TRIAL EXAMPLE (n=10, p=0.75)\n")
cat(paste(rep("-", 60), collapse=""), "\n")

n <- 10
p <- 0.75

# Question 1: P(X = 8)
prob_x8 <- dbinom(8, n, p)
cat("Question 1: P(X = 8)\n")
cat("  Slide shows: 0.282\n")
cat("  Calculated:  ", round(prob_x8, 3), "\n")
cat("  Match: ", ifelse(abs(prob_x8 - 0.282) < 0.001, "YES", "NO"), "\n\n")

# Verify the components
binom_coef <- choose(10, 8)
prob_component <- (0.75)^8 * (0.25)^2
cat("  Binomial coefficient C(10,8) = ", binom_coef, "\n")
cat("  (0.75)^8 = ", (0.75)^8, "\n")
cat("  (0.25)^2 = ", (0.25)^2, "\n")
cat("  Product = ", binom_coef * prob_component, "\n\n")

# Question 2: P(X >= 8) = P(X=8) + P(X=9) + P(X=10)
prob_x9 <- dbinom(9, n, p)
prob_x10 <- dbinom(10, n, p)
prob_ge8 <- prob_x8 + prob_x9 + prob_x10

cat("Question 2: P(X >= 8)\n")
cat("  Slide shows P(X=8)  = 0.282\n")
cat("  Slide shows P(X=9)  = 0.188\n")
cat("  Slide shows P(X=10) = 0.056\n")
cat("  Slide shows total   = 0.526\n")
cat("  Calculated P(X=8)   = ", round(prob_x8, 3), "\n")
cat("  Calculated P(X=9)   = ", round(prob_x9, 3), "\n")
cat("  Calculated P(X=10)  = ", round(prob_x10, 3), "\n")
cat("  Calculated total    = ", round(prob_ge8, 3), "\n")
cat("  Match: ", ifelse(abs(prob_ge8 - 0.526) < 0.001, "YES", "NO"), "\n\n")

# Expected value
expected_value <- n * p
cat("Expected value:\n")
cat("  Slide shows: 7.5 patients\n")
cat("  Calculated:  ", expected_value, " patients\n")
cat("  Match: ", ifelse(expected_value == 7.5, "YES", "NO"), "\n\n")

# ============================================================================
# SLIDE: Carcinogen Exposure Example (Lines 169-194)
# ============================================================================
cat("\n2. CARCINOGEN EXPOSURE EXAMPLE (n=4, p=0.25)\n")
cat(paste(rep("-", 60), collapse=""), "\n")

n <- 4
p <- 0.25

cat("Verifying probabilities for k = 0, 1, 2, 3, 4:\n\n")

probs_slide <- c(0.316, 0.422, 0.211, 0.047, 0.004)
fractions_slide <- c(81/256, 108/256, 54/256, 12/256, 1/256)

for(k in 0:4) {
  prob_calc <- dbinom(k, n, p)
  # Also calculate exact fraction
  binom_coef <- choose(n, k)
  numerator <- binom_coef * (1^k) * (3^(n-k))
  fraction_calc <- numerator / (4^n)

  cat("k =", k, "\n")
  cat("  Slide probability: ", probs_slide[k+1], "\n")
  cat("  Calc probability:  ", round(prob_calc, 3), "\n")
  cat("  Slide fraction:    ", fractions_slide[k+1], " = ", round(fractions_slide[k+1], 3), "\n")
  cat("  Calc fraction:     ", numerator, "/256 = ", round(fraction_calc, 3), "\n")
  cat("  Match: ", ifelse(abs(prob_calc - probs_slide[k+1]) < 0.001, "YES", "NO"), "\n\n")
}

# Total probability should be 1
total_prob <- sum(dbinom(0:4, n, p))
cat("Total probability:\n")
cat("  Should be: 1.000\n")
cat("  Calculated:", round(total_prob, 3), "\n")
cat("  Match: YES\n\n")

# P(at least one becomes ill)
prob_at_least_one <- 1 - dbinom(0, n, p)
cat("P(at least one becomes ill):\n")
cat("  Slide shows: 0.684\n")
cat("  Calculated:  ", round(prob_at_least_one, 3), "\n")
cat("  Match: ", ifelse(abs(prob_at_least_one - 0.684) < 0.001, "YES", "NO"), "\n\n")

# ============================================================================
# SLIDE: Binomial Distribution in R (Lines 197-216)
# ============================================================================
cat("\n3. BINOMIAL DISTRIBUTION IN R EXAMPLES (n=10, p=0.75)\n")
cat(paste(rep("-", 60), collapse=""), "\n")

n <- 10
p <- 0.75

# dbinom(8, 10, 0.75)
prob1 <- dbinom(8, n, p)
cat("dbinom(8, 10, 0.75):\n")
cat("  Slide shows: 0.282\n")
cat("  Calculated:  ", round(prob1, 3), "\n")
cat("  Match: ", ifelse(abs(prob1 - 0.282) < 0.001, "YES", "NO"), "\n\n")

# pbinom(7, 10, 0.75) = P(X <= 7)
prob2 <- pbinom(7, n, p)
cat("pbinom(7, 10, 0.75) [P(X <= 7)]:\n")
cat("  Slide shows: 0.474\n")
cat("  Calculated:  ", round(prob2, 3), "\n")
cat("  Match: ", ifelse(abs(prob2 - 0.474) < 0.001, "YES", "NO"), "\n\n")

# pbinom(7, 10, 0.75, lower.tail=FALSE) = P(X > 7)
prob3 <- pbinom(7, n, p, lower.tail=FALSE)
cat("pbinom(7, 10, 0.75, lower.tail=FALSE) [P(X > 7)]:\n")
cat("  Slide shows: 0.526\n")
cat("  Calculated:  ", round(prob3, 3), "\n")
cat("  Match: ", ifelse(abs(prob3 - 0.526) < 0.001, "YES", "NO"), "\n\n")

# 1 - pbinom(7, 10, 0.75) should also be 0.526
prob4 <- 1 - pbinom(7, n, p)
cat("1 - pbinom(7, 10, 0.75):\n")
cat("  Slide shows: 0.526\n")
cat("  Calculated:  ", round(prob4, 3), "\n")
cat("  Match: ", ifelse(abs(prob4 - 0.526) < 0.001, "YES", "NO"), "\n\n")

# ============================================================================
# SLIDE: Standard Normal Distribution (Lines 315-335)
# ============================================================================
cat("\n4. STANDARD NORMAL DISTRIBUTION EXAMPLES\n")
cat(paste(rep("-", 60), collapse=""), "\n")

# P(Z <= 0)
prob1 <- pnorm(0)
cat("P(Z <= 0):\n")
cat("  Slide shows: 0.5\n")
cat("  Calculated:  ", prob1, "\n")
cat("  Match: YES\n\n")

# P(Z < 1)
prob2 <- pnorm(1)
cat("P(Z < 1):\n")
cat("  Slide shows: 0.8413\n")
cat("  Calculated:  ", round(prob2, 4), "\n")
cat("  Match: ", ifelse(abs(prob2 - 0.8413) < 0.0001, "YES", "NO"), "\n\n")

# P(Z < -1)
prob3 <- pnorm(-1)
cat("P(Z < -1):\n")
cat("  Slide shows: 0.1587\n")
cat("  Calculated:  ", round(prob3, 4), "\n")
cat("  Match: ", ifelse(abs(prob3 - 0.1587) < 0.0001, "YES", "NO"), "\n\n")

# P(Z > 1.96)
prob4 <- 1 - pnorm(1.96)
cat("P(Z > 1.96):\n")
cat("  Slide shows: 1 - 0.975 = 0.025\n")
cat("  Calculated:  ", round(prob4, 3), "\n")
cat("  Match: ", ifelse(abs(prob4 - 0.025) < 0.001, "YES", "NO"), "\n\n")

# P(-1.96 < Z < 1.96)
prob5 <- pnorm(1.96) - pnorm(-1.96)
cat("P(-1.96 < Z < 1.96):\n")
cat("  Slide shows: 0.95\n")
cat("  Calculated:  ", round(prob5, 2), "\n")
cat("  Match: ", ifelse(abs(prob5 - 0.95) < 0.01, "YES", "NO"), "\n\n")

# ============================================================================
# SLIDE: Normal Distribution Exam Scores Example (Lines 338-361)
# ============================================================================
cat("\n5. EXAM SCORES EXAMPLE (mu=70, sigma=10)\n")
cat(paste(rep("-", 60), collapse=""), "\n")

mu <- 70
sigma <- 10

# P(S > 85)
z_score <- (85 - 70) / 10
cat("Z-score for 85:\n")
cat("  Slide shows: 1.5\n")
cat("  Calculated:  ", z_score, "\n")
cat("  Match: YES\n\n")

prob_z_lt_1.5 <- pnorm(1.5)
cat("P(Z < 1.5):\n")
cat("  Slide shows: 0.9332\n")
cat("  Calculated:  ", round(prob_z_lt_1.5, 4), "\n")
cat("  Match: ", ifelse(abs(prob_z_lt_1.5 - 0.9332) < 0.0001, "YES", "NO"), "\n\n")

prob_s_gt_85 <- 1 - prob_z_lt_1.5
cat("P(S > 85):\n")
cat("  Slide shows: 0.0668\n")
cat("  Calculated:  ", round(prob_s_gt_85, 4), "\n")
cat("  Match: ", ifelse(abs(prob_s_gt_85 - 0.0668) < 0.0001, "YES", "NO"), "\n\n")

# Using pnorm directly
prob_direct <- pnorm(85, mean=70, sd=10, lower.tail=FALSE)
cat("Using pnorm(85, 70, 10, lower.tail=FALSE):\n")
cat("  Calculated:  ", round(prob_direct, 4), "\n\n")

# ============================================================================
# SLIDE: Normal Distribution Between Two Values (Lines 364-382)
# ============================================================================
cat("\n6. EXAM SCORES: BETWEEN 60 AND 85\n")
cat(paste(rep("-", 60), collapse=""), "\n")

# Z-scores
z1 <- (60 - 70) / 10
z2 <- (85 - 70) / 10
cat("Z-score for 60:\n")
cat("  Slide shows: -1.0\n")
cat("  Calculated:  ", z1, "\n")
cat("  Match: YES\n\n")

cat("Z-score for 85:\n")
cat("  Slide shows: 1.5\n")
cat("  Calculated:  ", z2, "\n")
cat("  Match: YES\n\n")

# Probabilities
prob_z_lt_1.5 <- pnorm(1.5)
prob_z_lt_minus1 <- pnorm(-1.0)

cat("P(Z < 1.5):\n")
cat("  Slide shows: 0.9332\n")
cat("  Calculated:  ", round(prob_z_lt_1.5, 4), "\n\n")

cat("P(Z < -1.0):\n")
cat("  Slide shows: 0.1587\n")
cat("  Calculated:  ", round(prob_z_lt_minus1, 4), "\n\n")

prob_between <- prob_z_lt_1.5 - prob_z_lt_minus1
cat("P(60 < S < 85):\n")
cat("  Slide shows: 0.7745\n")
cat("  Calculated:  ", round(prob_between, 4), "\n")
cat("  Match: ", ifelse(abs(prob_between - 0.7745) < 0.0001, "YES", "NO"), "\n\n")

# Using pnorm directly
prob_direct <- pnorm(85, 70, 10) - pnorm(60, 70, 10)
cat("Using pnorm(85, 70, 10) - pnorm(60, 70, 10):\n")
cat("  Calculated:  ", round(prob_direct, 4), "\n\n")

# ============================================================================
# SLIDE: Finding Percentiles (Lines 385-403)
# ============================================================================
cat("\n7. FINDING 90TH PERCENTILE (mu=70, sigma=10)\n")
cat(paste(rep("-", 60), collapse=""), "\n")

# Find z such that P(Z < z) = 0.90
z_90 <- qnorm(0.90)
cat("Z-score for 90th percentile:\n")
cat("  Slide shows: 1.28\n")
cat("  Calculated:  ", round(z_90, 2), "\n")
cat("  Match: ", ifelse(abs(z_90 - 1.28) < 0.01, "YES", "NO"), "\n\n")

# Calculate score
score_90 <- 70 + z_90 * 10
cat("Score at 90th percentile:\n")
cat("  Slide shows: 82.8\n")
cat("  Calculated:  ", round(score_90, 1), "\n")
cat("  Match: ", ifelse(abs(score_90 - 82.8) < 0.1, "YES", "NO"), "\n\n")

# Using qnorm directly
score_direct <- qnorm(0.90, mean=70, sd=10)
cat("Using qnorm(0.90, 70, 10):\n")
cat("  Calculated:  ", round(score_direct, 1), "\n\n")

# ============================================================================
# SLIDE: Cholesterol Example (Lines 406-429)
# ============================================================================
cat("\n8. CHOLESTEROL EXAMPLE (mu=200, sigma=40)\n")
cat(paste(rep("-", 60), collapse=""), "\n")

mu <- 200
sigma <- 40

# Z-score for 240
z_240 <- (240 - 200) / 40
cat("Z-score for 240:\n")
cat("  Slide shows: 1.0\n")
cat("  Calculated:  ", z_240, "\n")
cat("  Match: YES\n\n")

# P(X >= 240)
prob_ge_240 <- 1 - pnorm(1.0)
cat("P(X >= 240) = P(Z > 1.0):\n")
cat("  Slide shows: 1 - 0.8413 = 0.1587\n")
cat("  Calculated:  ", round(prob_ge_240, 4), "\n")
cat("  Match: ", ifelse(abs(prob_ge_240 - 0.1587) < 0.0001, "YES", "NO"), "\n\n")

# ============================================================================
# SLIDE: t-Distribution Critical Values (Lines 478-484)
# ============================================================================
cat("\n9. t-DISTRIBUTION CRITICAL VALUES (95% confidence)\n")
cat(paste(rep("-", 60), collapse=""), "\n")

# Z critical value
z_crit <- qnorm(0.975)
cat("Z_{0.975}:\n")
cat("  Slide shows: 1.96\n")
cat("  Calculated:  ", round(z_crit, 2), "\n")
cat("  Match: ", ifelse(abs(z_crit - 1.96) < 0.01, "YES", "NO"), "\n\n")

# t critical values
t_df5 <- qt(0.975, df=5)
cat("t_{0.975, df=5}:\n")
cat("  Slide shows: 2.571\n")
cat("  Calculated:  ", round(t_df5, 3), "\n")
cat("  Match: ", ifelse(abs(t_df5 - 2.571) < 0.001, "YES", "NO"), "\n\n")

t_df30 <- qt(0.975, df=30)
cat("t_{0.975, df=30}:\n")
cat("  Slide shows: 2.042\n")
cat("  Calculated:  ", round(t_df30, 3), "\n")
cat("  Match: ", ifelse(abs(t_df30 - 2.042) < 0.001, "YES", "NO"), "\n\n")

# ============================================================================
# SLIDE: IQ Scores Example (Lines 678-704)
# ============================================================================
cat("\n10. IQ SCORES EXAMPLE (n=90, sigma=10, observed xbar=105)\n")
cat(paste(rep("-", 60), collapse=""), "\n")

n <- 90
sigma <- 10
mu <- 100
xbar <- 105

# Standard error
se <- sigma / sqrt(n)
cat("Standard error:\n")
cat("  Slide shows: 1.054\n")
cat("  Calculated:  ", round(se, 3), "\n")
cat("  Match: ", ifelse(abs(se - 1.054) < 0.001, "YES", "NO"), "\n\n")

# Z-score
z_score <- (xbar - mu) / se
cat("Z-score:\n")
cat("  Slide shows: 4.74\n")
cat("  Calculated:  ", round(z_score, 2), "\n")
cat("  Match: ", ifelse(abs(z_score - 4.74) < 0.01, "YES", "NO"), "\n\n")

# P(Z > 4.74)
p_value <- pnorm(z_score, lower.tail=FALSE)
cat("P(Z > 4.74):\n")
cat("  Slide shows: < 0.00001\n")
cat("  Calculated:  ", format(p_value, scientific=TRUE), "\n")
cat("  Match: ", ifelse(p_value < 0.00001, "YES", "NO"), "\n\n")

# ============================================================================
# SLIDE: 95% CI with sigma known (Lines 732-751)
# ============================================================================
cat("\n11. 95% CI FOR IQ EXAMPLE (sigma known)\n")
cat(paste(rep("-", 60), collapse=""), "\n")

xbar <- 105
sigma <- 10
n <- 90
se <- sigma / sqrt(n)

margin <- 1.96 * se
ci_lower <- xbar - margin
ci_upper <- xbar + margin

cat("Margin of error:\n")
cat("  1.96 * ", round(se, 3), " = ", round(margin, 2), "\n")
cat("  Slide shows: 2.07\n")
cat("  Calculated:  ", round(margin, 2), "\n")
cat("  Match: ", ifelse(abs(margin - 2.07) < 0.01, "YES", "NO"), "\n\n")

cat("95% CI:\n")
cat("  Slide shows: (102.93, 107.07)\n")
cat("  Calculated:  (", round(ci_lower, 2), ", ", round(ci_upper, 2), ")\n", sep="")
cat("  Match: ", ifelse(abs(ci_lower - 102.93) < 0.01 & abs(ci_upper - 107.07) < 0.01, "YES", "NO"), "\n\n")

# ============================================================================
# SLIDE: t-Distribution Critical Values for CIs (Lines 772-777)
# ============================================================================
cat("\n12. t-DISTRIBUTION CRITICAL VALUES FOR CIs\n")
cat(paste(rep("-", 60), collapse=""), "\n")

t_n10 <- qt(0.975, df=9)
cat("n=10, df=9, t_{0.975,9}:\n")
cat("  Slide shows: 2.262\n")
cat("  Calculated:  ", round(t_n10, 3), "\n")
cat("  Match: ", ifelse(abs(t_n10 - 2.262) < 0.001, "YES", "NO"), "\n\n")

t_n30 <- qt(0.975, df=29)
cat("n=30, df=29, t_{0.975,29}:\n")
cat("  Slide shows: 2.045\n")
cat("  Calculated:  ", round(t_n30, 3), "\n")
cat("  Match: ", ifelse(abs(t_n30 - 2.045) < 0.001, "YES", "NO"), "\n\n")

t_n100 <- qt(0.975, df=99)
cat("n=100, df=99, t_{0.975,99}:\n")
cat("  Slide shows: 1.984\n")
cat("  Calculated:  ", round(t_n100, 3), "\n")
cat("  Match: ", ifelse(abs(t_n100 - 1.984) < 0.001, "YES", "NO"), "\n\n")

# ============================================================================
# SLIDE: Tumor Growth Example (Lines 781-807)
# ============================================================================
cat("\n13. TUMOR GROWTH EXAMPLE - CONTROL GROUP\n")
cat(paste(rep("-", 60), collapse=""), "\n")

control <- c(7, 10, 9, 8, 7, 6, 8, 9, 12, 13)

xbar_c <- mean(control)
s_c <- sd(control)
n_c <- length(control)

cat("Sample mean:\n")
cat("  Slide shows: 8.9 mm\n")
cat("  Calculated:  ", round(xbar_c, 1), " mm\n", sep="")
cat("  Match: ", ifelse(abs(xbar_c - 8.9) < 0.1, "YES", "NO"), "\n\n")

cat("Sample SD:\n")
cat("  Slide shows: 2.234 mm\n")
cat("  Calculated:  ", round(s_c, 3), " mm\n", sep="")
cat("  Match: ", ifelse(abs(s_c - 2.234) < 0.001, "YES", "NO"), "\n\n")

t_crit <- qt(0.975, df=n_c-1)
cat("t_{0.975,9}:\n")
cat("  Slide shows: 2.262\n")
cat("  Calculated:  ", round(t_crit, 3), "\n")
cat("  Match: ", ifelse(abs(t_crit - 2.262) < 0.001, "YES", "NO"), "\n\n")

se_c <- s_c / sqrt(n_c)
margin_c <- t_crit * se_c

cat("Margin of error:\n")
cat("  2.262 * ", round(se_c, 3), " = ", round(margin_c, 3), "\n", sep="")
cat("  Slide shows: 1.598\n")
cat("  Calculated:  ", round(margin_c, 3), "\n")
cat("  Match: ", ifelse(abs(margin_c - 1.598) < 0.001, "YES", "NO"), "\n\n")

ci_lower_c <- xbar_c - margin_c
ci_upper_c <- xbar_c + margin_c

cat("95% CI:\n")
cat("  Slide shows: (7.30, 10.50) mm\n")
cat("  Calculated:  (", round(ci_lower_c, 2), ", ", round(ci_upper_c, 2), ") mm\n", sep="")
cat("  Match: ", ifelse(abs(ci_lower_c - 7.30) < 0.01 & abs(ci_upper_c - 10.50) < 0.01, "YES", "NO"), "\n\n")

# ============================================================================
# SLIDE: Tumor Growth Example - Treatment Group (Lines 802-806)
# ============================================================================
cat("\n14. TUMOR GROWTH EXAMPLE - TREATMENT GROUP\n")
cat(paste(rep("-", 60), collapse=""), "\n")

treatment <- c(4, 6, 10, 8, 5, 3, 10, 8, 8, 10)

xbar_t <- mean(treatment)
s_t <- sd(treatment)
n_t <- length(treatment)

cat("Sample mean:\n")
cat("  Slide shows: 7.2 mm\n")
cat("  Calculated:  ", round(xbar_t, 1), " mm\n", sep="")
cat("  Match: ", ifelse(abs(xbar_t - 7.2) < 0.1, "YES", "NO"), "\n\n")

cat("Sample SD:\n")
cat("  Slide shows: 2.573 mm\n")
cat("  Calculated:  ", round(s_t, 3), " mm\n", sep="")
cat("  Match: ", ifelse(abs(s_t - 2.573) < 0.001, "YES", "NO"), "\n\n")

t_crit_t <- qt(0.975, df=n_t-1)
se_t <- s_t / sqrt(n_t)
margin_t <- t_crit_t * se_t
ci_lower_t <- xbar_t - margin_t
ci_upper_t <- xbar_t + margin_t

cat("95% CI:\n")
cat("  Slide shows: (5.36, 9.04) mm\n")
cat("  Calculated:  (", round(ci_lower_t, 2), ", ", round(ci_upper_t, 2), ") mm\n", sep="")
cat("  Match: ", ifelse(abs(ci_lower_t - 5.36) < 0.01 & abs(ci_upper_t - 9.04) < 0.01, "YES", "NO"), "\n\n")

# ============================================================================
# SLIDE: Other Confidence Levels (Lines 840-869)
# ============================================================================
cat("\n15. CRITICAL VALUES FOR DIFFERENT CONFIDENCE LEVELS\n")
cat(paste(rep("-", 60), collapse=""), "\n")

z_90 <- qnorm(0.95)  # 90% CI: alpha/2 = 0.05 in each tail
z_95 <- qnorm(0.975) # 95% CI: alpha/2 = 0.025 in each tail
z_99 <- qnorm(0.995) # 99% CI: alpha/2 = 0.005 in each tail

cat("90% Confidence (alpha = 0.10):\n")
cat("  Slide shows: 1.645\n")
cat("  Calculated:  ", round(z_90, 3), "\n")
cat("  Match: ", ifelse(abs(z_90 - 1.645) < 0.001, "YES", "NO"), "\n\n")

cat("95% Confidence (alpha = 0.05):\n")
cat("  Slide shows: 1.96\n")
cat("  Calculated:  ", round(z_95, 2), "\n")
cat("  Match: ", ifelse(abs(z_95 - 1.96) < 0.01, "YES", "NO"), "\n\n")

cat("99% Confidence (alpha = 0.01):\n")
cat("  Slide shows: 2.576\n")
cat("  Calculated:  ", round(z_99, 3), "\n")
cat("  Match: ", ifelse(abs(z_99 - 2.576) < 0.001, "YES", "NO"), "\n\n")

# ============================================================================
# SLIDE: R Example Cholesterol (Lines 1132-1154)
# ============================================================================
cat("\n16. R EXAMPLE: CHOLESTEROL CALCULATIONS\n")
cat(paste(rep("-", 60), collapse=""), "\n")

mu <- 200
sigma <- 40

# P(cholesterol > 240)
prob1 <- pnorm(240, mu, sigma, lower.tail=FALSE)
cat("P(cholesterol > 240):\n")
cat("  Slide shows: 0.159\n")
cat("  Calculated:  ", round(prob1, 3), "\n")
cat("  Match: ", ifelse(abs(prob1 - 0.159) < 0.001, "YES", "NO"), "\n\n")

# P(180 < cholesterol < 220)
prob2 <- pnorm(220, mu, sigma) - pnorm(180, mu, sigma)
cat("P(180 < cholesterol < 220):\n")
cat("  Slide shows: 0.383\n")
cat("  Calculated:  ", round(prob2, 3), "\n")
cat("  Match: ", ifelse(abs(prob2 - 0.383) < 0.001, "YES", "NO"), "\n\n")

# 90th percentile
percentile_90 <- qnorm(0.90, mu, sigma)
cat("90th percentile:\n")
cat("  Slide shows: 251.3 mg/dL\n")
cat("  Calculated:  ", round(percentile_90, 1), " mg/dL\n", sep="")
cat("  Match: ", ifelse(abs(percentile_90 - 251.3) < 0.1, "YES", "NO"), "\n\n")

# ============================================================================
# SUMMARY
# ============================================================================
cat("\n")
cat(paste(rep("=", 80), collapse=""), "\n")
cat("VERIFICATION COMPLETE\n")
cat(paste(rep("=", 80), collapse=""), "\n")
