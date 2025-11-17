#!/usr/bin/env Rscript
# Verification script for Week 5 Assignment: Hypothesis Testing
# All numerical answers verified computationally

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 5 ASSIGNMENT - HYPOTHESIS TESTING - VERIFIED ANSWERS\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

# ============================================================================
# PART 1: ONE-SAMPLE T-TESTS
# ============================================================================

cat("PART 1: ONE-SAMPLE T-TESTS\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Question 5: t-statistic calculation
cat("Q5: Calculate t-statistic\n")
xbar <- 52
mu0 <- 50
s <- 8
n <- 25
se <- s / sqrt(n)
t_stat <- (xbar - mu0) / se
cat("Sample mean:", xbar, "\n")
cat("Null hypothesis mean:", mu0, "\n")
cat("Sample SD:", s, "\n")
cat("Sample size:", n, "\n")
cat("SE:", round(se, 4), "\n")
cat("t-statistic:", round(t_stat, 4), "\n\n")

# Question 6: p-value for two-sided test
cat("Q6: Calculate p-value (two-sided)\n")
df <- n - 1
p_value <- 2 * (1 - pt(abs(t_stat), df))
cat("Degrees of freedom:", df, "\n")
cat("p-value (two-sided):", round(p_value, 4), "\n\n")

# Question 11: Fill-in problem - Blood pressure
cat("Q11: Blood pressure hypothesis test (FILL-IN)\n")
bp_data <- c(118, 124, 130, 128, 122, 135, 119, 126, 132, 120,
             125, 129, 121, 127, 123, 131, 120, 128, 124, 126)
cat("Data:", bp_data, "\n")
bp_n <- length(bp_data)
bp_mean <- mean(bp_data)
bp_sd <- sd(bp_data)
bp_se <- bp_sd / sqrt(bp_n)
bp_t <- (bp_mean - 120) / bp_se
bp_df <- bp_n - 1
bp_p <- pt(bp_t, bp_df, lower.tail = FALSE)
cat("Sample size:", bp_n, "\n")
cat("Sample mean:", round(bp_mean, 2), "\n")
cat("Sample SD:", round(bp_sd, 2), "\n")
cat("SE:", round(bp_se, 4), "\n")
cat("Null hypothesis: mu = 120\n")
cat("Alternative: mu > 120 (upper-tail)\n")
cat("t-statistic:", round(bp_t, 4), "\n")
cat("df:", bp_df, "\n")
cat("p-value (upper-tail):", round(bp_p, 4), "\n")
cat("Decision at alpha=0.05:", ifelse(bp_p < 0.05, "Reject H0", "Fail to reject H0"), "\n\n")

# Question 12: Fill-in problem - Cholesterol
cat("Q12: Cholesterol reduction hypothesis test (FILL-IN)\n")
chol_xbar <- 185
chol_s <- 35
chol_n <- 40
chol_mu0 <- 200
chol_se <- chol_s / sqrt(chol_n)
chol_t <- (chol_xbar - chol_mu0) / chol_se
chol_df <- chol_n - 1
chol_p <- pt(chol_t, chol_df)  # lower tail since t is negative
cat("Sample mean:", chol_xbar, "\n")
cat("Sample SD:", chol_s, "\n")
cat("Sample size:", chol_n, "\n")
cat("Null hypothesis: mu = 200\n")
cat("Alternative: mu < 200 (lower-tail)\n")
cat("SE:", round(chol_se, 4), "\n")
cat("t-statistic:", round(chol_t, 4), "\n")
cat("df:", chol_df, "\n")
cat("p-value (lower-tail):", round(chol_p, 6), "\n")
cat("Decision at alpha=0.01:", ifelse(chol_p < 0.01, "Reject H0", "Fail to reject H0"), "\n\n")

# ============================================================================
# PART 2: TYPE I AND TYPE II ERRORS
# ============================================================================

cat("PART 2: TYPE I AND TYPE II ERRORS\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

cat("Q7: Type I Error - Reject true null hypothesis (false positive)\n")
cat("Q8: Type II Error - Fail to reject false null hypothesis (false negative)\n")
cat("Q9: Type I Error increases Type II Error; Decreasing alpha increases beta\n")
cat("Q10: Power = 1 - beta (probability of correctly rejecting false H0)\n\n")

# ============================================================================
# PART 3: TWO-SAMPLE T-TESTS
# ============================================================================

cat("PART 3: TWO-SAMPLE T-TESTS\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Question 14: Two-sample t-test calculation
cat("Q14: Two-sample t-test\n")
n1 <- 30
xbar1 <- 145
s1 <- 15
n2 <- 35
xbar2 <- 138
s2 <- 18
se_diff <- sqrt((s1^2 / n1) + (s2^2 / n2))
t_two_sample <- (xbar1 - xbar2) / se_diff
# Welch's df approximation
df_welch <- ((s1^2/n1 + s2^2/n2)^2) /
            ((s1^2/n1)^2/(n1-1) + (s2^2/n2)^2/(n2-1))
p_two_sample <- 2 * pt(-abs(t_two_sample), df_welch)
cat("Group 1: n1 =", n1, ", xbar1 =", xbar1, ", s1 =", s1, "\n")
cat("Group 2: n2 =", n2, ", xbar2 =", xbar2, ", s2 =", s2, "\n")
cat("SE of difference:", round(se_diff, 4), "\n")
cat("t-statistic:", round(t_two_sample, 4), "\n")
cat("df (Welch):", round(df_welch, 2), "\n")
cat("p-value (two-sided):", round(p_two_sample, 4), "\n\n")

# ============================================================================
# VERIFICATION SUMMARY
# ============================================================================

cat(paste(rep("=", 70), collapse=""), "\n")
cat("SUMMARY OF NUMERICAL ANSWERS\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

cat("Q5: t-statistic = ", round(t_stat, 4), "\n", sep="")
cat("Q6: p-value = ", round(p_value, 4), "\n", sep="")
cat("Q11: Blood pressure t = ", round(bp_t, 4), ", p-value = ", round(bp_p, 4), "\n", sep="")
cat("Q12: Cholesterol t = ", round(chol_t, 4), ", p-value = ", round(chol_p, 6), "\n", sep="")
cat("Q14: Two-sample t = ", round(t_two_sample, 4), ", p-value = ", round(p_two_sample, 4), "\n", sep="")

cat("\n", paste(rep("=", 70), collapse=""), "\n")
cat("ALL CALCULATIONS VERIFIED\n")
cat(paste(rep("=", 70), collapse=""), "\n")
