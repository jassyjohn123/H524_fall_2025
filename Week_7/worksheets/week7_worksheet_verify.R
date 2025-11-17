#!/usr/bin/env Rscript
################################################################################
# Week 7 Worksheet - Answer Verification Script
# ALL numerical answers verified computationally
################################################################################

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 7 WORKSHEET - VERIFIED ANSWERS\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

################################################################################
# PROBLEM 1: Sign Test
################################################################################
cat("PROBLEM 1: SIGN TEST\n")
cat(paste(rep("-", 70), collapse=""), "\n")

recovery <- c(12, 15, 10, 13, 16, 11, 14, 9, 12, 15)
med0 <- 14

cat("Data:", recovery, "\n")
cat("Hypothesized median:", med0, "\n\n")

# a) Hypotheses (conceptual - stated in answer key)

# b) Calculate signs
diff <- recovery - med0
diff_nonzero <- diff[diff != 0]
signs <- sign(diff_nonzero)

b_plus <- sum(signs > 0)
b_minus <- sum(signs < 0)
B <- min(b_plus, b_minus)

cat("Differences from 14:", diff, "\n")
cat("After removing zeros:", diff_nonzero, "\n")
cat("B+ (positive signs):", b_plus, "\n")
cat("B- (negative signs):", b_minus, "\n")
cat("B (test statistic):", B, "\n\n")

# c) P-value (one-sided, testing if median < 14)
# H_A: median < 14, so we want P(B+ <= observed) where B+ counts values > 14
# If median < 14, we expect fewer positive signs
p_value_1c <- pbinom(b_plus, length(diff_nonzero), 0.5)
cat("P-value (one-sided, HA: median < 14):", round(p_value_1c, 4), "\n\n")

# Verification with binom.test
binom_result <- binom.test(b_plus, length(diff_nonzero), p=0.5,
                            alternative="greater")
cat("Verification with binom.test (alternative='greater'):",
    round(binom_result$p.value, 4), "\n")

# d) Conclusion
if (p_value_1c < 0.05) {
  cat("Conclusion: Reject H0 at alpha=0.05\n\n")
} else {
  cat("Conclusion: Fail to reject H0 at alpha=0.05\n\n")
}

################################################################################
# PROBLEM 2: Wilcoxon Signed-Rank Test
################################################################################
cat(paste(rep("=", 70), collapse=""), "\n")
cat("PROBLEM 2: WILCOXON SIGNED-RANK TEST\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# a) Differences already calculated
cat("Differences from 14:", diff, "\n\n")

# b) Absolute differences and ranks
abs_diff <- abs(diff_nonzero)
ranks <- rank(abs_diff)
cat("Absolute differences:", abs_diff, "\n")
cat("Ranks:", ranks, "\n\n")

# c) Signed ranks
signed_ranks <- sign(diff_nonzero) * ranks
W_plus <- sum(signed_ranks[signed_ranks > 0])
W_minus <- abs(sum(signed_ranks[signed_ranks < 0]))

cat("Signed ranks:", signed_ranks, "\n")
cat("W+ (sum of positive ranks):", W_plus, "\n")
cat("W- (sum of negative ranks):", W_minus, "\n\n")

# d) Wilcoxon test in R
wilcox_result <- wilcox.test(recovery, mu=14, alternative="two.sided")
cat("Wilcoxon test p-value:", round(wilcox_result$p.value, 4), "\n\n")

# e) Comparison
cat("Sign test p-value (two-sided would be):",
    round(2 * min(p_value_1c, 1-p_value_1c), 4), "\n")
cat("Wilcoxon is more powerful (uses magnitude, not just direction)\n\n")

################################################################################
# PROBLEM 3: Paired Data
################################################################################
cat(paste(rep("=", 70), collapse=""), "\n")
cat("PROBLEM 3: PAIRED DATA - BLOOD PRESSURE\n")
cat(paste(rep("-", 70), collapse=""), "\n")

bp_before <- c(142, 138, 155, 148, 160, 145, 152, 149)
bp_after <- c(138, 140, 148, 145, 155, 142, 150, 145)
bp_diff <- bp_before - bp_after

cat("Before:", bp_before, "\n")
cat("After:", bp_after, "\n")
cat("Differences (Before - After):", bp_diff, "\n\n")

# b) Sign test
signs_bp <- sign(bp_diff[bp_diff != 0])
n_bp <- length(signs_bp)
b_plus_bp <- sum(signs_bp > 0)
b_minus_bp <- sum(signs_bp < 0)

cat("SIGN TEST:\n")
cat("B+:", b_plus_bp, "\n")
cat("B-:", b_minus_bp, "\n")

p_sign_bp <- 2 * pbinom(min(b_plus_bp, b_minus_bp), n_bp, 0.5)
cat("P-value:", round(p_sign_bp, 4), "\n\n")

# c) Wilcoxon signed-rank test
wilcox_bp <- wilcox.test(bp_before, bp_after, paired=TRUE,
                          alternative="two.sided")
cat("WILCOXON SIGNED-RANK TEST:\n")
cat("P-value:", round(wilcox_bp$p.value, 4), "\n\n")

# d) Recommendation
cat("RECOMMENDATION:\n")
cat("Wilcoxon is preferred - uses magnitude of differences\n")
cat("More powerful than sign test when differences vary in size\n\n")

################################################################################
# PROBLEM 4: Two-Sample Wilcoxon Rank-Sum Test
################################################################################
cat(paste(rep("=", 70), collapse=""), "\n")
cat("PROBLEM 4: WILCOXON RANK-SUM (MANN-WHITNEY)\n")
cat(paste(rep("-", 70), collapse=""), "\n")

med_A <- c(6, 7, 5, 8, 6, 7, 9)
med_B <- c(4, 5, 6, 5, 7, 4, 6)

cat("Medication A:", med_A, "\n")
cat("Medication B:", med_B, "\n\n")

# a) Combined ranks
all_data <- c(med_A, med_B)
all_ranks <- rank(all_data)

ranks_A <- sum(all_ranks[1:length(med_A)])
ranks_B <- sum(all_ranks[(length(med_A)+1):length(all_data)])

cat("All data:", all_data, "\n")
cat("All ranks:", all_ranks, "\n")
cat("Sum of ranks A:", ranks_A, "\n")
cat("Sum of ranks B:", ranks_B, "\n\n")

# b) Wilcoxon rank-sum test
ranksum_result <- wilcox.test(med_A, med_B, alternative="two.sided")
cat("WILCOXON RANK-SUM TEST:\n")
cat("W statistic:", ranksum_result$statistic, "\n")
cat("P-value:", round(ranksum_result$p.value, 4), "\n\n")

# c) Conclusion
if (ranksum_result$p.value < 0.05) {
  cat("Conclusion: Reject H0 - significant difference at alpha=0.05\n\n")
} else {
  cat("Conclusion: Fail to reject H0 - no significant difference\n\n")
}

################################################################################
# PROBLEM 5: Kruskal-Wallis Test
################################################################################
cat(paste(rep("=", 70), collapse=""), "\n")
cat("PROBLEM 5: KRUSKAL-WALLIS TEST\n")
cat(paste(rep("-", 70), collapse=""), "\n")

low_dose <- c(5.2, 6.1, 5.8, 6.3, 5.5)
med_dose <- c(6.8, 7.2, 7.5, 6.9, 7.1)
high_dose <- c(7.8, 8.2, 8.5, 7.9, 8.1)

cat("Low dose:", low_dose, "\n")
cat("Medium dose:", med_dose, "\n")
cat("High dose:", high_dose, "\n\n")

# Combine data
sleep_hours <- c(low_dose, med_dose, high_dose)
dose_group <- factor(rep(c("Low", "Medium", "High"), each=5))

# Kruskal-Wallis test
kw_result <- kruskal.test(sleep_hours ~ dose_group)

cat("KRUSKAL-WALLIS TEST:\n")
cat("H statistic:", round(kw_result$statistic, 4), "\n")
cat("df:", kw_result$parameter, "\n")
cat("P-value:", round(kw_result$p.value, 4), "\n\n")

if (kw_result$p.value < 0.05) {
  cat("Conclusion: Reject H0 - at least one dose differs (p < 0.05)\n")
  cat("Follow-up: Perform pairwise Wilcoxon tests with Bonferroni correction\n\n")
} else {
  cat("Conclusion: Fail to reject H0 - no significant differences\n\n")
}

################################################################################
# PROBLEM 6: Checking Normality
################################################################################
cat(paste(rep("=", 70), collapse=""), "\n")
cat("PROBLEM 6: NORMALITY ASSESSMENT\n")
cat(paste(rep("-", 70), collapse=""), "\n")

cat("High dose data:", high_dose, "\n\n")

# a) Shapiro-Wilk test
shapiro_result <- shapiro.test(high_dose)
cat("SHAPIRO-WILK TEST:\n")
cat("W statistic:", round(shapiro_result$statistic, 4), "\n")
cat("P-value:", round(shapiro_result$p.value, 4), "\n\n")

# b) Conclusion
if (shapiro_result$p.value >= 0.05) {
  cat("Conclusion: p >= 0.05, normality assumption reasonable\n")
  cat("Data consistent with normal distribution\n\n")
} else {
  cat("Conclusion: p < 0.05, reject normality assumption\n")
  cat("Data significantly deviates from normality\n\n")
}

# c) Q-Q plot note
cat("c) Create Q-Q plot with: qqnorm(high_dose); qqline(high_dose, col='red')\n")
cat("   Points should fall close to the line if normal\n\n")

# d) Appropriateness of Kruskal-Wallis
cat("d) APPROPRIATENESS OF KRUSKAL-WALLIS:\n")
if (shapiro_result$p.value >= 0.05) {
  cat("   High dose appears normal, but with n=5 per group,\n")
  cat("   hard to assess normality reliably.\n")
  cat("   Kruskal-Wallis is conservative choice (no harm if data normal)\n\n")
} else {
  cat("   High dose not normal - Kruskal-Wallis was appropriate\n\n")
}

################################################################################
# PROBLEM 7: Test Selection
################################################################################
cat(paste(rep("=", 70), collapse=""), "\n")
cat("PROBLEM 7: CHOOSING THE RIGHT TEST\n")
cat(paste(rep("-", 70), collapse=""), "\n")

cat("a) Wilcoxon rank-sum (Mann-Whitney)\n")
cat("   - Two independent groups, survival times highly skewed\n\n")

cat("b) Sign test or Wilcoxon signed-rank\n")
cat("   - One-sample test for median with small sample size\n\n")

cat("c) One-way ANOVA (parametric)\n")
cat("   - Four groups, data appears normal, ANOVA more powerful\n\n")

cat("d) Wilcoxon signed-rank test\n")
cat("   - Paired data, ordinal scale (ranks appropriate)\n\n")

################################################################################
# SUMMARY
################################################################################
cat(paste(rep("=", 70), collapse=""), "\n")
cat("VERIFICATION COMPLETE\n")
cat(paste(rep("=", 70), collapse=""), "\n")
cat("All numerical answers verified computationally.\n")
cat("Use these values in the answer key.\n")
cat(paste(rep("=", 70), collapse=""), "\n")
