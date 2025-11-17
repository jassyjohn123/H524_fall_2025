#!/usr/bin/env Rscript
# Testing all R code from Week 6 slides

cat(paste(rep("=", 60), collapse=""), "\n")
cat("TESTING WEEK 6 SLIDES R CODE\n")
cat(paste(rep("=", 60), collapse=""), "\n\n")

# ============================================================
# Power Calculation Example (Slide ~line 208)
# ============================================================
cat("TEST 1: Power Calculation\n")
cat(paste(rep("-", 60), collapse=""), "\n")

# Parameters
mu0 <- 200; mu1 <- 190; sigma <- 30; n <- 25; alpha <- 0.05

# Standard error
se <- sigma / sqrt(n)  # 6

# Critical values (two-sided)
z_crit <- qnorm(1 - alpha/2)  # 1.96
lower_crit <- mu0 - z_crit * se  # 188.24
upper_crit <- mu0 + z_crit * se  # 211.76

# Power: P(reject H0 | mu = 190)
power_lower <- pnorm(lower_crit, mean=mu1, sd=se)
power_upper <- pnorm(upper_crit, mean=mu1, sd=se,
                     lower.tail=FALSE)
power <- power_lower + power_upper
cat("Power:", round(power, 3), "\n\n")

# ============================================================
# Sample Size Calculation (Slide ~line 263)
# ============================================================
cat("TEST 2: Sample Size Calculation\n")
cat(paste(rep("-", 60), collapse=""), "\n")

# Calculate required sample size for power = 0.80
power.t.test(delta = 10,      # Effect size (|mu1 - mu0|)
             sd = 30,          # Standard deviation
             sig.level = 0.05, # Significance level
             power = 0.80,     # Desired power
             type = "one.sample")

cat("\n")

# ============================================================
# Calculate power for given n (Slide ~line 288)
# ============================================================
cat("TEST 3: Calculate Power for Given n\n")
cat(paste(rep("-", 60), collapse=""), "\n")

# Can also calculate power for given n
power.t.test(n = 25, delta = 10, sd = 30,
             sig.level = 0.05, type = "one.sample")

cat("\n")

# ============================================================
# Two-Sample t-Test (Slide ~line 453)
# ============================================================
cat("TEST 4: Two-Sample t-Test\n")
cat(paste(rep("-", 60), collapse=""), "\n")

# Enter data
control <- c(7, 10, 9, 8, 7, 6, 8, 9, 12, 13)
treatment <- c(4, 6, 10, 8, 5, 3, 10, 8, 8, 10)

# Summary statistics
cat("Control mean:", mean(control), "mm\n")
cat("Treatment mean:", mean(treatment), "mm\n")
cat("Control SD:", sd(control), "mm\n")
cat("Treatment SD:", sd(treatment), "mm\n\n")

# Pooled two-sample t-test (equal variances)
t.test(control, treatment,
       var.equal = TRUE,     # Assume equal variances
       alternative = "greater")  # One-sided: control > treatment

cat("\n")

# ============================================================
# Paired t-Test (Slide ~line 628)
# ============================================================
cat("TEST 5: Paired t-Test\n")
cat(paste(rep("-", 60), collapse=""), "\n")

# Enter data
before <- c(145, 150, 148, 142, 140, 146, 149, 143, 147, 144)
after <- c(138, 142, 145, 138, 135, 140, 142, 136, 141, 138)

# Calculate differences
differences <- before - after
cat("Mean difference:", mean(differences), "mmHg\n")
cat("SD of differences:", sd(differences), "mmHg\n\n")

# Paired t-test (Method 1: on differences)
t.test(differences, mu = 0, alternative = "greater")

cat("\n")

# Paired t-test (Method 2: paired argument)
t.test(before, after, paired = TRUE, alternative = "greater")

cat("\n")

# ============================================================
# ANOVA (Slide ~line 923)
# ============================================================
cat("TEST 6: ANOVA\n")
cat(paste(rep("-", 60), collapse=""), "\n")

# Enter data
low <- c(10, 12, 8, 11, 9)
medium <- c(15, 18, 16, 20, 17)
high <- c(25, 28, 30, 26, 27)

# Create data frame
cholesterol <- c(low, medium, high)
dose <- factor(rep(c("Low", "Medium", "High"), each=5),
               levels=c("Low", "Medium", "High"))
data <- data.frame(cholesterol, dose)

# Perform ANOVA
model <- aov(cholesterol ~ dose, data=data)
summary(model)

cat("\n")

# ============================================================
# Post-Hoc Tests (Slide ~line 998)
# ============================================================
cat("TEST 7: Tukey's HSD\n")
cat(paste(rep("-", 60), collapse=""), "\n")

# Tukey's HSD test
TukeyHSD(model)

cat("\n")

# ============================================================
cat(paste(rep("=", 60), collapse=""), "\n")
cat("ALL TESTS COMPLETE\n")
cat(paste(rep("=", 60), collapse=""), "\n")
