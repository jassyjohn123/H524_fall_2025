#!/usr/bin/env Rscript
################################################################################
# Week 7 Slides - R Code Examples
# Topic: Nonparametric Tests
#
# This file contains all R code examples shown in the Week 7 slides.
# You can run these examples to reproduce the results shown in lecture.
#
# Focus: Simple, straightforward function calls (no manual calculations)
################################################################################

cat("\n")
cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 7: NONPARAMETRIC TESTS - CODE EXAMPLES\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

################################################################################
# SIGN TEST EXAMPLE
################################################################################
cat("SIGN TEST EXAMPLE\n")
cat(paste(rep("-", 70), collapse=""), "\n")
cat("Question: Is median recovery time different from 6 days?\n\n")

# Data: Recovery times (days) for 9 patients
recovery <- c(8, 5, 7, 10, 4, 9, 3, 12, 6)

# Calculate differences from hypothesized median
diff <- recovery - 6

# Count positive differences (ignoring zeros)
n_positive <- sum(diff > 0)
n_total <- sum(diff != 0)

# Sign test
result_sign <- binom.test(n_positive, n_total, p=0.5)
cat("Sign Test p-value:", round(result_sign$p.value, 4), "\n")
cat("Interpretation: p > 0.05, no evidence median differs from 6 days\n\n")

################################################################################
# WILCOXON SIGNED-RANK TEST (ONE SAMPLE)
################################################################################
cat("WILCOXON SIGNED-RANK TEST (One Sample)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
cat("Same question: Is median recovery time different from 6 days?\n\n")

# Same data
recovery <- c(8, 5, 7, 10, 4, 9, 3, 12, 6)

# Wilcoxon signed-rank test
result_wilcox <- wilcox.test(recovery, mu=6)
cat("Wilcoxon p-value:", round(result_wilcox$p.value, 4), "\n")
cat("Interpretation: p > 0.05, no evidence median differs from 6\n\n")

cat("Compare to sign test:\n")
cat("  Sign test p-value:    0.7266\n")
cat("  Wilcoxon p-value:     0.3252\n")
cat("  Both lead to same conclusion, but Wilcoxon more powerful\n\n")

################################################################################
# WILCOXON SIGNED-RANK TEST (PAIRED DATA)
################################################################################
cat("WILCOXON SIGNED-RANK TEST (Paired Data)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
cat("Question: Does medication reduce blood pressure?\n\n")

# Blood pressure before and after medication
bp_before <- c(145, 138, 150, 142, 156, 148)
bp_after <- c(138, 135, 142, 140, 148, 145)

# Paired Wilcoxon test
result_bp <- wilcox.test(bp_before, bp_after, paired=TRUE)
cat("Wilcoxon paired p-value:", round(result_bp$p.value, 4), "\n")
cat("Interpretation: p < 0.05, medication DOES reduce BP significantly\n\n")

################################################################################
# WILCOXON RANK-SUM TEST (TWO INDEPENDENT GROUPS)
################################################################################
cat("WILCOXON RANK-SUM TEST (Two Independent Groups)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
cat("Question: Do Treatment A and B differ in response time?\n\n")

# Data: Treatment response times
treatment_A <- c(23, 31, 25, 28, 30)
treatment_B <- c(18, 22, 20, 24, 19)

# Wilcoxon rank-sum test (also called Mann-Whitney U test)
result_ranksum <- wilcox.test(treatment_A, treatment_B)
cat("Wilcoxon rank-sum p-value:", round(result_ranksum$p.value, 4), "\n")
cat("Interpretation: p < 0.05, treatments DO differ significantly\n")
cat("Treatment A has HIGHER response times than B\n\n")

################################################################################
# KRUSKAL-WALLIS TEST (THREE OR MORE GROUPS)
################################################################################
cat("KRUSKAL-WALLIS TEST (Three or More Groups)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
cat("Question: Do three drugs differ in pain relief?\n\n")

# Pain relief scores from three drugs
pain <- c(2, 3, 4, 3,     # Drug A
          4, 6, 5, 7,     # Drug B
          5, 8, 9, 10)    # Drug C

drug <- factor(rep(c("A", "B", "C"), each=4))

# Kruskal-Wallis test
result_kw <- kruskal.test(pain ~ drug)
cat("Kruskal-Wallis p-value:", round(result_kw$p.value, 4), "\n")
cat("Interpretation: p < 0.05, at least one drug differs\n")
cat("Next step: Post-hoc tests to see which pairs differ\n\n")

################################################################################
# POST-HOC TESTS AFTER KRUSKAL-WALLIS
################################################################################
cat("POST-HOC TESTS (Pairwise Comparisons)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
cat("If Kruskal-Wallis is significant, do pairwise comparisons:\n\n")

# Pairwise Wilcoxon tests with Bonferroni correction
result_posthoc <- pairwise.wilcox.test(pain, drug, p.adjust.method="bonferroni")
cat("Pairwise comparison p-values:\n")
print(result_posthoc)
cat("\nInterpretation: Compare each p-value to 0.05 to see which pairs differ\n\n")

################################################################################
# CHECKING NORMALITY ASSUMPTIONS
################################################################################
cat("CHECKING NORMALITY ASSUMPTIONS\n")
cat(paste(rep("-", 70), collapse=""), "\n")
cat("Always check normality before choosing parametric vs nonparametric\n\n")

# Test the recovery times data
result_shapiro <- shapiro.test(recovery)
cat("Shapiro-Wilk test p-value:", round(result_shapiro$p.value, 4), "\n")
cat("\nInterpretation:\n")
cat("  If p >= 0.05: Normality assumption reasonable\n")
cat("                -> Use parametric test (t-test, ANOVA)\n")
cat("  If p < 0.05:  Not normal\n")
cat("                -> Use nonparametric test\n\n")

################################################################################
# COMPARING PARAMETRIC VS. NONPARAMETRIC TESTS
################################################################################
cat("COMPARING PARAMETRIC VS. NONPARAMETRIC\n")
cat(paste(rep("-", 70), collapse=""), "\n")
cat("Example: Blood pressure data\n\n")

# Parametric: Paired t-test
result_t <- t.test(bp_before, bp_after, paired=TRUE)
cat("Paired t-test p-value:", round(result_t$p.value, 4), "\n")

# Nonparametric: Wilcoxon signed-rank
result_wilcox_bp <- wilcox.test(bp_before, bp_after, paired=TRUE)
cat("Wilcoxon p-value:      ", round(result_wilcox_bp$p.value, 4), "\n\n")

cat("Note: If data is normal, t-test has more power (smaller p-value)\n")
cat("      If data is not normal, use Wilcoxon\n\n")

################################################################################
# DECISION GUIDE: WHICH TEST TO USE?
################################################################################
cat("DECISION GUIDE: WHICH TEST TO USE?\n")
cat(paste(rep("-", 70), collapse=""), "\n")
cat("\n")
cat("STEP 1: Check normality\n")
cat("  - Visual: hist(), qqnorm(), boxplot()\n")
cat("  - Statistical: shapiro.test()\n")
cat("  - If p > 0.05: Normal OK\n")
cat("  - If p < 0.05: Use nonparametric\n\n")

cat("STEP 2: Choose test based on design\n\n")
cat("One sample or paired data:\n")
cat("  - Normal:     t-test or paired t-test\n")
cat("  - Not normal: wilcox.test()\n\n")

cat("Two independent groups:\n")
cat("  - Normal:     Two-sample t-test\n")
cat("  - Not normal: wilcox.test(group1, group2)\n\n")

cat("Three or more groups:\n")
cat("  - Normal:     One-way ANOVA\n")
cat("  - Not normal: kruskal.test()\n\n")

################################################################################
# QUICK REFERENCE CARD
################################################################################
cat("QUICK REFERENCE: R FUNCTIONS\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")
cat("Sign test:              binom.test(n_pos, n_total, p=0.5)\n")
cat("Wilcoxon (one sample):  wilcox.test(data, mu=value)\n")
cat("Wilcoxon (paired):      wilcox.test(x, y, paired=TRUE)\n")
cat("Wilcoxon (rank-sum):    wilcox.test(group1, group2)\n")
cat("Kruskal-Wallis:         kruskal.test(outcome ~ group)\n")
cat("Post-hoc tests:         pairwise.wilcox.test(outcome, group)\n")
cat("Check normality:        shapiro.test(data)\n\n")

cat("Interpretation (always the same):\n")
cat("  - If p < 0.05:  Significant difference\n")
cat("  - If p >= 0.05: No significant difference\n\n")

################################################################################
# END OF CODE EXAMPLES
################################################################################
cat(paste(rep("=", 70), collapse=""), "\n")
cat("ALL EXAMPLES COMPLETED\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")
