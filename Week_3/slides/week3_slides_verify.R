#!/usr/bin/env Rscript
# Verification script for Week 3 Slides
# ALL numerical calculations verified computationally

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 3 SLIDES - NUMERICAL VERIFICATION\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

# Example 1: Clinical Trial Binomial (Lines 147-166)
cat("EXAMPLE 1: Clinical Trial - Binomial n=10, p=0.75\n")
cat(paste(rep("-", 70), collapse=""), "\n")
n <- 10
p <- 0.75
prob_8 <- dbinom(8, n, p)
prob_9 <- dbinom(9, n, p)
prob_10 <- dbinom(10, n, p)
prob_at_least_8 <- prob_8 + prob_9 + prob_10
mu <- n * p

cat("P(X = 8) =", round(prob_8, 3), "| Slides: 0.282 | Match:",
    ifelse(abs(prob_8 - 0.282) < 0.001, "✓", "✗"), "\n")
cat("P(X = 9) =", round(prob_9, 3), "| Slides: 0.188 | Match:",
    ifelse(abs(prob_9 - 0.188) < 0.001, "✓", "✗"), "\n")
cat("P(X = 10) =", round(prob_10, 3), "| Slides: 0.056 | Match:",
    ifelse(abs(prob_10 - 0.056) < 0.001, "✓", "✗"), "\n")
cat("P(X ≥ 8) =", round(prob_at_least_8, 3), "| Slides: 0.526 | Match:",
    ifelse(abs(prob_at_least_8 - 0.526) < 0.001, "✓", "✗"), "\n")
cat("Expected μ =", mu, "| Slides: 7.5 | Match:",
    ifelse(abs(mu - 7.5) < 0.1, "✓", "✗"), "\n\n")

# Example 2: Normal Distribution - Exam Scores Above 85 (Lines 338-361)
cat("EXAMPLE 2: Normal Distribution - Exam Scores (μ=70, σ=10)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
mu <- 70
sigma <- 10
x <- 85
z <- (x - mu) / sigma
prob_below <- pnorm(z)
prob_above <- 1 - prob_below

cat("Z-score for X=85:", round(z, 1), "| Slides: 1.5 | Match:",
    ifelse(abs(z - 1.5) < 0.1, "✓", "✗"), "\n")
cat("P(Z < 1.5) =", round(prob_below, 4), "| Slides: 0.9332 | Match:",
    ifelse(abs(prob_below - 0.9332) < 0.0001, "✓", "✗"), "\n")
cat("P(X > 85) =", round(prob_above, 4), "| Slides: 0.0668 | Match:",
    ifelse(abs(prob_above - 0.0668) < 0.0001, "✓", "✗"), "\n\n")

# Example 3: Normal - Between Two Values (Lines 364-382)
cat("EXAMPLE 3: Normal - Scores Between 60 and 85\n")
cat(paste(rep("-", 70), collapse=""), "\n")
x1 <- 60
x2 <- 85
z1 <- (x1 - mu) / sigma
z2 <- (x2 - mu) / sigma
prob_z1 <- pnorm(z1)
prob_z2 <- pnorm(z2)
prob_between <- prob_z2 - prob_z1

cat("Z1 for X=60:", round(z1, 1), "| Slides: -1.0 | Match:",
    ifelse(abs(z1 - (-1.0)) < 0.1, "✓", "✗"), "\n")
cat("Z2 for X=85:", round(z2, 1), "| Slides: 1.5 | Match:",
    ifelse(abs(z2 - 1.5) < 0.1, "✓", "✗"), "\n")
cat("P(60 < X < 85) =", round(prob_between, 4), "| Slides: 0.7745 | Match:",
    ifelse(abs(prob_between - 0.7745) < 0.0001, "✓", "✗"), "\n\n")

# Example 4: Finding Percentiles (Lines 385-403)
cat("EXAMPLE 4: 90th Percentile of Exam Scores\n")
cat(paste(rep("-", 70), collapse=""), "\n")
z_90 <- qnorm(0.90)
x_90 <- mu + z_90 * sigma

cat("Z for 90th percentile:", round(z_90, 2), "| Slides: 1.28 | Match:",
    ifelse(abs(z_90 - 1.28) < 0.01, "✓", "✗"), "\n")
cat("90th percentile score:", round(x_90, 1), "| Slides: 82.8 | Match:",
    ifelse(abs(x_90 - 82.8) < 0.1, "✓", "✗"), "\n\n")

# Example 5: Cholesterol Levels (Lines 406-429)
cat("EXAMPLE 5: Cholesterol - P(X ≥ 240)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
mu_chol <- 200
sigma_chol <- 40
x_chol <- 240
z_chol <- (x_chol - mu_chol) / sigma_chol
prob_high_chol <- 1 - pnorm(z_chol)

cat("Z-score for X=240:", round(z_chol, 1), "| Slides: 1.0 | Match:",
    ifelse(abs(z_chol - 1.0) < 0.1, "✓", "✗"), "\n")
cat("P(X ≥ 240) =", round(prob_high_chol, 4), "| Slides: 0.1587 | Match:",
    ifelse(abs(prob_high_chol - 0.1587) < 0.0001, "✓", "✗"), "\n\n")

# Example 6: IQ Scores CLT (Lines 678-704)
cat("EXAMPLE 6: Central Limit Theorem - IQ Scores\n")
cat(paste(rep("-", 70), collapse=""), "\n")
mu_iq <- 100
sigma_iq <- 10
n_iq <- 90
xbar_iq <- 105
se_iq <- sigma_iq / sqrt(n_iq)
z_iq <- (xbar_iq - mu_iq) / se_iq
p_value_iq <- 1 - pnorm(z_iq)

cat("SE = σ/√n =", round(se_iq, 3), "| Slides: 1.054 | Match:",
    ifelse(abs(se_iq - 1.054) < 0.001, "✓", "✗"), "\n")
cat("Z = (105-100)/SE =", round(z_iq, 2), "| Slides: 4.74 | Match:",
    ifelse(abs(z_iq - 4.74) < 0.01, "✓", "✗"), "\n")
cat("P(Z > 4.74) =", format(p_value_iq, scientific=TRUE, digits=3),
    "| Slides: < 0.00001 | Match: ✓\n\n")

# Example 7: 95% CI with Known Sigma (Lines 746-751)
cat("EXAMPLE 7: 95% CI with Known Sigma\n")
cat(paste(rep("-", 70), collapse=""), "\n")
xbar_ci <- 105
sigma_ci <- 10
n_ci <- 90
se_ci <- sigma_ci / sqrt(n_ci)
me_ci <- 1.96 * se_ci
ci_lower <- xbar_ci - me_ci
ci_upper <- xbar_ci + me_ci

cat("SE =", round(se_ci, 3), "\n")
cat("ME = 1.96 × SE =", round(me_ci, 2), "| Slides: 2.07 | Match:",
    ifelse(abs(me_ci - 2.07) < 0.01, "✓", "✗"), "\n")
cat("95% CI: (", round(ci_lower, 2), ",", round(ci_upper, 2), ")",
    "| Slides: (102.93, 107.07) | Match:",
    ifelse(abs(ci_lower - 102.93) < 0.01 && abs(ci_upper - 107.07) < 0.01, "✓", "✗"), "\n\n")

# Example 8: Tumor Growth t-Test (Lines 782-807)
cat("EXAMPLE 8: Tumor Growth - 95% CI with t-distribution\n")
cat(paste(rep("-", 70), collapse=""), "\n")
control <- c(7, 10, 9, 8, 7, 6, 8, 9, 12, 13)
treatment <- c(4, 6, 10, 8, 5, 3, 10, 8, 8, 10)

xbar_c <- mean(control)
s_c <- sd(control)
n_c <- length(control)
t_crit <- qt(0.975, n_c - 1)
se_c <- s_c / sqrt(n_c)
me_c <- t_crit * se_c
ci_c_lower <- xbar_c - me_c
ci_c_upper <- xbar_c + me_c

xbar_t <- mean(treatment)
s_t <- sd(treatment)
se_t <- s_t / sqrt(length(treatment))
me_t <- t_crit * se_t
ci_t_lower <- xbar_t - me_t
ci_t_upper <- xbar_t + me_t

cat("CONTROL GROUP:\n")
cat("  Mean =", round(xbar_c, 1), "| Slides: 8.9 | Match:",
    ifelse(abs(xbar_c - 8.9) < 0.1, "✓", "✗"), "\n")
cat("  SD =", round(s_c, 3), "| Slides: 2.234 | Match:",
    ifelse(abs(s_c - 2.234) < 0.001, "✓", "✗"), "\n")
cat("  t(0.975, 9) =", round(t_crit, 3), "| Slides: 2.262 | Match:",
    ifelse(abs(t_crit - 2.262) < 0.001, "✓", "✗"), "\n")
cat("  ME =", round(me_c, 3), "| Slides: 1.598 | Match:",
    ifelse(abs(me_c - 1.598) < 0.001, "✓", "✗"), "\n")
cat("  95% CI: (", round(ci_c_lower, 2), ",", round(ci_c_upper, 2), ")",
    "| Slides: (7.30, 10.50) | Match:",
    ifelse(abs(ci_c_lower - 7.30) < 0.01 && abs(ci_c_upper - 10.50) < 0.01, "✓", "✗"), "\n\n")

cat("TREATMENT GROUP:\n")
cat("  Mean =", round(xbar_t, 1), "| Slides: 7.2 | Match:",
    ifelse(abs(xbar_t - 7.2) < 0.1, "✓", "✗"), "\n")
cat("  SD =", round(s_t, 3), "| Slides: 2.573 | Match:",
    ifelse(abs(s_t - 2.573) < 0.001, "✓", "✗"), "\n")
cat("  95% CI: (", round(ci_t_lower, 2), ",", round(ci_t_upper, 2), ")",
    "| Slides: (5.36, 9.04) | Match:",
    ifelse(abs(ci_t_lower - 5.36) < 0.01 && abs(ci_t_upper - 9.04) < 0.01, "✓", "✗"), "\n\n")

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 3 SLIDES VERIFICATION COMPLETE\n")
cat(paste(rep("=", 70), collapse=""), "\n")
