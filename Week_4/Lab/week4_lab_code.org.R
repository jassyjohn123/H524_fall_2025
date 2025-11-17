#!/usr/bin/env Rscript
# Week 4 Lab - R Code Solutions
# Topic: Confidence Intervals - Practice Problems
#
# This file contains complete R code solutions for all Week 4 lab problems.
# Students can use this as a reference or to check their work.

rm(list=ls())
bp_data <- c(128, 132, 125, 138, 130, 135, 127, 140, 129, 133,
             136, 126, 131, 134, 137, 142, 124, 139, 128, 135,
             130, 141, 127, 133, 136)
n <- length(bp_data)
df <- n-1
conf_level <- 0.95
alpha <- 1 - conf_level


cat("======================================================================\n")
cat("WEEK 4 LAB: CONFIDENCE INTERVALS - R CODE SOLUTIONS\n")
cat("======================================================================\n\n")

# ==============================================================================
# PROBLEM 1: Clinical Trial (Cholesterol Reduction)
# ==============================================================================
cat("PROBLEM 1: Clinical Trial (Cholesterol Reduction)\n")
cat("======================================================================\n\n")

cat("Scenario:\n")
cat("  A new cholesterol-lowering medication is tested on 30 patients.\n")
cat("  After 6 weeks, the mean reduction in LDL cholesterol is 28 mg/dL\n")
cat("  with a standard deviation of 12 mg/dL.\n\n")

# Given data
n <- 30
xbar <- 28
s <- 12

cat("Given:\n")
cat("  n =", n, "patients\n")
cat("  x̄ =", xbar, "mg/dL (mean reduction)\n")
cat("  s =", s, "mg/dL (standard deviation)\n\n")

# Part (a): Calculate 95% confidence interval
cat("Part (a): Calculate 95% confidence interval\n")
cat("------------------------------------------\n\n")

# Method 1: Manual calculation
cat("Method 1: Manual Calculation\n")
SE <- s / sqrt(n)
df <- n - 1
t_crit_95 <- qt(0.975, df)
ME_95 <- t_crit_95 * SE
lower_95 <- xbar - ME_95
upper_95 <- xbar + ME_95

cat("  SE = s/√n = ", s, "/√", n, " = ", round(SE, 4), "\n", sep="")
cat("  df = n - 1 =", df, "\n")
cat("  t(0.975,", df, ") =", round(t_crit_95, 4), "\n")
cat("  ME = t × SE =", round(t_crit_95, 4), "×", round(SE, 4), "=", round(ME_95, 4), "\n")
cat("  95% CI = (", round(lower_95, 2), ",", round(upper_95, 2), ") mg/dL\n\n")

cat("R Code (Manual):\n")
cat("n <- 30\n")
cat("xbar <- 28\n")
cat("s <- 12\n")
cat("SE <- s / sqrt(n)\n")
cat("df <- n - 1\n")
cat("t_crit <- qt(0.975, df)\n")
cat("ME <- t_crit * SE\n")
cat("lower <- xbar - ME\n")
cat("upper <- xbar + ME\n")
cat("c(lower, upper)\n\n")

# Method 2: Using t.test()
cat("Method 2: Using t.test() function\n")
cat("# Generate sample data with same mean and SD\n")
cat("set.seed(524)\n")
cat("chol_data <- rnorm(30, mean = 28, sd = 12)\n")
cat("result <- t.test(chol_data, conf.level = 0.95)\n")
cat("result$conf.int\n\n")

set.seed(524)
chol_data <- rnorm(n, mean = xbar, sd = s)
result_95 <- t.test(chol_data, conf.level = 0.95)
cat("95% CI from t.test():", round(result_95$conf.int[1], 2), "to",
    round(result_95$conf.int[2], 2), "mg/dL\n\n")

# Part (b): Calculate 99% confidence interval
cat("Part (b): Calculate 99% confidence interval\n")
cat("------------------------------------------\n\n")

t_crit_99 <- qt(0.995, df)
ME_99 <- t_crit_99 * SE
lower_99 <- xbar - ME_99
upper_99 <- xbar + ME_99

cat("  t(0.995,", df, ") =", round(t_crit_99, 4), "\n")
cat("  ME = ", round(t_crit_99, 4), " × ", round(SE, 4), " = ", round(ME_99, 4), "\n", sep="")
cat("  99% CI = (", round(lower_99, 2), ",", round(upper_99, 2), ") mg/dL\n\n", sep="")

cat("R Code:\n")
cat("t_crit_99 <- qt(0.995, df)\n")
cat("ME_99 <- t_crit_99 * SE\n")
cat("c(xbar - ME_99, xbar + ME_99)\n\n")

# Using t.test
result_99 <- t.test(chol_data, conf.level = 0.99)
cat("99% CI from t.test():", round(result_99$conf.int[1], 2), "to",
    round(result_99$conf.int[2], 2), "mg/dL\n\n")

# Part (c): Interpretation
cat("Part (c): Interpretation\n")
cat("------------------------\n")
cat("95% CI: We are 95% confident that the true mean cholesterol reduction\n")
cat("        is between", round(lower_95, 2), "and", round(upper_95, 2), "mg/dL.\n\n")
cat("99% CI: We are 99% confident that the true mean cholesterol reduction\n")
cat("        is between", round(lower_99, 2), "and", round(upper_99, 2), "mg/dL.\n\n")

# Part (d): Does CI support reduction >= 25 mg/dL?
cat("Part (d): Does CI support reduction >= 25 mg/dL?\n")
cat("-------------------------------------------------\n")
cat("95% CI: (", round(lower_95, 2), ",", round(upper_95, 2), ")\n", sep="")
if (lower_95 >= 25) {
  cat("YES - The entire CI is above 25, strong evidence for reduction >= 25 mg/dL\n\n")
} else if (upper_95 < 25) {
  cat("NO - The entire CI is below 25, evidence against reduction >= 25 mg/dL\n\n")
} else {
  cat("UNCLEAR - The CI includes values both above and below 25 mg/dL.\n")
  cat("Cannot confidently claim reduction >= 25 mg/dL at 95% confidence level.\n\n")
}


# ==============================================================================
# PROBLEM 2: Adverse Events (Proportion)
# ==============================================================================
cat("\n")
cat("======================================================================\n")
cat("PROBLEM 2: Adverse Events (Proportion)\n")
cat("======================================================================\n\n")

cat("Scenario:\n")
cat("  In a clinical trial of 150 patients, 8 experienced adverse events.\n")
cat("  Estimate the proportion of patients who experience adverse events.\n\n")

# Given data
x <- 8
n <- 150

cat("Given:\n")
cat("  x =", x, "adverse events\n")
cat("  n =", n, "patients\n\n")

# Part (a): Check conditions
cat("Part (a): Check conditions for normal approximation\n")
cat("---------------------------------------------------\n\n")

p_hat <- x / n
np <- n * p_hat
n_1minusp <- n * (1 - p_hat)

cat("  p̂ = x/n = ", x, "/", n, " = ", round(p_hat, 4), "\n\n", sep="")
cat("  np̂ = ", n, " × ", round(p_hat, 4), " = ", np, "\n", sep="")
cat("  n(1-p̂) = ", n, " × ", round(1-p_hat, 4), " = ", n_1minusp, "\n\n", sep="")

cat("  Conditions:\n")
cat("    np̂ >= 10?", np >= 10, "(np̂ =", np, ")\n")
cat("    n(1-p̂) >= 10?", n_1minusp >= 10, "(n(1-p̂) =", n_1minusp, ")\n\n")

if (np < 10 || n_1minusp < 10) {
  cat("  WARNING: Conditions not fully satisfied (np̂ < 10).\n")
  cat("  Normal approximation may not be appropriate.\n")
  cat("  Consider using exact methods or larger sample size.\n\n")
}

cat("R Code:\n")
cat("x <- ", x, "\n", sep="")
cat("n <- ", n, "\n", sep="")
cat("p_hat <- x / n\n")
cat("np <- n * p_hat\n")
cat("n_1minusp <- n * (1 - p_hat)\n")
cat("np >= 10  # Check\n")
cat("n_1minusp >= 10  # Check\n\n")

# Part (b): Calculate 95% CI
cat("Part (b): Calculate 95% CI for proportion\n")
cat("------------------------------------------\n\n")

# Manual calculation
SE_p <- sqrt(p_hat * (1 - p_hat) / n)
z_crit <- qnorm(0.975)
ME_p <- z_crit * SE_p
lower_p <- p_hat - ME_p
upper_p <- p_hat + ME_p

cat("  SE = √[p̂(1-p̂)/n]\n")
cat("     = √[", round(p_hat, 4), " × ", round(1-p_hat, 4), " / ", n, "]\n", sep="")
cat("     = √", round(p_hat * (1-p_hat) / n, 6), "\n", sep="")
cat("     = ", round(SE_p, 4), "\n\n", sep="")

cat("  z(0.975) =", round(z_crit, 2), "\n")
cat("  ME = z × SE =", round(z_crit, 2), "×", round(SE_p, 4), "=", round(ME_p, 4), "\n\n")

cat("  95% CI = p̂ ± ME\n")
cat("         = ", round(p_hat, 4), " ± ", round(ME_p, 4), "\n", sep="")
cat("         = (", round(lower_p, 4), ",", round(upper_p, 4), ")\n\n", sep="")

cat("R Code (Manual):\n")
cat("SE <- sqrt(p_hat * (1 - p_hat) / n)\n")
cat("z <- qnorm(0.975)\n")
cat("ME <- z * SE\n")
cat("lower <- p_hat - ME\n")
cat("upper <- p_hat + ME\n")
cat("c(lower, upper)\n\n")

# Using prop.test()
cat("Using prop.test() function:\n")
cat("result <- prop.test(", x, ",", n, ", conf.level = 0.95, correct = FALSE)\n", sep="")
cat("result$conf.int\n\n")

result_prop <- prop.test(x, n, conf.level = 0.95, correct = FALSE)
cat("95% CI from prop.test():", round(result_prop$conf.int[1], 4), "to",
    round(result_prop$conf.int[2], 4), "\n\n")

# Part (c): Express as percentage
cat("Part (c): Express as percentage\n")
cat("-------------------------------\n")
cat("  95% CI = (", round(lower_p * 100, 2), "%,", round(upper_p * 100, 2), "%)\n\n", sep="")
cat("Interpretation:\n")
cat("  We are 95% confident that between", round(lower_p * 100, 2), "% and",
    round(upper_p * 100, 2), "%\n")
cat("  of patients will experience adverse events.\n\n")


# ==============================================================================
# PROBLEM 3: Study Planning (Sample Size)
# ==============================================================================
cat("\n")
cat("======================================================================\n")
cat("PROBLEM 3: Study Planning (Sample Size)\n")
cat("======================================================================\n\n")

cat("Scenario:\n")
cat("  You're designing a study to estimate mean body temperature.\n")
cat("  From previous research, the standard deviation is known to be 0.7°F.\n")
cat("  You want 95% confidence.\n\n")

# Given
sigma <- 0.7
z <- qnorm(0.975)

cat("Given:\n")
cat("  σ = ", sigma, "°F (known from literature)\n", sep="")
cat("  Confidence level: 95% (z =", round(z, 2), ")\n\n")

# Part (a): Sample size for ME = 0.2°F
cat("Part (a): Sample size for ME = 0.2°F\n")
cat("------------------------------------\n\n")

ME_a <- 0.2
n_a <- (z * sigma / ME_a)^2
n_a_rounded <- ceiling(n_a)

cat("  ME = ", ME_a, "°F\n", sep="")
cat("  n = (z × σ / ME)²\n")
cat("    = (", round(z, 2), " × ", sigma, " / ", ME_a, ")²\n", sep="")
cat("    = (", round(z * sigma, 3), " / ", ME_a, ")²\n", sep="")
cat("    = (", round(z * sigma / ME_a, 2), ")²\n", sep="")
cat("    = ", round(n_a, 2), "\n\n", sep="")
cat("  Rounded UP: n = ", n_a_rounded, " subjects\n\n", sep="")

cat("R Code:\n")
cat("sigma <- ", sigma, "\n", sep="")
cat("z <- qnorm(0.975)\n")
cat("ME <- ", ME_a, "\n", sep="")
cat("n <- (z * sigma / ME)^2\n")
cat("ceiling(n)  # Always round up!\n\n")

# Part (b): Sample size for ME = 0.1°F
cat("Part (b): Sample size for ME = 0.1°F\n")
cat("------------------------------------\n\n")

ME_b <- 0.1
n_b <- (z * sigma / ME_b)^2
n_b_rounded <- ceiling(n_b)

cat("  ME = ", ME_b, "°F (half of previous ME)\n", sep="")
cat("  n = (z × σ / ME)²\n")
cat("    = (", round(z, 2), " × ", sigma, " / ", ME_b, ")²\n", sep="")
cat("    = (", round(z * sigma / ME_b, 2), ")²\n", sep="")
cat("    = ", round(n_b, 2), "\n\n", sep="")
cat("  Rounded UP: n = ", n_b_rounded, " subjects\n\n", sep="")

# Part (c): Effect of doubling precision
cat("Part (c): Effect of doubling precision (halving ME)\n")
cat("---------------------------------------------------\n\n")

cat("  ME changed from", ME_a, "to", ME_b, "(factor of", ME_a/ME_b, ")\n")
cat("  Sample size changed from", n_a_rounded, "to", n_b_rounded,
    "(factor of", round(n_b_rounded/n_a_rounded, 2), ")\n\n")

cat("  Relationship: n ∝ 1/ME²\n")
cat("  Halving ME requires 4× the sample size!\n\n")

cat("  Key insight: More precision is EXPENSIVE\n")
cat("    - 2× precision → 4× sample size\n")
cat("    - 3× precision → 9× sample size\n")
cat("    - 10× precision → 100× sample size\n\n")


# ==============================================================================
# PROBLEM 4: Assumption Checking
# ==============================================================================
cat("\n")
cat("======================================================================\n")
cat("PROBLEM 4: Assumption Checking (Normality)\n")
cat("======================================================================\n\n")

cat("Scenario:\n")
cat("  You have reaction time data from 15 subjects.\n")
cat("  Before calculating a confidence interval for the mean,\n")
cat("  you need to check whether the normality assumption is satisfied.\n\n")

# Given data
reaction_times <- c(245, 267, 289, 234, 256, 278, 298, 241,
                    263, 287, 312, 338, 229, 251, 273)

cat("Given data:\n")
cat("  reaction_times <- c(245, 267, 289, 234, 256, 278, 298, 241,\n")
cat("                      263, 287, 312, 338, 229, 251, 273)\n")
cat("  n =", length(reaction_times), "observations\n\n")

# Basic summary statistics
cat("Summary Statistics:\n")
cat("  Mean:", round(mean(reaction_times), 2), "ms\n")
cat("  SD:", round(sd(reaction_times), 2), "ms\n")
cat("  Median:", median(reaction_times), "ms\n")
cat("  Min:", min(reaction_times), "ms\n")
cat("  Max:", max(reaction_times), "ms\n\n")

# Visual assessment
cat("Creating diagnostic plots...\n")
cat("(3-panel plot: Histogram, Boxplot, Q-Q plot)\n\n")

# Set up 3-panel plot
par(mfrow=c(1,3))

# Panel 1: Histogram
hist(reaction_times, breaks=5,
     main="Histogram",
     xlab="Reaction Time (ms)",
     col="lightblue",
     border="white")

# Panel 2: Boxplot
boxplot(reaction_times,
        main="Boxplot",
        ylab="Reaction Time (ms)",
        col="lightgreen")

# Panel 3: Q-Q plot (most important for normality)
qqnorm(reaction_times,
       main="Q-Q Plot",
       pch=19,
       col="blue")
qqline(reaction_times, col="red", lwd=2)

# Reset plotting layout
par(mfrow=c(1,1))

cat("\nR Code for diagnostic plots:\n")
cat("par(mfrow=c(1,3))  # 3 plots side-by-side\n")
cat("hist(reaction_times, breaks=5, main=\"Histogram\", col=\"lightblue\")\n")
cat("boxplot(reaction_times, main=\"Boxplot\", col=\"lightgreen\")\n")
cat("qqnorm(reaction_times, main=\"Q-Q Plot\", pch=19, col=\"blue\")\n")
cat("qqline(reaction_times, col=\"red\", lwd=2)\n")
cat("par(mfrow=c(1,1))  # Reset\n\n")

# Formal normality test: Shapiro-Wilk
cat("Shapiro-Wilk Test for Normality\n")
cat("--------------------------------\n")
cat("H0: Data come from a normal distribution\n")
cat("Ha: Data do not come from a normal distribution\n\n")

shapiro_result <- shapiro.test(reaction_times)

cat("Test statistic W:", round(shapiro_result$statistic, 4), "\n")
cat("P-value:", round(shapiro_result$p.value, 4), "\n\n")

# Decision
alpha <- 0.05
if (shapiro_result$p.value > alpha) {
  cat("Decision: Do not reject H0 (p =", round(shapiro_result$p.value, 4), "> 0.05)\n")
  cat("Conclusion: No evidence against normality.\n")
  cat("The t-interval is APPROPRIATE for these data.\n\n")
} else {
  cat("Decision: Reject H0 (p =", round(shapiro_result$p.value, 4), "< 0.05)\n")
  cat("Conclusion: Evidence of non-normality detected.\n")
  cat("Consider: transformation, non-parametric methods, or larger sample.\n\n")
}

cat("R Code for Shapiro-Wilk test:\n")
cat("shapiro_result <- shapiro.test(reaction_times)\n")
cat("print(shapiro_result)\n\n")

# Overall assessment
cat("Overall Assessment:\n")
cat("-------------------\n")
cat("Visual checks:\n")
cat("  - Histogram: roughly symmetric, no extreme skewness\n")
cat("  - Boxplot: one slightly high value (338) but not extreme outlier\n")
cat("  - Q-Q plot: points fall reasonably close to reference line\n\n")
cat("Formal test:\n")
cat("  - Shapiro-Wilk p-value =", round(shapiro_result$p.value, 4), "\n")
cat("  - No evidence against normality (p > 0.05)\n\n")
cat("FINAL DECISION: t-based confidence interval is appropriate.\n")
cat("The data show no serious departures from normality.\n\n")


# ==============================================================================
# SUMMARY OF KEY R FUNCTIONS
# ==============================================================================
cat("\n")
cat("======================================================================\n")
cat("SUMMARY: KEY R FUNCTIONS FOR CONFIDENCE INTERVALS\n")
cat("======================================================================\n\n")

cat("1. Critical Values:\n")
cat("   ---------------------\n")
cat("   qt(0.975, df)            # t-critical for 95% CI\n")
cat("   qt(0.995, df)            # t-critical for 99% CI\n")
cat("   qnorm(0.975)             # z-critical for 95% CI\n\n")

cat("2. CI for Mean (t-distribution):\n")
cat("   --------------------------------\n")
cat("   # Manual:\n")
cat("   SE <- s / sqrt(n)\n")
cat("   df <- n - 1\n")
cat("   t_crit <- qt(0.975, df)\n")
cat("   ME <- t_crit * SE\n")
cat("   CI <- c(xbar - ME, xbar + ME)\n\n")
cat("   # Using t.test:\n")
cat("   result <- t.test(data, conf.level = 0.95)\n")
cat("   result$conf.int\n\n")

cat("3. CI for Proportion:\n")
cat("   ---------------------\n")
cat("   # Manual:\n")
cat("   p_hat <- x / n\n")
cat("   SE <- sqrt(p_hat * (1 - p_hat) / n)\n")
cat("   z <- qnorm(0.975)\n")
cat("   ME <- z * SE\n")
cat("   CI <- c(p_hat - ME, p_hat + ME)\n\n")
cat("   # Using prop.test:\n")
cat("   result <- prop.test(x, n, conf.level = 0.95, correct = FALSE)\n")
cat("   result$conf.int\n\n")

cat("4. Sample Size:\n")
cat("   ---------------\n")
cat("   # For mean (σ known):\n")
cat("   n <- (z * sigma / ME)^2\n")
cat("   ceiling(n)  # Always round UP\n\n")
cat("   # For proportion:\n")
cat("   n <- (z / ME)^2 * p * (1 - p)\n")
cat("   ceiling(n)  # Always round UP\n\n")

cat("5. Check Conditions:\n")
cat("   -------------------\n")
cat("   # For proportion CI:\n")
cat("   np <- n * p_hat\n")
cat("   np >= 10        # Should be TRUE\n")
cat("   n * (1-p_hat) >= 10  # Should be TRUE\n\n")

cat("======================================================================\n")
cat("END OF LAB CODE\n")
cat("======================================================================\n")
