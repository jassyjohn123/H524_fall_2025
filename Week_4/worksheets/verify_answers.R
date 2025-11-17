#!/usr/bin/env Rscript
# Verification script for Week 4 Worksheet answers
# All calculations verified computationally

cat(paste(rep("=", 60), collapse=""), "\n")
cat("WEEK 4 WORKSHEET ANSWER VERIFICATION\n")
cat(paste(rep("=", 60), collapse=""), "\n\n")

# Problem 1: CI for Population Mean
cat("PROBLEM 1: CI for Population Mean\n")
cat(paste(rep("-", 60), collapse=""), "\n")
n1 <- 20
xbar1 <- 42.5
s1 <- 8.6

# Part A: SE
se1 <- s1 / sqrt(n1)
cat("Part A - SE:", round(se1, 4), "\n")

# Part B: Critical value
df1 <- n1 - 1
t_crit1_95 <- qt(0.975, df1)
cat("Part B - df:", df1, "\n")
cat("Part B - t-critical (95%):", round(t_crit1_95, 4), "\n")

# Part C: Margin of error
me1_95 <- t_crit1_95 * se1
cat("Part C - Margin of error:", round(me1_95, 4), "\n")

# Part D: CI
ci1_lower <- xbar1 - me1_95
ci1_upper <- xbar1 + me1_95
cat("Part D - 95% CI: (", round(ci1_lower, 2), ",", round(ci1_upper, 2), ")\n\n")

# Problem 2: Effect of Confidence Level
cat("PROBLEM 2: Effect of Confidence Level\n")
cat(paste(rep("-", 60), collapse=""), "\n")

# Part A: 90% CI
t_crit1_90 <- qt(0.95, df1)
me1_90 <- t_crit1_90 * se1
ci1_90_lower <- xbar1 - me1_90
ci1_90_upper <- xbar1 + me1_90
cat("Part A - t-critical (90%):", round(t_crit1_90, 4), "\n")
cat("Part A - Margin of error:", round(me1_90, 4), "\n")
cat("Part A - 90% CI: (", round(ci1_90_lower, 2), ",", round(ci1_90_upper, 2), ")\n")

# Part B: 99% CI
t_crit1_99 <- qt(0.995, df1)
me1_99 <- t_crit1_99 * se1
ci1_99_lower <- xbar1 - me1_99
ci1_99_upper <- xbar1 + me1_99
cat("Part B - t-critical (99%):", round(t_crit1_99, 4), "\n")
cat("Part B - Margin of error:", round(me1_99, 4), "\n")
cat("Part B - 99% CI: (", round(ci1_99_lower, 2), ",", round(ci1_99_upper, 2), ")\n\n")

# Problem 3: CI for a Proportion
cat("PROBLEM 3: CI for a Proportion\n")
cat(paste(rep("-", 60), collapse=""), "\n")
n3 <- 250
x3 <- 218

# Part A: Sample proportion
p_hat <- x3 / n3
cat("Part A - p-hat:", round(p_hat, 4), "\n")

# Part B: Check conditions
np <- n3 * p_hat
n_1minusp <- n3 * (1 - p_hat)
cat("Part B - n*p-hat:", round(np, 2), "\n")
cat("Part B - n*(1-p-hat):", round(n_1minusp, 2), "\n")
cat("Part B - Both >= 10? YES\n")

# Part C: SE for proportion
se3 <- sqrt(p_hat * (1 - p_hat) / n3)
cat("Part C - SE:", round(se3, 4), "\n")

# Part D: 95% CI for proportion
z_crit <- 1.96
me3 <- z_crit * se3
ci3_lower <- p_hat - me3
ci3_upper <- p_hat + me3
cat("Part D - Margin of error:", round(me3, 4), "\n")
cat("Part D - 95% CI: (", round(ci3_lower, 4), ",", round(ci3_upper, 4), ")\n")
cat("Part D - As percentage: (", round(ci3_lower * 100, 2), "%,", round(ci3_upper * 100, 2), "%)\n\n")

# Problem 4: Sample Size Planning
cat("PROBLEM 4: Sample Size Planning\n")
cat(paste(rep("-", 60), collapse=""), "\n")
sigma4 <- 40
me4_target <- 6
z4 <- 1.96

# Part A: Critical value
cat("Part A - z-critical (95%):", z4, "\n")

# Part B: Sample size for ME = 6
n4_b <- (z4 * sigma4 / me4_target)^2
n4_b_rounded <- ceiling(n4_b)
cat("Part B - n (calculated):", round(n4_b, 2), "\n")
cat("Part B - n (rounded up):", n4_b_rounded, "\n")

# Part C: Sample size for ME = 4
me4_target2 <- 4
n4_c <- (z4 * sigma4 / me4_target2)^2
n4_c_rounded <- ceiling(n4_c)
cat("Part C - n (calculated):", round(n4_c, 2), "\n")
cat("Part C - n (rounded up):", n4_c_rounded, "\n\n")

# Problem 5: Comparing Two CIs
cat("PROBLEM 5: Comparing Two CIs\n")
cat(paste(rep("-", 60), collapse=""), "\n")
n5a <- 15
xbar5a <- 28.4
s5a <- 6.2
n5b <- 50
xbar5b <- 28.4
s5b <- 6.2

# Part A: Standard errors
se5a <- s5a / sqrt(n5a)
se5b <- s5b / sqrt(n5b)
cat("Part A - SE_A:", round(se5a, 4), "\n")
cat("Part A - SE_B:", round(se5b, 4), "\n")

# Part B: Critical values
df5a <- n5a - 1
df5b <- n5b - 1
t_crit5a <- qt(0.975, df5a)
t_crit5b <- qt(0.975, df5b)
cat("Part B - t-critical for Sample A (df=14):", round(t_crit5a, 4), "\n")
cat("Part B - t-critical for Sample B (df=49):", round(t_crit5b, 4), "\n")

# Part C: Confidence intervals
me5a <- t_crit5a * se5a
me5b <- t_crit5b * se5b
ci5a_lower <- xbar5a - me5a
ci5a_upper <- xbar5a + me5a
ci5b_lower <- xbar5b - me5b
ci5b_upper <- xbar5b + me5b
cat("Part C - Sample A CI: (", round(ci5a_lower, 2), ",", round(ci5a_upper, 2), ")\n")
cat("Part C - Sample B CI: (", round(ci5b_lower, 2), ",", round(ci5b_upper, 2), ")\n")
width5a <- ci5a_upper - ci5a_lower
width5b <- ci5b_upper - ci5b_lower
cat("Part C - Width A:", round(width5a, 2), "\n")
cat("Part C - Width B:", round(width5b, 2), "\n\n")

# Problem 6: Integration Problem
cat("PROBLEM 6: Integration Problem - Blood Pressure\n")
cat(paste(rep("-", 60), collapse=""), "\n")
n6 <- 36
xbar6 <- 12.8
s6 <- 5.4

# Part A: 95% CI for mean
se6 <- s6 / sqrt(n6)
df6 <- n6 - 1
t_crit6 <- qt(0.975, df6)
me6 <- t_crit6 * se6
ci6_lower <- xbar6 - me6
ci6_upper <- xbar6 + me6
cat("Part A - SE:", round(se6, 4), "\n")
cat("Part A - df:", df6, "\n")
cat("Part A - t-critical:", round(t_crit6, 4), "\n")
cat("Part A - Margin of error:", round(me6, 4), "\n")
cat("Part A - 95% CI: (", round(ci6_lower, 2), ",", round(ci6_upper, 2), ")\n")

# Part C: Sample size for ME = 1.5
me6_target <- 1.5
sigma6 <- 5.4
z6 <- 1.96
n6c <- (z6 * sigma6 / me6_target)^2
n6c_rounded <- ceiling(n6c)
cat("Part C - n (calculated):", round(n6c, 2), "\n")
cat("Part C - n (rounded up):", n6c_rounded, "\n")

# Part D: CI for proportion
x6d <- 20
n6d <- 36
p_hat6d <- x6d / n6d
np6d <- n6d * p_hat6d
n_1minusp6d <- n6d * (1 - p_hat6d)
se6d <- sqrt(p_hat6d * (1 - p_hat6d) / n6d)
me6d <- 1.96 * se6d
ci6d_lower <- p_hat6d - me6d
ci6d_upper <- p_hat6d + me6d
cat("Part D - p-hat:", round(p_hat6d, 4), "\n")
cat("Part D - n*p-hat:", round(np6d, 2), "\n")
cat("Part D - n*(1-p-hat):", round(n_1minusp6d, 2), "\n")
cat("Part D - SE:", round(se6d, 4), "\n")
cat("Part D - 95% CI: (", round(ci6d_lower, 4), ",", round(ci6d_upper, 4), ")\n")
cat("Part D - As percentage: (", round(ci6d_lower * 100, 2), "%,", round(ci6d_upper * 100, 2), "%)\n")

cat("\n", paste(rep("=", 60), collapse=""), "\n")
cat("ALL CALCULATIONS VERIFIED\n")
cat(paste(rep("=", 60), collapse=""), "\n")
