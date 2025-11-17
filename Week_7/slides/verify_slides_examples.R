#!/usr/bin/env Rscript
# Verification script for ALL numerical examples in Week 7 slides
# Ensures every p-value and statistic in slides is computationally correct

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 7 SLIDES - VERIFY ALL NUMERICAL EXAMPLES\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

# SIGN TEST EXAMPLES
cat("SIGN TEST EXAMPLES\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Example 1: Recovery times (slide ~line 194)
cat("Example 1: Recovery time, median = 6 days\n")
recovery <- c(8, 5, 7, 10, 4, 9, 3, 12, 6)
diff <- recovery - 6
signs <- sign(diff[diff != 0])
b_plus <- sum(signs > 0)
n <- length(signs)
result <- binom.test(b_plus, n, p=0.5, alternative="two.sided")
cat("Data:", paste(recovery, collapse=", "), "\n")
cat("B+ =", b_plus, ", n =", n, "\n")
cat("p-value:", round(result$p.value, 3), "\n")
cat("SLIDES SHOW: p = 0.727 (should match)\n\n")

# Example 2: Paired pain data (slide ~line 253)
cat("Example 2: Pain before/after treatment\n")
before <- c(7, 8, 6, 9, 5, 8, 7, 6)
after <- c(5, 6, 4, 7, 4, 6, 5, 5)
diff <- before - after
n_improved <- sum(diff > 0)
n_total <- sum(diff != 0)
result <- binom.test(n_improved, n_total, p=0.5)
cat("Improved:", n_improved, "out of", n_total, "\n")
cat("p-value:", round(result$p.value, 3), "\n")
cat("SLIDES SHOW: p = 0.008 (should match)\n\n")

# Example 3: One-sided test (NEW SLIDE added by me)
cat("Example 3: Recovery < 14 days (one-sided)\n")
recovery <- c(12, 15, 10, 13, 16, 11, 14, 9, 12, 15)
below_14 <- sum(recovery < 14)
total <- length(recovery)
result <- binom.test(below_14, total, p=0.5, alternative="greater")
cat("Below 14:", below_14, "out of", total, "\n")
cat("p-value:", round(result$p.value, 3), "\n")
cat("SLIDES SHOW: p = 0.377 (should match)\n\n")

# Example 4: Preference (NEW SLIDE added by me)
cat("Example 4: Treatment preference\n")
prefer_A <- 15
total <- 20
result <- binom.test(prefer_A, total, p=0.5)
cat("Prefer A:", prefer_A, "out of", total, "\n")
cat("p-value:", round(result$p.value, 3), "\n")
cat("SLIDES SHOW: p = 0.041 (should match)\n\n")

# WILCOXON SIGNED-RANK EXAMPLES
cat("WILCOXON SIGNED-RANK EXAMPLES\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Example 1: Blood pressure (slide ~line 382)
cat("Example 1: Blood pressure before/after\n")
bp_before <- c(145, 138, 150, 142, 156, 148)
bp_after <- c(138, 135, 142, 140, 148, 145)
result <- wilcox.test(bp_before, bp_after, paired=TRUE)
cat("Mean reduction:", round(mean(bp_before - bp_after), 2), "mmHg\n")
cat("p-value:", round(result$p.value, 3), "\n")
cat("SLIDES SHOW: p = 0.035 (should match)\n\n")

# Example 2: Same blood pressure data (slide ~line 407)
cat("Example 2: Same BP data (verification)\n")
cat("p-value:", round(result$p.value, 3), "\n")
cat("SLIDES SHOW: p = 0.035 (should match)\n\n")

# Example 3: Weight loss (NEW SLIDE added by me)
cat("Example 3: Weight loss\n")
diff <- c(1.2, 0.8, 2.5, 0.3, 1.8, 0.5, 1.1)
result_sign <- binom.test(sum(diff > 0), length(diff), p=0.5)
result_wilcox <- wilcox.test(diff, mu=0)
cat("Sign test p-value:", round(result_sign$p.value, 3), "\n")
cat("Wilcoxon p-value:", round(result_wilcox$p.value, 3), "\n")
cat("SLIDES SHOW: Both p = 0.016 (should match)\n\n")

# Example 4: Depression scores (NEW SLIDE added by me)
cat("Example 4: Depression scores\n")
before <- c(42, 38, 45, 40, 48, 35, 43)
after <- c(38, 36, 40, 35, 42, 32, 39)
result <- wilcox.test(before, after, paired=TRUE)
cat("Mean reduction:", round(mean(before - after), 1), "\n")
cat("Median reduction:", median(before - after), "\n")
cat("p-value:", round(result$p.value, 3), "\n")
cat("SLIDES SHOW: p = 0.022 ✓\n\n")

# Example 5: Cholesterol with outlier (NEW SLIDE added by me)
cat("Example 5: Cholesterol (with outlier)\n")
cholesterol <- c(185, 195, 210, 198, 425, 192, 205)
result_wilcox <- wilcox.test(cholesterol, mu=200)
result_t <- t.test(cholesterol, mu=200)
cat("Wilcoxon p-value:", round(result_wilcox$p.value, 2), "\n")
cat("t-test p-value:", round(result_t$p.value, 2), "\n")
cat("SLIDES SHOW: Wilcox p = 1.00, t-test p = 0.39 ✓\n\n")

# WILCOXON RANK-SUM EXAMPLES
cat("WILCOXON RANK-SUM EXAMPLES\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Example 1: Treatment response (slide ~line 618)
cat("Example 1: Treatment A vs B response times\n")
treatment_A <- c(23, 31, 25, 28, 30)
treatment_B <- c(18, 22, 20, 24, 19)
result <- wilcox.test(treatment_A, treatment_B)
cat("Median A:", median(treatment_A), ", Median B:", median(treatment_B), "\n")
cat("p-value:", round(result$p.value, 3), "\n")
cat("SLIDES SHOW: p = 0.016 ✓\n\n")

# Example 2: Drug study (slide ~line 622)
cat("Example 2: Drug X vs Y effectiveness\n")
drug_X <- c(45, 52, 48, 55, 50, 47, 53)
drug_Y <- c(38, 42, 40, 45, 39, 43, 41)
result <- wilcox.test(drug_X, drug_Y)
cat("Mean X:", mean(drug_X), ", Mean Y:", mean(drug_Y), "\n")
cat("Median X:", median(drug_X), ", Median Y:", median(drug_Y), "\n")
cat("p-value:", round(result$p.value, 3), "\n")
cat("SLIDES SHOW: p = 0.003 ✓\n\n")

# Example 3: Hospital stays (slide ~line 651)
cat("Example 3: Hospital stay length\n")
procedure_1 <- c(3, 4, 5, 3, 6, 4, 7, 5, 4, 12)
procedure_2 <- c(5, 6, 8, 7, 9, 6, 8, 10, 7, 15)
result <- wilcox.test(procedure_1, procedure_2)
cat("Median 1:", median(procedure_1), ", Median 2:", median(procedure_2), "\n")
cat("p-value:", round(result$p.value, 3), "\n")
cat("SLIDES SHOW: p = 0.011 (should match)\n\n")

# KRUSKAL-WALLIS EXAMPLES
cat("KRUSKAL-WALLIS EXAMPLES\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Example 1: Sleep medication (slide ~line 746)
cat("Example 1: Sleep medication dosages\n")
low_dose <- c(5.2, 6.1, 5.8, 6.3, 5.5)
medium_dose <- c(6.8, 7.2, 7.5, 6.9, 7.1)
high_dose <- c(7.8, 8.2, 8.5, 7.9, 8.1)
sleep_data <- data.frame(
  hours = c(low_dose, medium_dose, high_dose),
  dose = factor(rep(c("Low", "Medium", "High"), each=5))
)
result <- kruskal.test(hours ~ dose, data=sleep_data)
cat("H statistic:", round(result$statistic, 2), "\n")
cat("p-value:", round(result$p.value, 5), "\n")
cat("SLIDES SHOW: H = 12.5, p = 0.00193 (should match)\n\n")

# Example 2: Diet comparison (slide ~line 781)
cat("Example 2: Diet comparison\n")
diet_A <- c(5.2, 6.1, 5.5, 6.3, 5.8)
diet_B <- c(7.2, 8.1, 7.5, 8.3, 7.8)
diet_C <- c(9.2, 10.1, 9.5, 10.3, 9.8)
diet_data <- data.frame(
  weight_loss = c(diet_A, diet_B, diet_C),
  diet = factor(rep(c("A", "B", "C"), each=5))
)
result <- kruskal.test(weight_loss ~ diet, data=diet_data)
cat("H statistic:", round(result$statistic, 2), "\n")
cat("p-value:", round(result$p.value, 6), "\n")
cat("SLIDES SHOW: p < 0.001 (should match)\n\n")

# Example 3: Treatment groups (slide ~line 817)
cat("Example 3: Five treatment groups\n")
recovery <- c(
  12, 14, 13, 15, 11, 13,  # Treatment 1
  10, 11, 9, 12, 10, 11,   # Treatment 2
  15, 17, 16, 18, 16, 15,  # Treatment 3
  8, 9, 7, 10, 8, 9,       # Treatment 4
  13, 14, 12, 15, 13, 14   # Treatment 5
)
treatment <- factor(rep(1:5, each=6))
result <- kruskal.test(recovery ~ treatment)
cat("H statistic:", round(result$statistic, 2), "\n")
cat("p-value:", round(result$p.value, 6), "\n")
cat("SLIDES SHOW: p < 0.001 (should match)\n\n")

# NEW SLIDE: Post-hoc example
cat("Post-hoc: Sleep medication pairwise\n")
sleep_hours <- c(5.2, 6.1, 5.8, 6.3, 5.5,   # Low
                 6.8, 7.2, 7.5, 6.9, 7.1,   # Medium
                 7.8, 8.2, 8.5, 7.9, 8.1)   # High
dose <- factor(rep(c("Low","Med","High"), each=5))
result <- pairwise.wilcox.test(sleep_hours, dose, p.adjust.method="bonferroni")
cat("Post-hoc comparison (Bonferroni adjusted):\n")
print(result$p.value)
cat("SLIDES SHOW: All pairs p < 0.05 (should verify)\n\n")

# NEW SLIDE: Kruskal-Wallis vs ANOVA with outlier
cat("Kruskal-Wallis wins: Outlier example\n")
pain <- c(3, 4, 3, 5, 15,    # Treatment A (outlier!)
          6, 7, 6, 8, 7,     # Treatment B
          2, 3, 2, 4, 3)     # Treatment C
treatment <- factor(rep(c("A","B","C"), each=5))
result_anova <- summary(aov(pain ~ treatment))
result_kw <- kruskal.test(pain ~ treatment)
cat("ANOVA p-value:", round(result_anova[[1]]$`Pr(>F)`[1], 2), "\n")
cat("Kruskal-Wallis p-value:", round(result_kw$p.value, 2), "\n")
cat("SLIDES SHOW: ANOVA p = 0.13, K-W p = 0.01 ✓\n\n")

cat(paste(rep("=", 70), collapse=""), "\n")
cat("VERIFICATION COMPLETE\n")
cat(paste(rep("=", 70), collapse=""), "\n")
cat("\n")
cat("IMPORTANT: Review all claimed p-values above.\n")
cat("If any don't match, slides need correction!\n")
