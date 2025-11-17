#!/usr/bin/env Rscript
# Week 4 Slides - R Code Examples
# Topic: Confidence Intervals
#
# This file contains all R code for examples shown in Week 4 slides.
# Students can run this code to reproduce all calculations.

cat("======================================================================\n")
cat("WEEK 4: CONFIDENCE INTERVALS - R CODE EXAMPLES\n")
cat("======================================================================\n\n")

# ==============================================================================
# EXAMPLE 1: Blood Pressure Study (Slides ~257-277)
# ==============================================================================
cat("EXAMPLE 1: Blood Pressure Study\n")
cat("----------------------------------------------------------------------\n")
cat("Research question: What is the mean systolic BP for adults with hypertension?\n\n")

# Data
n <- 25
xbar <- 128.4
s <- 12.6
confidence <- 0.95

cat("Data:\n")
cat("  Sample size (n):", n, "\n")
cat("  Sample mean (x̄):", xbar, "mmHg\n")
cat("  Sample SD (s):", s, "mmHg\n")
cat("  Confidence level:", confidence * 100, "%\n\n")

# Manual calculation
cat("Manual Calculation:\n")
cat("------------------\n")

# Step 1: Standard error
SE <- s / sqrt(n)
cat("Step 1 - Standard Error:\n")
cat("  SE = s/√n = ", s, "/√", n, " = ", SE, " mmHg\n\n", sep="")

# Step 2: Degrees of freedom and critical value
df <- n - 1
alpha <- 1 - confidence
t_crit <- qt(1 - alpha/2, df)
cat("Step 2 - Critical Value:\n")
cat("  df = n - 1 = ", n, " - 1 = ", df, "\n", sep="")
cat("  t(0.975, ", df, ") = ", round(t_crit, 3), "\n\n", sep="")

# Step 3: Margin of error
ME <- t_crit * SE
cat("Step 3 - Margin of Error:\n")
cat("  ME = t × SE = ", round(t_crit, 3), " × ", SE, " = ", round(ME, 2), " mmHg\n\n", sep="")

# Step 4: Confidence interval
lower <- xbar - ME
upper <- xbar + ME
cat("Step 4 - Confidence Interval:\n")
cat("  95% CI = x̄ ± ME = ", xbar, " ± ", round(ME, 2), "\n", sep="")
cat("         = (", round(lower, 1), ", ", round(upper, 1), ") mmHg\n\n", sep="")

cat("Interpretation:\n")
cat("  We are 95% confident that the true mean systolic blood pressure\n")
cat("  for adults with hypertension is between", round(lower, 1), "and", round(upper, 1), "mmHg.\n\n")

# Using t.test() function
cat("Using t.test() function:\n")
cat("------------------------\n")
cat("# Create sample data (using random values with same mean/SD)\n")
cat("set.seed(524)\n")
cat("bp_data <- rnorm(", n, ", mean = ", xbar, ", sd = ", s, ")\n", sep="")
cat("result <- t.test(bp_data, conf.level = 0.95)\n")
cat("result$conf.int\n\n")

set.seed(524)
bp_data <- rnorm(n, mean = xbar, sd = s)
result <- t.test(bp_data, conf.level = 0.95)
cat("95% CI from t.test():", round(result$conf.int[1], 2), "to", round(result$conf.int[2], 2), "\n\n")


# ==============================================================================
# EXAMPLE 2: Pain Medication Study (Slides ~307-327)
# ==============================================================================
cat("\n")
cat("======================================================================\n")
cat("EXAMPLE 2: Pain Medication Study\n")
cat("----------------------------------------------------------------------\n")
cat("Research question: How effective is the new pain medication?\n\n")

# Data
n <- 16
xbar <- 45.2
s <- 8.4
confidence <- 0.95

cat("Data:\n")
cat("  Sample size (n):", n, "\n")
cat("  Sample mean (x̄):", xbar, "minutes (pain relief time)\n")
cat("  Sample SD (s):", s, "minutes\n")
cat("  Confidence level:", confidence * 100, "%\n\n")

# Calculation
SE <- s / sqrt(n)
df <- n - 1
t_crit <- qt(0.975, df)
ME <- t_crit * SE
lower <- xbar - ME
upper <- xbar + ME

cat("Calculation:\n")
cat("  SE = ", s, "/√", n, " = ", SE, " minutes\n", sep="")
cat("  df = ", df, ", t-critical = ", round(t_crit, 3), "\n", sep="")
cat("  ME = ", round(t_crit, 3), " × ", SE, " = ", round(ME, 2), " minutes\n", sep="")
cat("  95% CI = (", round(lower, 1), ", ", round(upper, 1), ") minutes\n\n", sep="")

cat("R Code:\n")
cat("-------\n")
cat("n <- ", n, "\n", sep="")
cat("xbar <- ", xbar, "\n", sep="")
cat("s <- ", s, "\n", sep="")
cat("SE <- s / sqrt(n)\n")
cat("df <- n - 1\n")
cat("t_crit <- qt(0.975, df)\n")
cat("ME <- t_crit * SE\n")
cat("CI <- c(xbar - ME, xbar + ME)\n")
cat("CI\n\n")

CI <- c(lower, upper)
print(CI)


# ==============================================================================
# EXAMPLE 3: Sample Size for Cholesterol Study (Slides ~620-639)
# ==============================================================================
cat("\n")
cat("======================================================================\n")
cat("EXAMPLE 3: Sample Size Calculation - Cholesterol Study\n")
cat("----------------------------------------------------------------------\n")
cat("Planning question: How many subjects needed for desired precision?\n\n")

# Given information
z <- qnorm(0.975)  # 95% confidence
sigma <- 40         # Known population SD
ME <- 5            # Desired margin of error

cat("Given:\n")
cat("  Confidence level: 95% (z = ", round(z, 2), ")\n", sep="")
cat("  Population SD (σ):", sigma, "mg/dL\n")
cat("  Desired ME:", ME, "mg/dL\n\n")

# Sample size calculation
n_calc <- (z * sigma / ME)^2
n_needed <- ceiling(n_calc)

cat("Sample Size Calculation:\n")
cat("  n = (z × σ / ME)²\n")
cat("    = (", round(z, 2), " × ", sigma, " / ", ME, ")²\n", sep="")
cat("    = (", round(z * sigma, 1), " / ", ME, ")²\n", sep="")
cat("    = (", round(z * sigma / ME, 2), ")²\n", sep="")
cat("    = ", round(n_calc, 2), "\n\n", sep="")

cat("  Rounded UP: n = ", n_needed, " subjects\n\n", sep="")

cat("R Code:\n")
cat("-------\n")
cat("z <- qnorm(0.975)  # 95% confidence\n")
cat("sigma <- ", sigma, "\n", sep="")
cat("ME <- ", ME, "\n", sep="")
cat("n <- (z * sigma / ME)^2\n")
cat("ceiling(n)  # Round up\n\n")


# ==============================================================================
# EXAMPLE 4: Sample Size for Prevalence Study - Scenario 1 (p=0.5)
# ==============================================================================
cat("======================================================================\n")
cat("EXAMPLE 4: Sample Size for Prevalence Study - Conservative (p=0.5)\n")
cat("----------------------------------------------------------------------\n")
cat("Planning question: Sample size for estimating disease prevalence?\n\n")

# Given
z <- qnorm(0.975)
ME <- 0.03  # 3% margin of error
p <- 0.5    # Conservative estimate (worst case)

cat("Given:\n")
cat("  Confidence level: 95% (z = ", round(z, 2), ")\n", sep="")
cat("  Desired ME:", ME * 100, "% (", ME, ")\n", sep="")
cat("  Proportion estimate (p):", p, "(conservative - worst case)\n\n")

# Calculation
n_calc <- (z / ME)^2 * p * (1 - p)
n_needed <- ceiling(n_calc)

cat("Sample Size Calculation:\n")
cat("  n = (z/ME)² × p(1-p)\n")
cat("    = (", round(z, 2), "/", ME, ")² × ", p, " × ", (1-p), "\n", sep="")
cat("    = (", round(z/ME, 2), ")² × ", p * (1-p), "\n", sep="")
cat("    = ", round((z/ME)^2, 2), " × ", p * (1-p), "\n", sep="")
cat("    = ", round(n_calc, 1), "\n\n", sep="")

cat("  Rounded UP: n = ", n_needed, " subjects\n\n", sep="")

cat("R Code:\n")
cat("-------\n")
cat("z <- qnorm(0.975)\n")
cat("ME <- 0.03\n")
cat("p <- 0.5  # Conservative estimate\n")
cat("n <- (z / ME)^2 * p * (1 - p)\n")
cat("ceiling(n)\n\n")


# ==============================================================================
# EXAMPLE 5: Sample Size for Prevalence Study - Scenario 2 (p=0.15)
# ==============================================================================
cat("======================================================================\n")
cat("EXAMPLE 5: Sample Size for Prevalence Study - With Prior Estimate (p=0.15)\n")
cat("----------------------------------------------------------------------\n\n")

# Given
p <- 0.15  # Prior estimate from literature

cat("Given:\n")
cat("  Confidence level: 95% (z = ", round(z, 2), ")\n", sep="")
cat("  Desired ME:", ME * 100, "%\n", sep="")
cat("  Proportion estimate (p):", p, "(from prior study)\n\n")

# Calculation
n_calc <- (z / ME)^2 * p * (1 - p)
n_needed <- ceiling(n_calc)

cat("Sample Size Calculation:\n")
cat("  n = (z/ME)² × p(1-p)\n")
cat("    = (", round(z, 2), "/", ME, ")² × ", p, " × ", (1-p), "\n", sep="")
cat("    = ", round((z/ME)^2, 2), " × ", round(p * (1-p), 4), "\n", sep="")
cat("    = ", round(n_calc, 1), "\n\n", sep="")

cat("  Rounded UP: n = ", n_needed, " subjects\n\n", sep="")

cat("Comparison:\n")
cat("  Conservative (p=0.5): n = 1068\n")
cat("  With estimate (p=0.15): n = 545\n")
cat("  Using prior information reduces required sample size by 49%!\n\n")

cat("R Code:\n")
cat("-------\n")
cat("p <- 0.15  # Prior estimate\n")
cat("n <- (z / ME)^2 * p * (1 - p)\n")
cat("ceiling(n)\n\n")


# ==============================================================================
# SUMMARY
# ==============================================================================
cat("======================================================================\n")
cat("SUMMARY OF KEY R FUNCTIONS\n")
cat("======================================================================\n\n")

cat("1. Critical values:\n")
cat("   qt(0.975, df)     # t-critical value for 95% CI\n")
cat("   qnorm(0.975)      # z-critical value for 95% CI\n\n")

cat("2. Confidence interval for mean (using t.test):\n")
cat("   t.test(data, conf.level = 0.95)$conf.int\n\n")

cat("3. Confidence interval for proportion (using prop.test):\n")
cat("   prop.test(x, n, conf.level = 0.95)$conf.int\n\n")

cat("4. Sample size calculations:\n")
cat("   For mean: n <- (z * sigma / ME)^2\n")
cat("   For proportion: n <- (z / ME)^2 * p * (1-p)\n\n")

cat("5. Always round sample sizes UP:\n")
cat("   ceiling(n)\n\n")

cat("======================================================================\n")
cat("END OF EXAMPLES\n")
cat("======================================================================\n")
