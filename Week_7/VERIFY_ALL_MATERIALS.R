#!/usr/bin/env Rscript
# COMPREHENSIVE VERIFICATION: All Week 7 numerical values
# Checks: Slides, Lab, Worksheet

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 7 - COMPREHENSIVE VERIFICATION OF ALL MATERIALS\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

errors_found <- 0

# ============================================================================
# SLIDES VERIFICATION (using ACTUAL slide data)
# ============================================================================
cat("PART 1: SLIDES EXAMPLES\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Sign Test Example 1: Recovery (slide has data: 8, 5, 7, 10, 4, 9, 3, 12, 6)
recovery <- c(8, 5, 7, 10, 4, 9, 3, 12, 6)
diff <- recovery - 6
signs <- sign(diff[diff != 0])
b_plus <- sum(signs > 0)
result <- binom.test(b_plus, length(signs), p=0.5)
if (round(result$p.value, 3) != 0.727) {
  cat("ERROR: Sign Test Example 1 - Expected 0.727, got", round(result$p.value, 3), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Sign Test Example 1: p = 0.727\n")
}

# Sign Test Example 2: Pain (slide has: before 7,8,6,9,5,8,7,6; after 5,6,4,7,4,6,5,5)
before <- c(7, 8, 6, 9, 5, 8, 7, 6)
after <- c(5, 6, 4, 7, 4, 6, 5, 5)
diff <- before - after
result <- binom.test(sum(diff > 0), sum(diff != 0), p=0.5)
if (round(result$p.value, 3) != 0.008) {
  cat("ERROR: Sign Test Example 2 - Expected 0.008, got", round(result$p.value, 3), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Sign Test Example 2: p = 0.008\n")
}

# Sign Test Example 3: Recovery < 14
recovery <- c(12, 15, 10, 13, 16, 11, 14, 9, 12, 15)
result <- binom.test(sum(recovery < 14), length(recovery), p=0.5, alternative="greater")
if (round(result$p.value, 3) != 0.377) {
  cat("ERROR: Sign Test Example 3 - Expected 0.377, got", round(result$p.value, 3), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Sign Test Example 3: p = 0.377\n")
}

# Sign Test Example 4: Preference
result <- binom.test(15, 20, p=0.5)
if (round(result$p.value, 3) != 0.041) {
  cat("ERROR: Sign Test Example 4 - Expected 0.041, got", round(result$p.value, 3), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Sign Test Example 4: p = 0.041\n")
}

# Wilcoxon Example 1: BP (slide: before 145,138,150,142,156,148; after 138,135,142,140,148,145)
bp_before <- c(145, 138, 150, 142, 156, 148)
bp_after <- c(138, 135, 142, 140, 148, 145)
result <- wilcox.test(bp_before, bp_after, paired=TRUE)
if (round(result$p.value, 3) != 0.035) {
  cat("ERROR: Wilcoxon Example 1 - Expected 0.035, got", round(result$p.value, 3), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Wilcoxon Example 1: p = 0.035\n")
}

# Wilcoxon Example 4: Depression (corrected to 0.022)
before <- c(42, 38, 45, 40, 48, 35, 43)
after <- c(38, 36, 40, 35, 42, 32, 39)
result <- wilcox.test(before, after, paired=TRUE)
if (round(result$p.value, 3) != 0.022) {
  cat("ERROR: Wilcoxon Example 4 - Expected 0.022, got", round(result$p.value, 3), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Wilcoxon Example 4: p = 0.022\n")
}

# Wilcoxon Example 5: Cholesterol (corrected to 1.00 and 0.39)
cholesterol <- c(185, 195, 210, 198, 425, 192, 205)
result_w <- wilcox.test(cholesterol, mu=200)
result_t <- t.test(cholesterol, mu=200)
if (round(result_w$p.value, 2) != 1.00 || round(result_t$p.value, 2) != 0.39) {
  cat("ERROR: Wilcoxon Example 5 - Expected Wilcox 1.00 & t-test 0.39, got",
      round(result_w$p.value, 2), "&", round(result_t$p.value, 2), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Wilcoxon Example 5: Wilcox p = 1.00, t-test p = 0.39\n")
}

# Rank-Sum Example 1: Treatment (slide: A 23,31,25,28,30; B 18,22,20,24,19)
treatment_A <- c(23, 31, 25, 28, 30)
treatment_B <- c(18, 22, 20, 24, 19)
result <- wilcox.test(treatment_A, treatment_B)
if (round(result$p.value, 3) != 0.016) {
  cat("ERROR: Rank-Sum Example 1 - Expected 0.016, got", round(result$p.value, 3), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Rank-Sum Example 1: p = 0.016\n")
}

# Rank-Sum Example 2: Drug (corrected to 0.003)
drug_X <- c(45, 52, 48, 55, 50, 47, 53)
drug_Y <- c(38, 42, 40, 45, 39, 43, 41)
result <- wilcox.test(drug_X, drug_Y)
if (round(result$p.value, 3) != 0.003) {
  cat("ERROR: Rank-Sum Example 2 - Expected 0.003, got", round(result$p.value, 3), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Rank-Sum Example 2: p = 0.003\n")
}

# Rank-Sum Example 3: Hospital stays
procedure_1 <- c(3, 4, 5, 3, 6, 4, 7, 5, 4, 12)
procedure_2 <- c(5, 6, 8, 7, 9, 6, 8, 10, 7, 15)
result <- wilcox.test(procedure_1, procedure_2)
if (round(result$p.value, 3) != 0.011) {
  cat("ERROR: Rank-Sum Example 3 - Expected 0.011, got", round(result$p.value, 3), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Rank-Sum Example 3: p = 0.011\n")
}

# Kruskal-Wallis Example 1: Sleep
low_dose <- c(5.2, 6.1, 5.8, 6.3, 5.5)
medium_dose <- c(6.8, 7.2, 7.5, 6.9, 7.1)
high_dose <- c(7.8, 8.2, 8.5, 7.9, 8.1)
sleep_data <- data.frame(
  hours = c(low_dose, medium_dose, high_dose),
  dose = factor(rep(c("Low", "Medium", "High"), each=5))
)
result <- kruskal.test(hours ~ dose, data=sleep_data)
if (round(result$statistic, 2) != 12.5 || round(result$p.value, 5) != 0.00193) {
  cat("ERROR: K-W Example 1 - Expected H=12.5, p=0.00193, got H=",
      round(result$statistic, 2), "p=", round(result$p.value, 5), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ K-W Example 1: H = 12.5, p = 0.00193\n")
}

# ANOVA vs K-W (corrected to 0.13 and 0.01)
pain <- c(3, 4, 3, 5, 15, 6, 7, 6, 8, 7, 2, 3, 2, 4, 3)
treatment <- factor(rep(c("A","B","C"), each=5))
result_anova <- summary(aov(pain ~ treatment))
result_kw <- kruskal.test(pain ~ treatment)
if (round(result_anova[[1]]$`Pr(>F)`[1], 2) != 0.13 || round(result_kw$p.value, 2) != 0.01) {
  cat("ERROR: ANOVA vs K-W - Expected ANOVA 0.13 & K-W 0.01, got",
      round(result_anova[[1]]$`Pr(>F)`[1], 2), "&", round(result_kw$p.value, 2), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ ANOVA vs K-W: ANOVA p = 0.13, K-W p = 0.01\n")
}

cat("\n")

# ============================================================================
# WORKSHEET VERIFICATION (key values)
# ============================================================================
cat("PART 2: WORKSHEET KEY VALUES\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Problem 1: Sign Test (recovery < 14)
recovery <- c(12, 15, 10, 13, 16, 11, 14, 9, 12, 15)
result <- binom.test(sum(recovery < 14), length(recovery) - sum(recovery == 14),
                     p=0.5, alternative="greater")
if (round(result$p.value, 4) != 0.2539) {
  cat("ERROR: Worksheet P1 - Expected 0.2539, got", round(result$p.value, 4), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Worksheet P1 (Sign Test): p = 0.2539\n")
}

# Problem 3B: Sign test BP
bp_before <- c(142, 138, 155, 148, 160, 145, 152, 149)
bp_after <- c(138, 140, 148, 145, 155, 142, 150, 145)
result <- binom.test(sum(bp_before > bp_after), length(bp_before), p=0.5)
if (round(result$p.value, 4) != 0.0703) {
  cat("ERROR: Worksheet P3B - Expected 0.0703, got", round(result$p.value, 4), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Worksheet P3B (Sign): p = 0.0703\n")
}

# Problem 3C: Wilcoxon BP
result <- wilcox.test(bp_before, bp_after, paired=TRUE)
if (round(result$p.value, 4) != 0.0245) {
  cat("ERROR: Worksheet P3C - Expected 0.0245, got", round(result$p.value, 4), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Worksheet P3C (Wilcoxon): p = 0.0245\n")
}

# Problem 4: Rank-sum medications
med_a <- c(6, 7, 5, 8, 6, 7, 9)
med_b <- c(4, 5, 6, 5, 7, 4, 6)
result <- wilcox.test(med_a, med_b)
if (round(result$p.value, 4) != 0.0502) {
  cat("ERROR: Worksheet P4 - Expected 0.0502, got", round(result$p.value, 4), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Worksheet P4 (Rank-sum): p = 0.0502\n")
}

# Problem 5: Kruskal-Wallis sleep
low_dose <- c(5.2, 6.1, 5.8, 6.3, 5.5)
med_dose <- c(6.8, 7.2, 7.5, 6.9, 7.1)
high_dose <- c(7.8, 8.2, 8.5, 7.9, 8.1)
sleep_data <- data.frame(
  hours = c(low_dose, med_dose, high_dose),
  dose = factor(rep(c("Low", "Medium", "High"), each=5))
)
result <- kruskal.test(hours ~ dose, data=sleep_data)
if (round(result$p.value, 5) != 0.00193) {
  cat("ERROR: Worksheet P5 - Expected 0.00193, got", round(result$p.value, 5), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Worksheet P5 (K-W): p = 0.00193\n")
}

cat("\n")

# ============================================================================
# LAB VERIFICATION (spot check key exercises)
# ============================================================================
cat("PART 3: LAB KEY VALUES (spot check)\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Lab Exercise 1: Shapiro tests
normal_data <- c(23, 25, 24, 26, 22, 25, 24, 23, 25, 24)
result <- shapiro.test(normal_data)
if (round(result$p.value, 4) != 0.2371) {
  cat("ERROR: Lab Ex1 normal - Expected 0.2371, got", round(result$p.value, 4), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Lab Ex1 (Shapiro normal): p = 0.2371\n")
}

skewed_data <- c(2, 3, 3, 4, 5, 5, 6, 15, 18, 25)
result <- shapiro.test(skewed_data)
if (round(result$p.value, 4) != 0.0025) {
  cat("ERROR: Lab Ex1 skewed - Expected 0.0025, got", round(result$p.value, 4), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Lab Ex1 (Shapiro skewed): p = 0.0025\n")
}

# Lab Exercise 4: BP Wilcoxon
bp_before <- c(142, 138, 155, 148, 160, 145, 152, 149, 144, 158, 146, 153)
bp_after <- c(138, 140, 148, 145, 155, 142, 150, 145, 141, 152, 143, 148)
result <- wilcox.test(bp_before, bp_after, paired=TRUE)
if (round(result$p.value, 4) != 0.0139) {
  cat("ERROR: Lab Ex4 - Expected 0.0139, got", round(result$p.value, 4), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Lab Ex4 (BP Wilcoxon): p = 0.0139\n")
}

# Lab Exercise 6: Treatment comparison
recovery_A <- c(28, 32, 30, 35, 29, 31, 33, 30, 32, 29)
recovery_B <- c(21, 24, 22, 26, 23, 20, 25, 23, 22, 24)
result <- wilcox.test(recovery_A, recovery_B)
if (round(result$p.value, 3) != 0.004) {
  cat("ERROR: Lab Ex6 - Expected 0.004, got", round(result$p.value, 3), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Lab Ex6 (Rank-sum): p = 0.004\n")
}

# Lab Exercise 8: Kruskal-Wallis
score_A <- c(45, 52, 48, 51, 47, 49)
score_B <- c(62, 58, 65, 61, 59, 64)
score_C <- c(38, 42, 40, 39, 41, 43)
score_D <- c(55, 58, 53, 57, 56, 54)
score_data <- data.frame(
  score = c(score_A, score_B, score_C, score_D),
  diet = factor(rep(c("A", "B", "C", "D"), each=6))
)
result <- kruskal.test(score ~ diet, data=score_data)
if (round(result$p.value, 6) < 0.000001) {
  cat("✓ Lab Ex8 (K-W): p < 0.001\n")
} else {
  cat("ERROR: Lab Ex8 - Expected p < 0.001, got", round(result$p.value, 6), "\n")
  errors_found <- errors_found + 1
}

cat("\n")

# ============================================================================
# FINAL SUMMARY
# ============================================================================
cat(paste(rep("=", 70), collapse=""), "\n")
if (errors_found == 0) {
  cat("SUCCESS: ALL NUMERICAL VALUES VERIFIED CORRECTLY\n")
  cat("✓ Slides: All p-values match\n")
  cat("✓ Worksheet: All key values match\n")
  cat("✓ Lab: All key values match\n")
} else {
  cat("ERRORS FOUND:", errors_found, "numerical value(s) don't match\n")
  cat("*** REVIEW AND FIX ERRORS ABOVE ***\n")
}
cat(paste(rep("=", 70), collapse=""), "\n")

# Return error code if errors found
quit(status = if(errors_found > 0) 1 else 0)
