#!/usr/bin/env Rscript
# Verification script for Week 7 Worksheet
# All computational problems verified with R

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 7 WORKSHEET - VERIFIED ANSWERS\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

# Problem 1: Sign Test
cat("PROBLEM 1: Sign Test (Recovery Times)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
recovery <- c(12, 15, 10, 13, 16, 11, 14, 9, 12, 15)
median_0 <- 14

# Count positive and negative signs
differences <- recovery - median_0
B_plus <- sum(differences > 0)
B_minus <- sum(differences < 0)
B_zero <- sum(differences == 0)
test_stat <- min(B_plus, B_minus)

cat("Data:", paste(recovery, collapse=", "), "\n")
cat("Differences from 14:", paste(differences, collapse=", "), "\n")
cat("B+ (above 14):", B_plus, "\n")
cat("B- (below 14):", B_minus, "\n")
cat("B0 (equal to 14):", B_zero, "\n")
cat("Test statistic B:", test_stat, "\n")

# One-sided test (less than 14)
# H1: median < 14, so we want P(X <= B-) where X ~ Binom(n, 0.5)
n <- length(recovery) - B_zero
result_sign <- binom.test(B_minus, n, p=0.5, alternative="greater")
cat("One-sided p-value (H1: median < 14):", round(result_sign$p.value, 4), "\n")
cat("Conclusion: p =", round(result_sign$p.value, 4))
if(result_sign$p.value < 0.05) {
  cat(" < 0.05, REJECT H0. Median IS less than 14 days.\n")
} else {
  cat(" >= 0.05, FAIL TO REJECT H0. Not enough evidence.\n")
}
cat("\n")

# Problem 2: Wilcoxon Signed-Rank Test
cat("PROBLEM 2: Wilcoxon Signed-Rank Test (Same Data)\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Calculate differences, ranks, and signed ranks
diffs <- recovery - median_0
abs_diffs <- abs(diffs[diffs != 0])
ranks <- rank(abs_diffs)
signed_ranks <- ranks * sign(diffs[diffs != 0])

cat("Differences:", paste(round(diffs, 2), collapse=", "), "\n")
cat("Non-zero absolute differences:", paste(round(abs_diffs, 2), collapse=", "), "\n")
cat("Ranks:", paste(ranks, collapse=", "), "\n")
cat("Signed ranks:", paste(round(signed_ranks, 2), collapse=", "), "\n")
cat("W+ (sum of positive ranks):", sum(signed_ranks[signed_ranks > 0]), "\n")
cat("W- (sum of negative ranks):", abs(sum(signed_ranks[signed_ranks < 0])), "\n")

result_wilcox <- wilcox.test(recovery, mu=median_0)
cat("Wilcoxon p-value:", round(result_wilcox$p.value, 4), "\n")
cat("Comparison: Sign test p =", round(result_sign$p.value, 4),
    ", Wilcoxon p =", round(result_wilcox$p.value, 4), "\n")
cat("More powerful test: Wilcoxon (uses magnitude of differences)\n\n")

# Problem 3: Paired Data (Blood Pressure)
cat("PROBLEM 3: Paired Data (Blood Pressure)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
bp_before <- c(142, 138, 155, 148, 160, 145, 152, 149)
bp_after <- c(138, 140, 148, 145, 155, 142, 150, 145)
bp_diff <- bp_before - bp_after

cat("Before:", paste(bp_before, collapse=", "), "\n")
cat("After:", paste(bp_after, collapse=", "), "\n")
cat("Differences (Before - After):", paste(bp_diff, collapse=", "), "\n")

# Part B: Sign test
n_positive <- sum(bp_diff > 0)
n_negative <- sum(bp_diff < 0)
n_total <- length(bp_diff)
result_sign_bp <- binom.test(n_positive, n_total, p=0.5)
cat("\nPart B - Sign Test:\n")
cat("Number positive:", n_positive, "\n")
cat("Number negative:", n_negative, "\n")
cat("Sign test p-value:", round(result_sign_bp$p.value, 4), "\n")

# Part C: Wilcoxon signed-rank test
result_wilcox_bp <- wilcox.test(bp_before, bp_after, paired=TRUE)
cat("\nPart C - Wilcoxon Signed-Rank Test:\n")
cat("Wilcoxon p-value:", round(result_wilcox_bp$p.value, 4), "\n")

cat("\nPart D - Recommendation:\n")
cat("Wilcoxon is more powerful (uses magnitude of changes).\n")
cat("Mean reduction:", round(mean(bp_diff), 2), "mmHg\n\n")

# Problem 4: Two-Sample Wilcoxon Rank-Sum Test
cat("PROBLEM 4: Two-Sample Wilcoxon Rank-Sum Test (Medications)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
med_a <- c(6, 7, 5, 8, 6, 7, 9)
med_b <- c(4, 5, 6, 5, 7, 4, 6)

cat("Medication A:", paste(med_a, collapse=", "), "\n")
cat("Medication B:", paste(med_b, collapse=", "), "\n")

result_ranksum <- wilcox.test(med_a, med_b)
cat("W statistic:", result_ranksum$statistic, "\n")
cat("P-value:", round(result_ranksum$p.value, 4), "\n")
cat("Conclusion: p =", round(result_ranksum$p.value, 4))
if(result_ranksum$p.value < 0.05) {
  cat(" < 0.05, medications differ significantly.\n")
} else {
  cat(" >= 0.05, no significant difference.\n")
}
cat("Median A:", median(med_a), ", Median B:", median(med_b), "\n\n")

# Problem 5: Kruskal-Wallis Test
cat("PROBLEM 5: Kruskal-Wallis Test (Sleep Medication)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
low_dose <- c(5.2, 6.1, 5.8, 6.3, 5.5)
medium_dose <- c(6.8, 7.2, 7.5, 6.9, 7.1)
high_dose <- c(7.8, 8.2, 8.5, 7.9, 8.1)

cat("Low dose:", paste(low_dose, collapse=", "), "\n")
cat("Medium dose:", paste(medium_dose, collapse=", "), "\n")
cat("High dose:", paste(high_dose, collapse=", "), "\n")

# Create data frame
sleep_data <- data.frame(
  hours = c(low_dose, medium_dose, high_dose),
  dose = factor(rep(c("Low", "Medium", "High"), each=5))
)

result_kw <- kruskal.test(hours ~ dose, data=sleep_data)
cat("H statistic:", round(result_kw$statistic, 4), "\n")
cat("P-value:", round(result_kw$p.value, 6), "\n")
cat("Conclusion: p =", round(result_kw$p.value, 6))
if(result_kw$p.value < 0.05) {
  cat(" < 0.05, dosages differ significantly.\n")
} else {
  cat(" >= 0.05, no significant difference.\n")
}
cat("Follow-up: Pairwise Wilcoxon tests with Bonferroni correction\n\n")

# Problem 6: Checking Normality (High Dose Group)
cat("PROBLEM 6: Checking Normality (High Dose Group)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
cat("High dose data:", paste(high_dose, collapse=", "), "\n")

result_shapiro <- shapiro.test(high_dose)
cat("Shapiro-Wilk W statistic:", round(result_shapiro$statistic, 4), "\n")
cat("Shapiro-Wilk p-value:", round(result_shapiro$p.value, 4), "\n")
cat("Conclusion: p =", round(result_shapiro$p.value, 4))
if(result_shapiro$p.value >= 0.05) {
  cat(" >= 0.05, data consistent with normality.\n")
} else {
  cat(" < 0.05, data not normal.\n")
}
cat("Small sample size (n=5) limits power of normality test.\n")
cat("Kruskal-Wallis was appropriate (nonparametric, no normality assumption).\n\n")

# Problem 7: Choosing the Right Test (Conceptual)
cat("PROBLEM 7: Choosing the Right Test (Conceptual)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
cat("Part A: Wilcoxon rank-sum (Mann-Whitney) - two groups, skewed data\n")
cat("Part B: Sign test or Wilcoxon signed-rank - one-sample, test median\n")
cat("Part C: One-way ANOVA - 4 groups, normal data\n")
cat("Part D: Wilcoxon signed-rank - paired data, ordinal scale\n\n")

cat(paste(rep("=", 70), collapse=""), "\n")
cat("ALL WORKSHEET ANSWERS VERIFIED\n")
cat(paste(rep("=", 70), collapse=""), "\n")
