#!/usr/bin/env Rscript
# Test ALL R code from Week 6 materials

cat("="*70, "\n")
cat("TESTING ALL WEEK 6 R CODE\n")
cat("="*70, "\n\n")

# =============================================================================
# SLIDES CODE
# =============================================================================
cat("SLIDES - Example 1: Power Calculation\n")
cat("-"*70, "\n")

mu0 <- 200
mu1 <- 190
sigma <- 30
n <- 25
alpha <- 0.05
se <- sigma / sqrt(n)
z_crit <- qnorm(1 - alpha/2)
lower_crit <- mu0 - z_crit * se
upper_crit <- mu0 + z_crit * se
power_lower <- pnorm(lower_crit, mean=mu1, sd=se)
power_upper <- pnorm(upper_crit, mean=mu1, sd=se, lower.tail=FALSE)
power <- power_lower + power_upper
cat("Power:", round(power, 3), "\n")

# Sample size
power.t.test(delta = 10, sd = 30, sig.level = 0.05, power = 0.80, type = "one.sample")
cat("✓ Slides Example 1 runs\n\n")

# =============================================================================
cat("SLIDES - Example 2: Tumor Growth\n")
cat("-"*70, "\n")

control <- c(7, 10, 9, 8, 7, 6, 8, 9, 12, 13)
treatment <- c(4, 6, 10, 8, 5, 3, 10, 8, 8, 10)
t.test(control, treatment, var.equal = TRUE, alternative = "greater")
cat("✓ Slides Example 2 runs\n\n")

# =============================================================================
cat("SLIDES - Example 4: Paired t-Test\n")
cat("-"*70, "\n")

before <- c(145, 150, 148, 142, 140, 146, 149, 143, 147, 144)
after <- c(138, 142, 145, 138, 135, 140, 142, 136, 141, 138)
differences <- before - after
t.test(differences, mu = 0, alternative = "greater")
cat("✓ Slides Example 4 runs\n\n")

# =============================================================================
cat("SLIDES - Example 5: ANOVA\n")
cat("-"*70, "\n")

low <- c(10, 12, 8, 11, 9)
medium <- c(15, 18, 16, 20, 17)
high <- c(25, 28, 30, 26, 27)
cholesterol <- c(low, medium, high)
dose <- factor(rep(c("Low", "Medium", "High"), each=5), levels=c("Low", "Medium", "High"))
data <- data.frame(cholesterol, dose)
model <- aov(cholesterol ~ dose, data=data)
summary(model)
cat("✓ Slides Example 5 runs\n\n")

# =============================================================================
# LAB CODE
# =============================================================================
cat("LAB - Exercise 1.2: Power Calculation\n")
cat("-"*70, "\n")

result <- power.t.test(n = 25, delta = 10, sd = 30, sig.level = 0.05, type = "one.sample")
cat("Power:", round(result$power, 3), "\n")

result2 <- power.t.test(delta = 10, sd = 30, sig.level = 0.05, power = 0.80, type = "one.sample")
cat("Required n:", ceiling(result2$n), "\n")
cat("✓ Lab Exercise 1.2 runs\n\n")

# =============================================================================
cat("LAB - Exercise 1.4: Two-Sample Power\n")
cat("-"*70, "\n")

power.t.test(delta = 15, sd = 20, sig.level = 0.05, power = 0.90, type = "two.sample")
power.t.test(n = 20, delta = 15, sd = 20, sig.level = 0.05, type = "two.sample")
cat("✓ Lab Exercise 1.4 runs\n\n")

# =============================================================================
cat("LAB - Exercise 2.1: Two-Sample t-Test\n")
cat("-"*70, "\n")

control <- c(7, 10, 9, 8, 7, 6, 8, 9, 12, 13)
treatment <- c(4, 6, 10, 8, 5, 3, 10, 8, 8, 10)
t.test(control, treatment, var.equal = TRUE, alternative = "two.sided")
cat("✓ Lab Exercise 2.1 runs\n\n")

# =============================================================================
cat("LAB - Exercise 3.1: Paired t-Test\n")
cat("-"*70, "\n")

before <- c(142, 138, 150, 148, 135, 160, 155, 145, 152, 158)
after <- c(138, 132, 148, 140, 135, 152, 148, 142, 146, 150)
differences <- before - after
t.test(differences, mu=0, alternative="greater")
t.test(before, after, paired=TRUE, alternative="greater")
cat("✓ Lab Exercise 3.1 runs\n\n")

# =============================================================================
cat("LAB - Exercise 4.1: ANOVA\n")
cat("-"*70, "\n")

low <- c(10, 12, 8, 11, 9)
medium <- c(15, 18, 16, 20, 17)
high <- c(25, 28, 30, 26, 27)
cholesterol <- c(low, medium, high)
dose <- factor(rep(c("Low", "Medium", "High"), each=5), levels=c("Low", "Medium", "High"))
data <- data.frame(cholesterol, dose)
model <- aov(cholesterol ~ dose, data=data)
summary(model)
TukeyHSD(model)
cat("✓ Lab Exercise 4.1 runs\n\n")

# =============================================================================
# ASSIGNMENT CODE
# =============================================================================
cat("ASSIGNMENT - Question 1: Sample Size\n")
cat("-"*70, "\n")

result <- power.t.test(delta = 10, sd = 20, sig.level = 0.05, power = 0.80, type = "one.sample", alternative = "two.sided")
cat("Required n:", ceiling(result$n), "\n")
cat("✓ Assignment Q1 runs\n\n")

# =============================================================================
cat("ASSIGNMENT - Question 2: ANOVA and t-Test\n")
cat("-"*70, "\n")

program_a <- c(4.2, 3.8, 4.5, 4.1, 4.3)
program_b <- c(6.1, 5.8, 6.4, 5.9, 6.2)
program_c <- c(7.8, 8.2, 7.5, 8.0, 7.9)

weight_loss <- c(program_a, program_b, program_c)
program <- factor(rep(c("A", "B", "C"), each=5))
data <- data.frame(weight_loss, program)

anova_model <- aov(weight_loss ~ program, data=data)
summary(anova_model)

t_test_result <- t.test(program_a, program_c, var.equal = TRUE, alternative = "two.sided")
print(t_test_result)
cat("✓ Assignment Q2 runs\n\n")

# =============================================================================
cat("="*70, "\n")
cat("ALL R CODE VERIFIED - NO ERRORS\n")
cat("="*70, "\n")
