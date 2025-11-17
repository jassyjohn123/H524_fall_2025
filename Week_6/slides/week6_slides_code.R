#!/usr/bin/env Rscript
# ============================================================================
# Week 6: Power, Two-Sample Tests, and ANOVA - All R Code from Slides
# H524 Introduction to Biostatistics - Fall 2025
# Dr. John Molitor
# ============================================================================
#
# This script contains all R code examples from the Week 6 slides
# Topics covered:
#   - Statistical Power and Sample Size Calculations
#   - Two-Sample t-Tests (Independent Samples)
#   - Paired t-Tests (Dependent Samples)
#   - Analysis of Variance (ANOVA)
#   - Post-Hoc Tests (Tukey's HSD, Bonferroni)
#
# ============================================================================

# ============================================================================
# POWER CALCULATION EXAMPLE
# Slide: "Power Calculation in R"
# ============================================================================

# Parameters
mu0 <- 200; mu1 <- 199.9; sigma <- 30; n <- 25; alpha <- 0.05

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
cat("Power:", round(power, 3))  # 0.385

# ============================================================================
# SAMPLE SIZE CALCULATION
# Slide: "Sample Size Calculation in R"
# ============================================================================

# Calculate required sample size for power = 0.80
my_power <- power.t.test(delta = 10,      # Effect size (|mu1 - mu0|)
             sd = 30,          # Standard deviation
             sig.level = 0.01, # Significance level
             power = 0.90,     # Desired power
             type = "one.sample")

# Output:
#      One-sample t test power calculation
#               n = 72.58
#           delta = 10
#              sd = 30
#       sig.level = 0.05
#           power = 0.8
# Need n = 73 subjects

# Can also calculate power for given n
power.t.test(n = 25, delta = 10, sd = 30,
             sig.level = 0.05, type = "one.sample")
# Power = 0.360 (slightly lower than z-based calculation of 0.385)

# ============================================================================
# TWO-SAMPLE T-TEST EXAMPLE: TUMOR GROWTH STUDY
# Slide: "Two-Sample t-Test in R (Part 1 - Setup)"
# ============================================================================

# Enter data
control <- c(7, 10, 9, 8, 7, 6, 8, 9, 12, 13)
treatment <- c(4, 6, 10, 8, 5, 3, 10, 8, 8, 10)

# Summary statistics
mean(control)    # 8.9 mm
mean(treatment)  # 7.2 mm
sd(control)      # 2.234 mm
sd(treatment)    # 2.573 mm

# Pooled two-sample t-test (equal variances)
my_tt <- t.test(control, treatment,
       var.equal = TRUE,     # Assume equal variances
       alternative = "greater",
       conf.level=0.95)  # One-sided: control > treatment

# ============================================================================
# TWO-SAMPLE T-TEST RESULTS
# Slide: "Two-Sample t-Test in R (Part 2 - Results)"
# ============================================================================

# Output from t.test():
# t = 1.578, df = 18, p-value = 0.066
# mean of x = 8.9, mean of y = 7.2
# 95% CI: (-0.182, Inf)

# Conclusion: p = 0.066 > 0.05, fail to reject H0
# Not enough evidence that treatment reduces growth

# ============================================================================
# PAIRED T-TEST EXAMPLE: BLOOD PRESSURE MEDICATION
# Slide: "Paired t-Test in R (Part 1 - Setup)"
# ============================================================================

# Enter data
before <- c(145, 150, 148, 142, 140, 146, 149, 143, 147, 144)
after <- c(138, 142, 145, 138, 135, 140, 142, 136, 141, 138)

# Calculate differences
differences <- before - after
mean(differences)  # 5.9 mmHg
sd(differences)    # 1.52 mmHg

# Paired t-test (Method 1: on differences)
t.test(differences, mu = 0, alternative = "greater")

# Paired t-test (Method 2: paired argument)
t.test(before, after, paired = TRUE, alternative = "greater")

# ============================================================================
# PAIRED T-TEST RESULTS
# Slide: "Paired t-Test in R (Part 2 - Results)"
# ============================================================================

# Output from paired t-test:
# t = 12.24, df = 9, p-value = 0.00000032
# mean of differences = 5.9
# 95% CI: (5.05, Inf)

# Conclusion: p < 0.001, strong evidence that
# medication reduces blood pressure by 5.9 mmHg on average

# ============================================================================
# ANOVA EXAMPLE: DRUG DOSE STUDY
# Slide: "ANOVA in R (Part 1 - Setup)"
# ============================================================================

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

# ============================================================================
# ANOVA RESULTS
# Slide: "ANOVA in R (Part 2 - Results)"
# ============================================================================

# Output from summary(model):
#             Df Sum Sq Mean Sq F value Pr(>F)
# dose         2  746.1   373.1   113.1  1.64e-08 ***
# Residuals   12   39.6     3.3

# Conclusion: F(2,12) = 113.1, p < 0.001
# Strong evidence that at least one dose differs

# ============================================================================
# POST-HOC TEST: TUKEY'S HSD
# Slide: "Post-Hoc Tests in R (Part 1 - Tukey's HSD)"
# ============================================================================

# Tukey's HSD test
TukeyHSD(model)

# Output:
#   Tukey multiple comparisons of means
#     95% family-wise confidence level
#
# Fit: aov(formula = cholesterol ~ dose, data = data)
#
# $dose
#                    diff       lwr      upr     p adj
# Medium-Low      7.2000   4.413   10.0870  0.000032
# High-Low       17.2000  14.413   19.9870  0.000000
# High-Medium    10.0000   7.213   12.7870  0.000001

# All pairwise differences are significant
# High dose reduces cholesterol significantly more than
# medium dose, which reduces more than low dose

# ============================================================================
# POST-HOC TEST: BONFERRONI CORRECTION
# Slide: "Post-Hoc Tests in R (Part 2 - Alternative)"
# ============================================================================

# Alternative: Pairwise t-tests with Bonferroni correction
pairwise.t.test(data$cholesterol, data$dose,
                p.adjust.method = "bonferroni")

# Output:
#         Low    Medium
# Medium  3.2e-5  -
# High    < 2e-16 9.5e-7

# Results are similar to Tukey's HSD
# All pairwise differences remain highly significant

# ============================================================================
# AI DEMO: POWER ANALYSIS WITH VISUALIZATION
# Slide: "AI Demo: Power Analysis"
# ============================================================================

# Power analysis for one-sample t-test
# Detect 5 mmHg reduction from baseline
# Assume SD = 15 mmHg, power = 0.80, alpha = 0.05

power.t.test(delta = 5,        # Effect size
             sd = 15,           # Standard deviation
             sig.level = 0.05,  # Alpha
             power = 0.80,      # Desired power
             type = "one.sample")

# Result: n = 142.2 (need 143 subjects)

# Visualize power curve
n_values <- seq(10, 300, by=10)
power_values <- sapply(n_values, function(n) {
  power.t.test(n=n, delta=5, sd=15, sig.level=0.05,
               type="one.sample")$power
})

plot(n_values, power_values, type="l", lwd=2,
     xlab="Sample Size", ylab="Power",
     main="Power vs. Sample Size",
     col="blue")
abline(h=0.80, col="red", lty=2)
abline(v=143, col="red", lty=2)
grid()

# ============================================================================
# AI DEMO: CHOOSING THE RIGHT TEST (PAIRED DATA)
# Slide: "AI Demo: Choosing the Right Test (Part 1)"
# ============================================================================

# You should use a PAIRED t-test because:
#
# 1. Same subjects measured twice (before/after)
# 2. Data are dependent (matched pairs)
# 3. Want to compare mean change from baseline
#
# R code (TEMPLATE - not executable):
# before <- c(...)  # Your before data
# after <- c(...)   # Your after data
#
# # Method 1: Test on differences
# differences <- before - after
# t.test(differences, mu=0, alternative="two.sided")
#
# # Method 2: Using paired argument
# t.test(before, after, paired=TRUE)

# ============================================================================
# AI DEMO: ANOVA WITH ASSUMPTION CHECKS
# Slide: "AI Demo: ANOVA (Part 1 - Setup)"
# ============================================================================

# Assume data structure:
# outcome: numeric response variable
# treatment: factor with 4 levels
#
# R code (TEMPLATE - not executable, requires your own data):
#
# # Step 1: Check assumptions
# # Visualize distributions
# boxplot(outcome ~ treatment, data=mydata,
#         main="Outcome by Treatment Group")
#
# # Test homogeneity of variance
# bartlett.test(outcome ~ treatment, data=mydata)
# # If p > 0.05, variances are equal (good!)
#
# # Step 2: Perform ANOVA
# model <- aov(outcome ~ treatment, data=mydata)
# summary(model)

# ============================================================================
# AI DEMO: ANOVA POST-HOC TESTS
# Slide: "AI Demo: ANOVA (Part 2 - Post-Hoc)"
# ============================================================================

# R code (TEMPLATE - not executable, requires data from previous step):
#
# # Step 3: If ANOVA significant, do post-hoc tests
# # Tukey's HSD (most common)
# TukeyHSD(model, conf.level=0.95)
#
# # Visualize Tukey results
# plot(TukeyHSD(model))
#
# # Interpretation:
# # - ANOVA tests if ANY groups differ (omnibus test)
# # - Tukey tells you WHICH specific pairs differ
# # - Tukey controls family-wise error rate at 0.05

# ============================================================================
# END OF SCRIPT
# ============================================================================

cat("\n=======================================================\n")
cat("Week 6 R Code Examples Completed\n")
cat("All code blocks from slides have been executed\n")
cat("=======================================================\n")
