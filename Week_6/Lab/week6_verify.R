#!/usr/bin/env Rscript
# Verification script for Week 6 Lab
# ALL numerical examples verified computationally

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 6 LAB - NUMERICAL VERIFICATION\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

# Exercise 1.2: Power Calculation
cat("EXERCISE 1.2: Power Calculation\n")
cat(paste(rep("-", 70), collapse=""), "\n")
result <- power.t.test(n=25, delta=10, sd=30, sig.level=0.05, type="one.sample")
cat("Power for n=25:", round(result$power, 3), "| Lab shows: 0.359 | Match:",
    ifelse(abs(result$power - 0.359) < 0.01, "✓", "✗"), "\n")

result2 <- power.t.test(delta=10, sd=30, sig.level=0.05, power=0.80, type="one.sample")
cat("Required n for 80% power:", ceiling(result2$n), "| Lab shows: 73 | Match:",
    ifelse(ceiling(result2$n) >= 72 && ceiling(result2$n) <= 74, "✓", "✗"), "\n\n")

# Exercise 1.4: Two-Sample Power
cat("EXERCISE 1.4: Two-Sample Power\n")
cat(paste(rep("-", 70), collapse=""), "\n")
result3 <- power.t.test(delta=15, sd=20, sig.level=0.05, power=0.90, type="two.sample")
cat("Required n per group:", ceiling(result3$n), "| Lab shows: 39 | Match:",
    ifelse(abs(ceiling(result3$n) - 39) <= 1, "✓", "✗"), "\n")

result4 <- power.t.test(n=20, delta=15, sd=20, sig.level=0.05, type="two.sample")
cat("Power for n=20:", round(result4$power, 3), "| Lab shows: 0.637 | Match:",
    ifelse(abs(result4$power - 0.637) < 0.01, "✓", "✗"), "\n\n")

# Exercise 2.1: Tumor Growth Two-Sample t-Test
cat("EXERCISE 2.1: Tumor Growth Two-Sample t-Test\n")
cat(paste(rep("-", 70), collapse=""), "\n")
control <- c(7, 10, 9, 8, 7, 6, 8, 9, 12, 13)
treatment <- c(4, 6, 10, 8, 5, 3, 10, 8, 8, 10)

cat("Control: mean =", mean(control), "sd =", round(sd(control), 3),
    "| Lab shows: 8.9, 2.234 | Match:",
    ifelse(abs(mean(control) - 8.9) < 0.1 && abs(sd(control) - 2.234) < 0.01, "✓", "✗"), "\n")
cat("Treatment: mean =", mean(treatment), "sd =", round(sd(treatment), 3),
    "| Lab shows: 7.2, 2.573 | Match:",
    ifelse(abs(mean(treatment) - 7.2) < 0.1 && abs(sd(treatment) - 2.573) < 0.01, "✓", "✗"), "\n\n")

# Exercise 3.1: Blood Pressure Paired t-Test
cat("EXERCISE 3.1: Blood Pressure Paired t-Test\n")
cat(paste(rep("-", 70), collapse=""), "\n")
before <- c(142, 138, 150, 148, 135, 160, 155, 145, 152, 158)
after <- c(138, 132, 148, 140, 135, 152, 148, 142, 146, 150)
differences <- before - after

cat("Mean difference:", mean(differences), "| Lab shows: 5.2 | Match:",
    ifelse(abs(mean(differences) - 5.2) < 0.1, "✓", "✗"), "\n")
cat("SD of differences:", round(sd(differences), 2), "| Lab shows: 2.82 | Match:",
    ifelse(abs(sd(differences) - 2.82) < 0.1, "✓", "✗"), "\n\n")

# Exercise 4.1: Drug Dose ANOVA
cat("EXERCISE 4.1: Drug Dose ANOVA\n")
cat(paste(rep("-", 70), collapse=""), "\n")
low <- c(10, 12, 8, 11, 9)
medium <- c(15, 18, 16, 20, 17)
high <- c(25, 28, 30, 26, 27)

cat("Low: mean =", mean(low), "sd =", round(sd(low), 2),
    "| Lab shows: 10.0, 1.58 | Match:",
    ifelse(abs(mean(low) - 10.0) < 0.1 && abs(sd(low) - 1.58) < 0.01, "✓", "✗"), "\n")
cat("Medium: mean =", mean(medium), "sd =", round(sd(medium), 2),
    "| Lab shows: 17.2, 1.92 | Match:",
    ifelse(abs(mean(medium) - 17.2) < 0.1 && abs(sd(medium) - 1.92) < 0.01, "✓", "✗"), "\n")
cat("High: mean =", mean(high), "sd =", round(sd(high), 2),
    "| Lab shows: 27.2, 1.92 | Match:",
    ifelse(abs(mean(high) - 27.2) < 0.1 && abs(sd(high) - 1.92) < 0.01, "✓", "✗"), "\n")

cholesterol <- c(low, medium, high)
dose <- factor(rep(c("Low", "Medium", "High"), each=5), levels=c("Low", "Medium", "High"))
data <- data.frame(cholesterol, dose)
anova_model <- aov(cholesterol ~ dose, data=data)
anova_summary <- summary(anova_model)
f_stat <- anova_summary[[1]]$"F value"[1]

cat("F-statistic:", round(f_stat, 1), "| Lab shows: 113.1 | Match:",
    ifelse(abs(f_stat - 113.1) < 1, "✓", "✗"), "\n\n")

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 6 LAB VERIFICATION COMPLETE\n")
cat(paste(rep("=", 70), collapse=""), "\n")
