#!/usr/bin/env Rscript
################################################################################
# Week 7 Lab - Answer Verification Script
# All numerical answers verified with R
# Run this script to compute correct answers for answer key
################################################################################

cat("\n")
cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 7 LAB - VERIFIED ANSWERS\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

################################################################################
# EXERCISE 1: SHAPIRO-WILK TEST
################################################################################
cat("EXERCISE 1: SHAPIRO-WILK TEST\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Generate example data
set.seed(524)
normal_data <- rnorm(30, mean=100, sd=15)
skewed_data <- rexp(30, rate=0.02)

# Check normality
result_normal <- shapiro.test(normal_data)
result_skewed <- shapiro.test(skewed_data)

cat("Q1: P-value for normal_data:", round(result_normal$p.value, 4), "\n")
cat("Q2: P-value for skewed_data:", round(result_skewed$p.value, 4), "\n")
cat("Q3: For normal_data, use parametric (p >= 0.05)\n")
cat("Q4: For skewed_data, use nonparametric (p < 0.05)\n\n")

################################################################################
# EXERCISE 2: BLOOD PRESSURE STUDY (WILCOXON PAIRED)
################################################################################
cat("EXERCISE 2: BLOOD PRESSURE STUDY\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Blood pressure before and after medication
bp_before <- c(145, 138, 150, 142, 156, 148, 140, 152)
bp_after <- c(138, 135, 142, 140, 148, 145, 138, 146)

# Check normality of differences
diff <- bp_before - bp_after
result_shapiro_diff <- shapiro.test(diff)

# Wilcoxon signed-rank test
result_wilcox <- wilcox.test(bp_before, bp_after, paired=TRUE)

# Summary statistics
mean_before <- mean(bp_before)
mean_after <- mean(bp_after)
mean_reduction <- mean(diff)

cat("Q1: Shapiro-Wilk p-value for differences:", round(result_shapiro_diff$p.value, 4), "\n")
if (result_shapiro_diff$p.value >= 0.05) {
  cat("    Normality assumption is OK\n")
} else {
  cat("    Normality assumption is violated\n")
}
cat("Q2: Wilcoxon test p-value:", round(result_wilcox$p.value, 4), "\n")
cat("Q3: Significant at alpha=0.05?", ifelse(result_wilcox$p.value < 0.05, "YES", "NO"), "\n")
cat("Q4: Does medication reduce BP?", ifelse(result_wilcox$p.value < 0.05 & mean_reduction > 0, "YES", "NO"), "\n")
cat("Q5: Mean reduction in BP:", round(mean_reduction, 2), "mmHg\n\n")

################################################################################
# EXERCISE 3: TREATMENT COMPARISON (WILCOXON RANK-SUM)
################################################################################
cat("EXERCISE 3: TREATMENT COMPARISON\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Recovery times (days)
treatment_A <- c(23, 31, 25, 28, 30, 27, 29)
treatment_B <- c(18, 22, 20, 24, 19, 21, 23)

# Check normality
result_shapiro_A <- shapiro.test(treatment_A)
result_shapiro_B <- shapiro.test(treatment_B)

# Wilcoxon rank-sum test
result_ranksum <- wilcox.test(treatment_A, treatment_B)

# Summary statistics
median_A <- median(treatment_A)
median_B <- median(treatment_B)

cat("Q1: Treatment A normal?", ifelse(result_shapiro_A$p.value >= 0.05, "YES (p>=0.05)", "NO (p<0.05)"),
    " - p =", round(result_shapiro_A$p.value, 4), "\n")
cat("    Treatment B normal?", ifelse(result_shapiro_B$p.value >= 0.05, "YES (p>=0.05)", "NO (p<0.05)"),
    " - p =", round(result_shapiro_B$p.value, 4), "\n")
cat("Q2: Wilcoxon rank-sum p-value:", round(result_ranksum$p.value, 4), "\n")
cat("Q3: Significant at alpha=0.05?", ifelse(result_ranksum$p.value < 0.05, "YES", "NO"), "\n")
cat("Q4: Which treatment has shorter recovery?", ifelse(median_B < median_A, "Treatment B", "Treatment A"), "\n")
cat("Q5: Median recovery time A:", median_A, "days\n")
cat("    Median recovery time B:", median_B, "days\n\n")

################################################################################
# EXERCISE 4: PAIN RELIEF COMPARISON (KRUSKAL-WALLIS)
################################################################################
cat("EXERCISE 4: PAIN RELIEF COMPARISON\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Pain relief scores (0-10 scale, higher = better)
drug_A <- c(3, 4, 5, 4, 3, 5, 4)
drug_B <- c(5, 6, 7, 6, 5, 7, 6)
drug_C <- c(7, 8, 9, 8, 7, 9, 8)

# Combine data
pain_scores <- c(drug_A, drug_B, drug_C)
drug <- factor(rep(c("A", "B", "C"), each=7))

# Kruskal-Wallis test
result_kw <- kruskal.test(pain_scores ~ drug)

# Post-hoc pairwise comparisons
result_posthoc <- pairwise.wilcox.test(pain_scores, drug, p.adjust.method="bonferroni")

# Summary statistics
medians <- tapply(pain_scores, drug, median)

cat("Q1: Kruskal-Wallis p-value:", round(result_kw$p.value, 4), "\n")
cat("Q2: Significant overall at alpha=0.05?", ifelse(result_kw$p.value < 0.05, "YES", "NO"), "\n")
cat("Q3: Post-hoc pairwise comparisons (Bonferroni-adjusted):\n")
cat("    A vs B: p =", round(result_posthoc$p.value[1,1], 4),
    ifelse(result_posthoc$p.value[1,1] < 0.05, " (SIGNIFICANT)", " (not significant)"), "\n")
cat("    A vs C: p =", round(result_posthoc$p.value[2,1], 4),
    ifelse(result_posthoc$p.value[2,1] < 0.05, " (SIGNIFICANT)", " (not significant)"), "\n")
cat("    B vs C: p =", round(result_posthoc$p.value[2,2], 4),
    ifelse(result_posthoc$p.value[2,2] < 0.05, " (SIGNIFICANT)", " (not significant)"), "\n")
cat("Q4: Most effective drug:", names(which.max(medians)), "(median =", max(medians), ")\n")
cat("Q5: Least effective drug:", names(which.min(medians)), "(median =", min(medians), ")\n\n")

################################################################################
# PRACTICE PROBLEM 1: HOSPITAL STAY DURATION
################################################################################
cat("PRACTICE PROBLEM 1: HOSPITAL STAY DURATION\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Hospital stay (days)
procedure_1 <- c(3, 4, 5, 3, 6, 4, 7, 5, 4, 12)
procedure_2 <- c(5, 6, 8, 7, 9, 6, 8, 10, 7, 15)

# Check normality
result_shapiro_p1 <- shapiro.test(procedure_1)
result_shapiro_p2 <- shapiro.test(procedure_2)

# Wilcoxon rank-sum test
result_proc <- wilcox.test(procedure_1, procedure_2)

# Summary statistics
median_p1 <- median(procedure_1)
median_p2 <- median(procedure_2)

cat("Q1: Procedure 1 normal?", ifelse(result_shapiro_p1$p.value >= 0.05, "YES", "NO"),
    " - p =", round(result_shapiro_p1$p.value, 4), "\n")
cat("    Procedure 2 normal?", ifelse(result_shapiro_p2$p.value >= 0.05, "YES", "NO"),
    " - p =", round(result_shapiro_p2$p.value, 4), "\n")
cat("Q2: Wilcoxon rank-sum p-value:", round(result_proc$p.value, 4), "\n")
cat("Q3: Significant difference?", ifelse(result_proc$p.value < 0.05, "YES", "NO"), "\n")
cat("Q4: Shorter stays:", ifelse(median_p1 < median_p2, "Procedure 1", "Procedure 2"), "\n")
cat("    Median Procedure 1:", median_p1, "days\n")
cat("    Median Procedure 2:", median_p2, "days\n\n")

################################################################################
# PRACTICE PROBLEM 2: DIET PROGRAM COMPARISON
################################################################################
cat("PRACTICE PROBLEM 2: DIET PROGRAM COMPARISON\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Weight loss (kg) after 3 months
diet_A <- c(2.1, 3.2, 2.5, 3.0, 2.8, 2.6)
diet_B <- c(3.5, 4.2, 3.8, 4.0, 3.9, 3.7)
diet_C <- c(4.5, 5.1, 4.8, 5.3, 4.9, 5.0)
diet_D <- c(2.8, 3.0, 2.9, 3.1, 2.7, 2.9)

# Combine data
weight_loss <- c(diet_A, diet_B, diet_C, diet_D)
diet <- factor(rep(c("A", "B", "C", "D"), each=6))

# Kruskal-Wallis test
result_kw_diet <- kruskal.test(weight_loss ~ diet)

# Post-hoc tests
result_posthoc_diet <- pairwise.wilcox.test(weight_loss, diet, p.adjust.method="bonferroni")

# Summary statistics
medians_diet <- tapply(weight_loss, diet, median)
means_diet <- tapply(weight_loss, diet, mean)

cat("Q1: Kruskal-Wallis p-value:", round(result_kw_diet$p.value, 6), "\n")
cat("Q2: Significant overall?", ifelse(result_kw_diet$p.value < 0.05, "YES", "NO"), "\n")
cat("Q3: Post-hoc pairwise comparisons (Bonferroni-adjusted):\n")
cat("    A vs B: p =", round(result_posthoc_diet$p.value[1,1], 4),
    ifelse(result_posthoc_diet$p.value[1,1] < 0.05, " (SIGNIFICANT)", " (not significant)"), "\n")
cat("    A vs C: p =", round(result_posthoc_diet$p.value[2,1], 6),
    ifelse(result_posthoc_diet$p.value[2,1] < 0.05, " (SIGNIFICANT)", " (not significant)"), "\n")
cat("    A vs D: p =", round(result_posthoc_diet$p.value[3,1], 4),
    ifelse(result_posthoc_diet$p.value[3,1] < 0.05, " (SIGNIFICANT)", " (not significant)"), "\n")
cat("    B vs C: p =", round(result_posthoc_diet$p.value[2,2], 4),
    ifelse(result_posthoc_diet$p.value[2,2] < 0.05, " (SIGNIFICANT)", " (not significant)"), "\n")
cat("    B vs D: p =", round(result_posthoc_diet$p.value[3,2], 4),
    ifelse(result_posthoc_diet$p.value[3,2] < 0.05, " (SIGNIFICANT)", " (not significant)"), "\n")
cat("    C vs D: p =", round(result_posthoc_diet$p.value[3,3], 6),
    ifelse(result_posthoc_diet$p.value[3,3] < 0.05, " (SIGNIFICANT)", " (not significant)"), "\n")
cat("Q4: Most effective diet:", names(which.max(medians_diet)), "(median =", max(medians_diet), "kg)\n")
cat("Q5: Median weight loss by diet:\n")
for (i in 1:length(medians_diet)) {
  cat("    Diet", names(medians_diet)[i], ":", medians_diet[i], "kg\n")
}

cat("\n")
cat(paste(rep("=", 70), collapse=""), "\n")
cat("ALL ANSWERS VERIFIED\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")
