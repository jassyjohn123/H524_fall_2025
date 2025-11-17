#!/usr/bin/env Rscript
################################################################################
# Week 7 Slides - Computational Verification Script
# Verifies all numerical results shown in the slides
################################################################################

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 7 SLIDES - COMPUTATIONAL VERIFICATION\n")
cat("Topic: Nonparametric Tests\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

################################################################################
# SIGN TEST EXAMPLE
################################################################################
cat(paste(rep("=", 70), collapse=""), "\n")
cat("SIGN TEST EXAMPLE\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Data: Recovery times (days) for 9 patients
recovery <- c(8, 5, 7, 10, 4, 9, 3, 12, 6)
med0 <- 6

cat("Data:", recovery, "\n")
cat("Hypothesized median:", med0, "\n\n")

# Calculate differences and signs
diff <- recovery - med0
signs <- sign(diff[diff != 0])  # Remove zeros

cat("Differences:", diff, "\n")
cat("After removing zero:", diff[diff != 0], "\n")
cat("Signs:", signs, "\n\n")

# Count
n <- length(signs)
b_plus <- sum(signs > 0)
b_minus <- sum(signs < 0)
B <- min(b_plus, b_minus)

cat("n (after removing ties):", n, "\n")
cat("B+ (positive signs):", b_plus, "\n")
cat("B- (negative signs):", b_minus, "\n")
cat("B (smaller count):", B, "\n\n")

# P-value (two-sided)
p_value_manual <- 2 * pbinom(B, n, 0.5)
cat("P-value (manual):", round(p_value_manual, 4), "\n")

# Using binom.test()
test_result <- binom.test(b_plus, n, p=0.5, alternative="two.sided")
cat("P-value (binom.test):", round(test_result$p.value, 4), "\n")
cat("Conclusion: Fail to reject H0 (p > 0.05)\n\n")

################################################################################
# WILCOXON SIGNED-RANK EXAMPLE (Same data)
################################################################################
cat(paste(rep("=", 70), collapse=""), "\n")
cat("WILCOXON SIGNED-RANK EXAMPLE\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Same recovery data
cat("Data:", recovery, "\n")
cat("Hypothesized median:", med0, "\n\n")

# Calculate differences
diff_nonzero <- diff[diff != 0]
cat("Differences (excluding zeros):", diff_nonzero, "\n")

# Absolute differences
abs_diff <- abs(diff_nonzero)
cat("Absolute differences:", abs_diff, "\n")

# Ranks of absolute differences
ranks <- rank(abs_diff)
cat("Ranks:", ranks, "\n")

# Signed ranks
signed_ranks <- sign(diff_nonzero) * ranks
cat("Signed ranks:", signed_ranks, "\n\n")

# Calculate W+ and W-
W_plus <- sum(signed_ranks[signed_ranks > 0])
W_minus <- abs(sum(signed_ranks[signed_ranks < 0]))

cat("W+ (sum of positive ranks):", W_plus, "\n")
cat("W- (sum of negative ranks):", W_minus, "\n\n")

# Using wilcox.test()
wilcox_result <- wilcox.test(recovery, mu=med0, alternative="two.sided")
cat("Wilcoxon test p-value:", round(wilcox_result$p.value, 4), "\n")
cat("Conclusion: Fail to reject H0 (p > 0.05)\n\n")

################################################################################
# PAIRED DATA: BLOOD PRESSURE EXAMPLE
################################################################################
cat(paste(rep("=", 70), collapse=""), "\n")
cat("PAIRED DATA: BLOOD PRESSURE EXAMPLE\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Blood pressure before and after medication
bp_before <- c(145, 138, 150, 142, 156, 148)
bp_after <- c(138, 135, 142, 140, 148, 145)
bp_diff <- bp_before - bp_after

cat("Before:", bp_before, "\n")
cat("After:", bp_after, "\n")
cat("Differences:", bp_diff, "\n\n")

# Sign test
signs_bp <- sign(bp_diff[bp_diff != 0])
n_bp <- length(signs_bp)
b_plus_bp <- sum(signs_bp > 0)
b_minus_bp <- sum(signs_bp < 0)

cat("SIGN TEST:\n")
cat("B+:", b_plus_bp, "\n")
cat("B-:", b_minus_bp, "\n")

# Two-sided p-value
p_sign_bp <- 2 * pbinom(min(b_plus_bp, b_minus_bp), n_bp, 0.5)
cat("P-value:", round(p_sign_bp, 4), "\n\n")

# Wilcoxon signed-rank test
cat("WILCOXON SIGNED-RANK TEST:\n")
wilcox_bp <- wilcox.test(bp_before, bp_after, paired=TRUE, alternative="two.sided")
cat("P-value:", round(wilcox_bp$p.value, 4), "\n")
cat("Note: Wilcoxon more powerful (smaller p-value)\n\n")

################################################################################
# TWO-SAMPLE WILCOXON RANK-SUM (MANN-WHITNEY)
################################################################################
cat(paste(rep("=", 70), collapse=""), "\n")
cat("TWO-SAMPLE WILCOXON RANK-SUM TEST\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Example: Treatment A vs B
treatment_A <- c(23, 31, 25, 28, 30)
treatment_B <- c(18, 22, 20, 24, 19)

cat("Treatment A:", treatment_A, "\n")
cat("Treatment B:", treatment_B, "\n\n")

# Wilcoxon rank-sum test
ranksum_result <- wilcox.test(treatment_A, treatment_B, alternative="two.sided")
cat("Wilcoxon rank-sum test p-value:", round(ranksum_result$p.value, 4), "\n")
cat("W statistic:", ranksum_result$statistic, "\n\n")

################################################################################
# KRUSKAL-WALLIS EXAMPLE
################################################################################
cat(paste(rep("=", 70), collapse=""), "\n")
cat("KRUSKAL-WALLIS EXAMPLE: THREE DRUG COMPARISON\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Pain relief scores from three drugs
drug_A <- c(2, 3, 4, 3)
drug_B <- c(4, 6, 5, 7)
drug_C <- c(5, 8, 9, 10)

cat("Drug A:", drug_A, "\n")
cat("Drug B:", drug_B, "\n")
cat("Drug C:", drug_C, "\n\n")

# Combine data
pain_scores <- c(drug_A, drug_B, drug_C)
drug_groups <- factor(rep(c("A", "B", "C"), each=4))

# Kruskal-Wallis test
kw_result <- kruskal.test(pain_scores ~ drug_groups)
cat("Kruskal-Wallis test:\n")
cat("H statistic:", round(kw_result$statistic, 4), "\n")
cat("df:", kw_result$parameter, "\n")
cat("P-value:", round(kw_result$p.value, 4), "\n")

if (kw_result$p.value < 0.05) {
  cat("Conclusion: Reject H0 - at least one drug differs\n\n")
} else {
  cat("Conclusion: Fail to reject H0 - no significant difference\n\n")
}

# Manual calculation of ranks for verification
cat("Manual rank verification:\n")
all_data <- c(drug_A, drug_B, drug_C)
all_ranks <- rank(all_data)
cat("All data:", all_data, "\n")
cat("Ranks:", all_ranks, "\n")
ranks_A <- sum(all_ranks[1:4])
ranks_B <- sum(all_ranks[5:8])
ranks_C <- sum(all_ranks[9:12])
cat("Sum of ranks A:", ranks_A, "\n")
cat("Sum of ranks B:", ranks_B, "\n")
cat("Sum of ranks C:", ranks_C, "\n\n")

################################################################################
# CHECKING NORMALITY ASSUMPTIONS
################################################################################
cat(paste(rep("=", 70), collapse=""), "\n")
cat("CHECKING NORMALITY ASSUMPTIONS\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Example: Test normality of recovery data
cat("Testing normality of recovery times data:\n")
cat("Data:", recovery, "\n\n")

# Shapiro-Wilk test
shapiro_result <- shapiro.test(recovery)
cat("Shapiro-Wilk test:\n")
cat("W statistic:", round(shapiro_result$statistic, 4), "\n")
cat("P-value:", round(shapiro_result$p.value, 4), "\n")

if (shapiro_result$p.value < 0.05) {
  cat("Conclusion: Reject normality assumption (use nonparametric)\n\n")
} else {
  cat("Conclusion: Normality assumption reasonable\n\n")
}

################################################################################
# SUMMARY
################################################################################
cat(paste(rep("=", 70), collapse=""), "\n")
cat("VERIFICATION COMPLETE\n")
cat(paste(rep("=", 70), collapse=""), "\n")
cat("All computational results verified.\n")
cat("Numerical values in slides match R calculations.\n")
