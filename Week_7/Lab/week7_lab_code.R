#!/usr/bin/env Rscript
# ==============================================================================
# H524 WEEK 7 LAB: NONPARAMETRIC METHODS
# Complete Code with Answers
# Fall 2025
# ==============================================================================
#
# This script contains all code from Week 7 Lab with expected outputs
# Use this to follow along in lab or for reference
#
# ==============================================================================

# ==============================================================================
# EXERCISE 1: SHAPIRO-WILK TEST
# ==============================================================================

cat("\n========== EXERCISE 1: SHAPIRO-WILK TEST ==========\n")

# Generate example data
set.seed(524)
normal_data <- rnorm(30, mean=100, sd=15)
skewed_data <- rexp(30, rate=0.02)

# Check normality
cat("\nNormal data - Shapiro-Wilk test:\n")
shapiro.test(normal_data)
# Expected p-value: 0.2371
# Interpretation: p >= 0.05, data is consistent with normal distribution

cat("\nSkewed data - Shapiro-Wilk test:\n")
shapiro.test(skewed_data)
# Expected p-value: 0.0025
# Interpretation: p < 0.05, data is NOT normally distributed

# Visual checks (optional)
# hist(normal_data, main="Normal Data", col="lightblue")
# hist(skewed_data, main="Skewed Data", col="lightcoral")
# qqnorm(normal_data, main="Normal Data Q-Q Plot")
# qqline(normal_data, col="red")
# qqnorm(skewed_data, main="Skewed Data Q-Q Plot")
# qqline(skewed_data, col="red")

cat("\nANSWERS:\n")
cat("1. P-value for normal_data: 0.2371\n")
cat("2. P-value for skewed_data: 0.0025\n")
cat("3. For normal_data, use PARAMETRIC tests (p >= 0.05)\n")
cat("4. For skewed_data, use NONPARAMETRIC tests (p < 0.05)\n")

# ==============================================================================
# EXERCISE 2: SIGN TEST FOR ONE SAMPLE
# ==============================================================================

cat("\n========== EXERCISE 2: SIGN TEST FOR ONE SAMPLE ==========\n")
cat("Question: Is median recovery time different from 7 days?\n\n")

# Recovery times (days)
recovery <- c(8, 5, 7, 10, 4, 9, 3, 12, 6, 11, 7)

# Hypothesized median
med0 <- 7

# Calculate differences
diff <- recovery - med0

# Count signs (ignoring zeros)
n_positive <- sum(diff > 0)
n_total <- sum(diff != 0)

cat("Positive differences:", n_positive, "\n")
cat("Total non-zero:", n_total, "\n")

# Sign test
binom.test(n_positive, n_total, p=0.5)
# Expected p-value: 1.0

cat("\nANSWERS:\n")
cat("1. Positive differences: 5\n")
cat("2. Total non-zero differences: 9\n")
cat("3. P-value: 1.0\n")
cat("4. Is median significantly different from 7 days? NO (p = 1.0 >= 0.05)\n")

# ==============================================================================
# EXERCISE 3: SIGN TEST FOR PAIRED DATA
# ==============================================================================

cat("\n========== EXERCISE 3: SIGN TEST FOR PAIRED DATA ==========\n")
cat("Question: Does treatment reduce pain scores?\n\n")

# Pain scores (1-10 scale)
before <- c(7, 8, 6, 9, 5, 8, 7, 6)
after <- c(5, 6, 4, 7, 4, 6, 5, 5)

# Calculate differences
diff <- before - after

# Count signs
n_improved <- sum(diff > 0)
n_total <- sum(diff != 0)

cat("Number improved:", n_improved, "\n")
cat("Number total:", n_total, "\n")

# Sign test
binom.test(n_improved, n_total, p=0.5)
# Expected p-value: 0.0078

# Summary
cat("\nSummary statistics:\n")
cat("Mean before:", mean(before), "\n")
cat("Mean after:", mean(after), "\n")
cat("Mean reduction:", mean(diff), "\n")

cat("\nANSWERS:\n")
cat("1. Number improved: 8\n")
cat("2. P-value: 0.0078\n")
cat("3. Does treatment reduce pain? YES (p = 0.0078 < 0.05)\n")
cat("4. Average reduction in pain score: 1.75\n")

before.bigger <- before + 5
# Calculate differences
diff.bigger <- before.bigger - after

# Count signs
n_improved.bigger <- sum(diff.bigger > 0)
n_total.bigger <- sum(diff.bigger != 0)

# Sign test
binom.test(n_improved.bigger, n_total.bigger, p=0.5) ## sample p-value
t.test(diff)
t.test(diff.bigger)



# ==============================================================================
# EXERCISE 4: BLOOD PRESSURE STUDY (WILCOXON PAIRED)
# ==============================================================================

cat("\n========== EXERCISE 4: BLOOD PRESSURE STUDY ==========\n")
cat("Research Question: Does medication reduce blood pressure?\n\n")

# Blood pressure before and after medication
bp_before <- c(145, 138, 150, 142, 156, 148, 140, 152)
bp_after <- c(138, 135, 142, 140, 148, 145, 138, 146)

# Check normality of differences
diff <- bp_before - bp_after
cat("Checking normality of differences:\n")
shapiro.test(diff)
# Expected p-value: 0.0711
# Interpretation: p >= 0.05 (borderline), normality assumption OK

# Wilcoxon signed-rank test (paired)
cat("\nWilcoxon signed-rank test:\n")
wilcox.test(bp_before, bp_after, paired=TRUE)
# Expected p-value: 0.0139

# Summary statistics
cat("\nSummary statistics:\n")
cat("Mean BP before:", mean(bp_before), "mmHg\n")
cat("Mean BP after:", mean(bp_after), "mmHg\n")
cat("Mean reduction:", mean(diff), "mmHg\n")

cat("\nANSWERS:\n")
cat("1. Shapiro-Wilk p-value for differences: 0.0711\n")
cat("   Normality assumption OK? YES (p >= 0.05, though borderline)\n")
cat("2. Wilcoxon test p-value: 0.0139\n")
cat("3. Significant at alpha = 0.05? YES (p < 0.05)\n")
cat("4. Does medication reduce BP? YES (p < 0.05, significant reduction)\n")
cat("5. Mean reduction in BP: 4.88 mmHg\n")

# ==============================================================================
# EXERCISE 5: PHYSICAL THERAPY STUDY (WILCOXON PAIRED)
# ==============================================================================

cat("\n========== EXERCISE 5: PHYSICAL THERAPY STUDY ==========\n")
cat("Question: Does physical therapy reduce pain scores?\n\n")

# Pain scores (0-10 scale) before and after 8 weeks PT
pain_before <- c(7, 8, 6, 9, 7, 8, 6, 7, 8, 9)
pain_after <- c(5, 6, 5, 7, 6, 7, 4, 6, 7, 8)

# Check normality
diff <- pain_before - pain_after
cat("Checking normality:\n")
shapiro.test(diff)
# Expected p-value: 0.0002

# Wilcoxon test
cat("\nWilcoxon test:\n")
wilcox.test(pain_before, pain_after, paired=TRUE)
# Expected p-value: 0.0046

# Medians
cat("\nMedian statistics:\n")
cat("Median before:", median(pain_before), "\n")
cat("Median after:", median(pain_after), "\n")
cat("Median reduction:", median(diff), "\n")

cat("\nANSWERS:\n")
cat("1. Are differences normally distributed? NO (p = 0.0002 < 0.05)\n")
cat("2. Wilcoxon p-value: 0.0046\n")
cat("3. Does PT significantly reduce pain? YES (p < 0.05)\n")
cat("4. Median reduction in pain score: 1\n")

# ==============================================================================
# EXERCISE 6: TREATMENT COMPARISON (WILCOXON RANK-SUM)
# ==============================================================================

cat("\n========== EXERCISE 6: TREATMENT COMPARISON ==========\n")
cat("Research Question: Do two treatments differ in recovery time?\n\n")

# Recovery times (days)
treatment_A <- c(23, 31, 25, 28, 30, 27, 29)
treatment_B <- c(18, 22, 20, 24, 19, 21, 23)

# Check normality
cat("Checking normality:\n")
cat("Treatment A:\n")
shapiro.test(treatment_A)
# Expected p-value: 0.8525
cat("Treatment B:\n")
shapiro.test(treatment_B)
# Expected p-value: 0.9493

# Visualize (optional)
# boxplot(treatment_A, treatment_B,
#         names=c("Treatment A", "Treatment B"),
#         ylab="Recovery Time (days)",
#         main="Recovery Time Comparison",
#         col=c("lightblue", "lightcoral"))

# Wilcoxon rank-sum test (independent samples)
cat("\nWilcoxon rank-sum test:\n")
wilcox.test(treatment_A, treatment_B)
# Expected p-value: 0.004

# Summary statistics
cat("\nSummary statistics:\n")
cat("Median Treatment A:", median(treatment_A), "days\n")
cat("Median Treatment B:", median(treatment_B), "days\n")

cat("\nANSWERS:\n")
cat("1. Treatment A normal? YES (p = 0.8525 >= 0.05)\n")
cat("   Treatment B normal? YES (p = 0.9493 >= 0.05)\n")
cat("   Note: Both are normal, but we can still use Wilcoxon as robust alternative\n")
cat("2. Wilcoxon rank-sum p-value: 0.004\n")
cat("3. Significant at alpha = 0.05? YES (p = 0.004 < 0.05)\n")
cat("4. Which treatment has shorter recovery? Treatment B (median 21 vs 28 days)\n")
cat("5. Median recovery times:\n")
cat("   - Treatment A: 28 days\n")
cat("   - Treatment B: 21 days\n")

# ==============================================================================
# EXERCISE 7: DRUG EFFECTIVENESS STUDY (WILCOXON RANK-SUM)
# ==============================================================================

cat("\n========== EXERCISE 7: DRUG EFFECTIVENESS STUDY ==========\n")
cat("Question: Do two drugs differ in effectiveness?\n\n")

# Symptom relief scores (higher = better)
drug_X <- c(45, 52, 48, 55, 50, 47, 53)
drug_Y <- c(38, 42, 40, 45, 39, 43, 41)

## Visualize (optional)
boxplot(drug_X, drug_Y,
        names=c("Drug X", "Drug Y"),
        ylab="Symptom Relief Score",
        col=c("lightgreen", "lightyellow"))

# Wilcoxon test
cat("Wilcoxon rank-sum test:\n")
wilcox.test(drug_X, drug_Y)
# Expected p-value: 0.0026

# Summary
cat("\nSummary statistics:\n")
cat("Mean Drug X:", mean(drug_X), "\n")
cat("Mean Drug Y:", mean(drug_Y), "\n")
cat("Median Drug X:", median(drug_X), "\n")
cat("Median Drug Y:", median(drug_Y), "\n")

cat("\nANSWERS:\n")
cat("1. Wilcoxon p-value: 0.0026\n")
cat("2. Which drug is more effective? Drug X (higher scores)\n")
cat("3. Difference in average scores: 50 - 41.14 = 8.86 points\n")

# ==============================================================================
# EXERCISE 8: PAIN RELIEF COMPARISON (KRUSKAL-WALLIS)
# ==============================================================================

cat("\n========== EXERCISE 8: PAIN RELIEF COMPARISON ==========\n")
cat("Research Question: Do three pain medications differ in effectiveness?\n\n")

# Pain relief scores (0-10 scale, higher = better)
drug_A <- c(3, 4, 5, 4, 3, 5, 4)
drug_B <- c(5, 6, 7, 6, 5, 7, 6)
drug_C <- c(7, 8, 9, 8, 7, 9, 8)

# Combine data
pain_scores <- c(drug_A, drug_B, drug_C)
drug <- factor(rep(c("A", "B", "C"), each=7))

# Check normality for each group (optional)
# shapiro.test(drug_A)
# shapiro.test(drug_B)
# shapiro.test(drug_C)

# Visualize (optional)
# boxplot(pain_scores ~ drug,
#         xlab="Drug",
#         ylab="Pain Relief Score",
#         main="Pain Relief by Drug",
#         col=c("lightblue", "lightgreen", "lightyellow"))

# Kruskal-Wallis test
cat("Kruskal-Wallis test:\n")
kruskal.test(pain_scores ~ drug)
# Expected p-value: 0.0002

# Post-hoc pairwise comparisons
cat("\nPost-hoc pairwise comparisons (Bonferroni-adjusted):\n")
pairwise.wilcox.test(pain_scores, drug, p.adjust.method="bonferroni")
# Expected p-values:
# A vs B: 0.0121
# A vs C: 0.0057
# B vs C: 0.0121

# Summary statistics
cat("\nMedian pain relief by drug:\n")
print(tapply(pain_scores, drug, median))

cat("\nANSWERS:\n")
cat("1. Kruskal-Wallis p-value: 0.0002\n")
cat("2. Significant overall at alpha = 0.05? YES (p < 0.05)\n")
cat("3. Post-hoc tests (Bonferroni-adjusted):\n")
cat("   - A vs B: p = 0.0121 (SIGNIFICANT)\n")
cat("   - A vs C: p = 0.0057 (SIGNIFICANT)\n")
cat("   - B vs C: p = 0.0121 (SIGNIFICANT)\n")
cat("   - All three drugs differ significantly from each other\n")
cat("4. Most effective drug: Drug C (median = 8)\n")
cat("5. Least effective drug: Drug A (median = 4)\n")

# ==============================================================================
# EXERCISE 9: COMPARING PARAMETRIC VS NONPARAMETRIC
# ==============================================================================

cat("\n========== EXERCISE 9: WHEN BOTH TESTS APPLY ==========\n")
cat("Sometimes data are borderline normal. Let's compare both approaches.\n\n")

# Blood pressure data (from Exercise 4)
bp_before <- c(145, 138, 150, 142, 156, 148, 140, 152)
bp_after <- c(138, 135, 142, 140, 148, 145, 138, 146)

# Check normality
diff <- bp_before - bp_after
cat("Checking normality:\n")
shapiro.test(diff)
# Expected p-value: 0.0711

# Parametric: Paired t-test
cat("\nParametric: Paired t-test\n")
t_result <- t.test(bp_before, bp_after, paired=TRUE)
cat("Paired t-test p-value:", t_result$p.value, "\n")
# Expected p-value: 0.0012

# Nonparametric: Wilcoxon
cat("\nNonparametric: Wilcoxon\n")
w_result <- wilcox.test(bp_before, bp_after, paired=TRUE)
cat("Wilcoxon p-value:", w_result$p.value, "\n")
# Expected p-value: 0.0139

# Compare
cat("\nBoth tests significant? Compare p-values to 0.05\n")

cat("\nANSWERS:\n")
cat("1. Is normality assumption met (p >= 0.05)? YES (borderline, p = 0.0711)\n")
cat("2. Which test gives smaller p-value? t-test (0.0012 vs 0.0139)\n")
cat("3. Do both reach same conclusion? YES (both significant, p < 0.05)\n")
cat("4. When borderline normal, which is safer? Nonparametric (more robust)\n")

# ==============================================================================
# PRACTICE PROBLEM 1: HOSPITAL STAY DURATION
# ==============================================================================

cat("\n========== PRACTICE PROBLEM 1: HOSPITAL STAY DURATION ==========\n")

# Hospital stay (days)
procedure_1 <- c(3, 4, 5, 3, 6, 4, 7, 5, 4, 12)
procedure_2 <- c(5, 6, 8, 7, 9, 6, 8, 10, 7, 15)

# Visualize (optional)
# boxplot(procedure_1, procedure_2,
#         names=c("Procedure 1", "Procedure 2"),
#         main="Hospital Stay Comparison",
#         ylab="Days",
#         col=c("lightblue", "lightcoral"))

# Check normality
cat("Checking normality:\n")
cat("Procedure 1:\n")
shapiro.test(procedure_1)
# Expected p-value: 0.0083
cat("Procedure 2:\n")
shapiro.test(procedure_2)
# Expected p-value: 0.0538

# Wilcoxon rank-sum test
cat("\nWilcoxon rank-sum test:\n")
wilcox.test(procedure_1, procedure_2)
# Expected p-value: 0.0108

# Summary statistics
cat("\nSummary statistics:\n")
cat("Median Procedure 1:", median(procedure_1), "days\n")
cat("Median Procedure 2:", median(procedure_2), "days\n")

cat("\nANSWERS:\n")
cat("1. Procedure 1 normal? NO (p = 0.0083 < 0.05)\n")
cat("   Procedure 2 normal? YES (p = 0.0538 >= 0.05, borderline)\n")
cat("   Since Procedure 1 is not normal, use nonparametric test\n")
cat("2. Wilcoxon rank-sum p-value: 0.0108\n")
cat("3. Significant difference? YES (p = 0.0108 < 0.05)\n")
cat("4. Shorter stays: Procedure 1 (median 4.5 days vs 7.5 days)\n")
cat("5. Why is Wilcoxon appropriate? Data not normal + outliers present (12, 15)\n")

# ==============================================================================
# PRACTICE PROBLEM 2: DIET PROGRAM COMPARISON
# ==============================================================================

cat("\n========== PRACTICE PROBLEM 2: DIET PROGRAM COMPARISON ==========\n")

# Weight loss (kg) after 3 months
diet_A <- c(2.1, 3.2, 2.5, 3.0, 2.8, 2.6)
diet_B <- c(3.5, 4.2, 3.8, 4.0, 3.9, 3.7)
diet_C <- c(4.5, 5.1, 4.8, 5.3, 4.9, 5.0)
diet_D <- c(2.8, 3.0, 2.9, 3.1, 2.7, 2.9)

# Combine data
weight_loss <- c(diet_A, diet_B, diet_C, diet_D)
diet <- factor(rep(c("A", "B", "C", "D"), each=6))

# Visualize (optional)
# boxplot(weight_loss ~ diet,
#         main="Weight Loss by Diet Program",
#         xlab="Diet",
#         ylab="Weight Loss (kg)",
#         col=c("lightblue", "lightgreen", "lightyellow", "lightcoral"))

# Kruskal-Wallis test
cat("Kruskal-Wallis test:\n")
kruskal.test(weight_loss ~ diet)
# Expected p-value: 0.000195

# Post-hoc tests
cat("\nPost-hoc pairwise comparisons (Bonferroni-adjusted):\n")
pairwise.wilcox.test(weight_loss, diet, p.adjust.method="bonferroni")
# Expected p-values:
# A vs B: 0.013 (SIGNIFICANT)
# A vs C: 0.013 (SIGNIFICANT)
# A vs D: 1.000 (NOT significant)
# B vs C: 0.013 (SIGNIFICANT)
# B vs D: 0.030 (SIGNIFICANT)
# C vs D: 0.030 (SIGNIFICANT)

# Summary statistics
cat("\nMedian weight loss by diet:\n")
print(tapply(weight_loss, diet, median))
cat("\nMean weight loss by diet:\n")
print(tapply(weight_loss, diet, mean))

cat("\nANSWERS:\n")
cat("1. Kruskal-Wallis p-value: 0.000195\n")
cat("2. Significant overall? YES (p < 0.05)\n")
cat("3. Significant pairs (p < 0.05):\n")
cat("   - A vs B: p = 0.013\n")
cat("   - A vs C: p = 0.013\n")
cat("   - B vs C: p = 0.013\n")
cat("   - B vs D: p = 0.030\n")
cat("   - C vs D: p = 0.030\n")
cat("   NOT significant: A vs D (p = 1.000)\n")
cat("4. Most effective diet: Diet C (median = 4.95 kg)\n")
cat("5. Median weight loss by diet:\n")
cat("   - Diet A: 2.7 kg\n")
cat("   - Diet B: 3.85 kg\n")
cat("   - Diet C: 4.95 kg\n")
cat("   - Diet D: 2.9 kg\n")

# ==============================================================================
# PRACTICE PROBLEM 3: SATISFACTION RATINGS (ORDINAL DATA)
# ==============================================================================

cat("\n========== PRACTICE PROBLEM 3: SATISFACTION RATINGS ==========\n")

# Satisfaction ratings (1-5 scale, ordinal)
store_A <- c(3, 4, 3, 5, 4, 3, 4, 3, 4, 3)
store_B <- c(4, 5, 4, 5, 5, 4, 5, 4, 5, 4)
store_C <- c(2, 3, 2, 4, 3, 2, 3, 2, 3, 3)

# Combine
satisfaction <- c(store_A, store_B, store_C)
store <- factor(rep(c("A", "B", "C"), each=10))

# Visualize (optional)
# boxplot(satisfaction ~ store,
#         main="Satisfaction by Store",
#         xlab="Store",
#         ylab="Satisfaction Rating (1-5)",
#         col=c("lightblue", "lightgreen", "lightyellow"))

# Kruskal-Wallis (appropriate for ordinal data!)
cat("Kruskal-Wallis test:\n")
kruskal.test(satisfaction ~ store)
# Expected p-value: 0.0002

# Post-hoc
cat("\nPost-hoc pairwise comparisons (Bonferroni-adjusted):\n")
pairwise.wilcox.test(satisfaction, store, p.adjust.method="bonferroni")
# Expected p-values:
# A vs B: 0.028
# A vs C: 0.042
# B vs C: 0.0007

# Medians
cat("\nMedian satisfaction by store:\n")
print(tapply(satisfaction, store, median))

cat("\nANSWERS:\n")
cat("1. Why is nonparametric appropriate? Data is ORDINAL (1-5 rating scale)\n")
cat("2. Kruskal-Wallis p-value: 0.0002\n")
cat("3. Do stores differ in satisfaction? YES (p < 0.05)\n")
cat("4. Highest satisfaction: Store B (median = 4.5)\n")
cat("5. Significant pairs:\n")
cat("   - A vs B: p = 0.028 (SIGNIFICANT)\n")
cat("   - A vs C: p = 0.042 (SIGNIFICANT)\n")
cat("   - B vs C: p = 0.0007 (SIGNIFICANT)\n")

# ==============================================================================
# KEY CONCEPTS AND INTERPRETATIONS
# ==============================================================================

cat("\n========== KEY CONCEPTS ==========\n\n")

cat("NORMALITY TESTING:\n")
cat("- If Shapiro-Wilk p >= 0.05: Data consistent with normal distribution\n")
cat("- If Shapiro-Wilk p < 0.05: Data significantly non-normal\n")
cat("- Borderline cases (p ~ 0.05): Use nonparametric for safety\n\n")

cat("WILCOXON TESTS:\n")
cat("- PAIRED: Use for before/after measurements on same subjects\n")
cat("- RANK-SUM: Use for comparing two independent groups\n")
cat("- Interpret p-values same as t-tests: p < 0.05 = significant\n\n")

cat("KRUSKAL-WALLIS TEST:\n")
cat("- Tests if at least one group differs from others\n")
cat("- If significant (p < 0.05), follow up with post-hoc pairwise tests\n")
cat("- Bonferroni correction adjusts for multiple comparisons\n\n")

cat("COMMON ERRORS TO AVOID:\n")
cat("1. Forgetting to check normality first\n")
cat("2. Using paired=TRUE for independent groups\n")
cat("3. Interpreting medians as means\n")
cat("4. Not following up significant Kruskal-Wallis with post-hoc tests\n")
cat("5. Comparing p-values to 0.01 instead of 0.05\n\n")

cat("========== END OF LAB CODE ==========\n")
