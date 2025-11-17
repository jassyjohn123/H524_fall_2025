#!/usr/bin/env Rscript
# Verification script for Week 6 Assignment
# ALL numerical answers verified computationally

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 6 ASSIGNMENT - VERIFIED ANSWERS\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

# Question 1: Sample Size for Power
cat("QUESTION 1: Sample Size for Power\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Parameters
delta <- 10      # Effect size (reduction)
sd <- 20         # Standard deviation
sig.level <- 0.05
power <- 0.80

# Calculate required sample size
result <- power.t.test(delta = delta,
                       sd = sd,
                       sig.level = sig.level,
                       power = power,
                       type = "one.sample",
                       alternative = "two.sided")

n_required <- ceiling(result$n)

cat("Effect size (delta):", delta, "mmHg\n")
cat("Standard deviation:", sd, "mmHg\n")
cat("Significance level:", sig.level, "\n")
cat("Desired power:", power, "\n")
cat("Exact sample size:", round(result$n, 2), "\n")
cat("Required sample size (rounded up):", n_required, "subjects\n\n")

# Question 2: Two-Sample t-Test and ANOVA
cat("QUESTION 2: Two-Sample t-Test and ANOVA\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Data
program_a <- c(4.2, 3.8, 4.5, 4.1, 4.3)
program_b <- c(6.1, 5.8, 6.4, 5.9, 6.2)
program_c <- c(7.8, 8.2, 7.5, 8.0, 7.9)

cat("\nProgram A: mean =", mean(program_a), ", sd =", round(sd(program_a), 3), "\n")
cat("Program B: mean =", mean(program_b), ", sd =", round(sd(program_b), 3), "\n")
cat("Program C: mean =", mean(program_c), ", sd =", round(sd(program_c), 3), "\n\n")

# Part A: ANOVA
cat("PART A: One-Way ANOVA\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Create data frame
weight_loss <- c(program_a, program_b, program_c)
program <- factor(rep(c("A", "B", "C"), each=5))
data <- data.frame(weight_loss, program)

# Perform ANOVA
anova_model <- aov(weight_loss ~ program, data=data)
anova_summary <- summary(anova_model)

f_statistic <- anova_summary[[1]]$"F value"[1]
p_value_anova <- anova_summary[[1]]$"Pr(>F)"[1]

cat("F-statistic:", round(f_statistic, 2), "\n")
cat("p-value:", format(p_value_anova, scientific=FALSE, digits=6), "\n\n")

# Part B: Two-Sample t-Test (A vs C)
cat("PART B: Two-Sample t-Test (Program A vs Program C)\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Perform t-test
t_test_result <- t.test(program_a, program_c,
                        var.equal = TRUE,
                        alternative = "two.sided")

t_statistic <- t_test_result$statistic
df <- t_test_result$parameter
p_value_ttest <- t_test_result$p.value

cat("t-statistic:", round(t_statistic, 3), "\n")
cat("Degrees of freedom:", df, "\n")
cat("p-value:", round(p_value_ttest, 4), "\n\n")

# Question 8: Pooled Standard Deviation
cat("QUESTION 8: Pooled Standard Deviation\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Data
n1 <- 12
s1 <- 18.5
n2 <- 15
s2 <- 21.3

# Calculate pooled standard deviation
s_p <- sqrt(((n1-1)*s1^2 + (n2-1)*s2^2) / (n1 + n2 - 2))

cat("Diet 1: n1 =", n1, ", s1 =", s1, "mg/dL\n")
cat("Diet 2: n2 =", n2, ", s2 =", s2, "mg/dL\n")
cat("Pooled SD: s_p =", round(s_p, 2), "mg/dL\n\n")

# Question 9: Test Statistic Calculation
cat("QUESTION 9: Test Statistic Calculation\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Data
n1_q9 <- 20
xbar1_q9 <- 85.3
s1_q9 <- 12.4

n2_q9 <- 18
xbar2_q9 <- 78.6
s2_q9 <- 14.1

# Step 1: Calculate pooled SD
s_p_q9 <- sqrt(((n1_q9-1)*s1_q9^2 + (n2_q9-1)*s2_q9^2) / (n1_q9 + n2_q9 - 2))

# Step 2: Calculate standard error
se_q9 <- s_p_q9 * sqrt(1/n1_q9 + 1/n2_q9)

# Step 3: Calculate t-statistic
t_stat <- (xbar1_q9 - xbar2_q9) / se_q9

cat("Method 1: n =", n1_q9, ", mean =", xbar1_q9, ", sd =", s1_q9, "\n")
cat("Method 2: n =", n2_q9, ", mean =", xbar2_q9, ", sd =", s2_q9, "\n")
cat("Pooled SD: s_p =", round(s_p_q9, 3), "\n")
cat("Standard error:", round(se_q9, 4), "\n")
cat("t-statistic =", round(t_stat, 2), "\n\n")

# Question 10: Confidence Interval for Mean Difference
cat("QUESTION 10: Confidence Interval for Mean Difference\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Using data from Q9
mean_diff <- xbar1_q9 - xbar2_q9
se_diff <- se_q9  # Same as calculated in Q9
df_q10 <- n1_q9 + n2_q9 - 2
t_crit <- qt(0.975, df_q10)
ci_lower <- mean_diff - t_crit * se_diff
ci_upper <- mean_diff + t_crit * se_diff

cat("Mean difference:", round(mean_diff, 2), "\n")
cat("Standard error:", round(se_diff, 4), "\n")
cat("Degrees of freedom:", df_q10, "\n")
cat("t-critical (0.975):", round(t_crit, 3), "\n")
cat("95% CI: (", round(ci_lower, 2), ",", round(ci_upper, 2), ")\n")
cat("Interpretation: CI does", ifelse(ci_lower > 0 | ci_upper < 0, "", " NOT"),
    " exclude 0, so", ifelse(ci_lower > 0 | ci_upper < 0, "", " no"),
    " significant difference at alpha=0.05\n\n")

# Question 11: Power Calculation
cat("QUESTION 11: Power Calculation\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Parameters
n_q11 <- 30
delta_q11 <- 12
sd_q11 <- 18
alpha_q11 <- 0.05

# Calculate power
result_q11 <- power.t.test(n = n_q11,
                           delta = delta_q11,
                           sd = sd_q11,
                           sig.level = alpha_q11,
                           type = "one.sample",
                           alternative = "two.sided")

power_q11 <- result_q11$power

cat("Sample size: n =", n_q11, "\n")
cat("Effect size (delta):", delta_q11, "mg/dL\n")
cat("Standard deviation:", sd_q11, "mg/dL\n")
cat("Significance level:", alpha_q11, "\n")
cat("Power:", round(power_q11, 4), "\n")
cat("Power (rounded):", round(power_q11, 2), "\n\n")

# Summary of Answers
cat(paste(rep("=", 70), collapse=""), "\n")
cat("ANSWER KEY SUMMARY\n")
cat(paste(rep("=", 70), collapse=""), "\n")
cat("Question 6: Sample size =", n_required, "subjects\n")
cat("Question 7A: F-statistic =", round(f_statistic, 2), "\n")
cat("Question 7B: p-value =", round(p_value_ttest, 4), "\n")
cat("Question 8: Pooled SD =", round(s_p, 2), "mg/dL\n")
cat("Question 9: t-statistic =", round(t_stat, 2), "\n")
cat("Question 10: 95% CI = (", round(ci_lower, 2), ",", round(ci_upper, 2), ")\n")
cat("Question 11: Power =", round(power_q11, 2), "\n")
cat(paste(rep("=", 70), collapse=""), "\n")
cat("ALL ANSWERS VERIFIED\n")
cat(paste(rep("=", 70), collapse=""), "\n")
