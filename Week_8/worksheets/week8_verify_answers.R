#!/usr/bin/env Rscript
# Verification script for Week 8 Worksheet
# ALL numerical answers verified computationally - NO MENTAL MATH

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 8 WORKSHEET - VERIFIED ANSWERS\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

################################################################################
# PROBLEM 1: FISHER'S EXACT TEST
################################################################################
cat("PROBLEM 1: Fisher's Exact Test\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Data
treat_imp <- 7
treat_not <- 3
control_imp <- 2
control_not <- 8

# Part A: Expected counts
row1 <- treat_imp + treat_not
row2 <- control_imp + control_not
col1 <- treat_imp + control_imp
col2 <- treat_not + control_not
n <- 20

exp_treat_imp <- row1 * col1 / n
exp_treat_not <- row1 * col2 / n
exp_control_imp <- row2 * col1 / n
exp_control_not <- row2 * col2 / n

cat("Part A: Expected counts\n")
cat("  Treatment/Improved:", exp_treat_imp, "\n")
cat("  Treatment/Not Improved:", exp_treat_not, "\n")
cat("  Control/Improved:", exp_control_imp, "\n")
cat("  Control/Not Improved:", exp_control_not, "\n\n")

# Part B: Check assumptions
cat("Part B: Chi-square assumptions\n")
cat("  Rule: All expected counts should be ≥ 5\n")
cat("  Smallest expected count:", min(exp_treat_imp, exp_treat_not,
                                      exp_control_imp, exp_control_not), "\n")
if (min(exp_treat_imp, exp_treat_not, exp_control_imp, exp_control_not) < 5) {
  cat("  Assumptions VIOLATED - use Fisher's exact test\n\n")
} else {
  cat("  Assumptions satisfied\n\n")
}

# Part C: Which test to use
cat("Part C: Appropriate test\n")
cat("  Fisher's exact test (chi-square assumptions violated)\n\n")

# Part D: Fisher's exact test
data_p1 <- matrix(c(treat_imp, treat_not, control_imp, control_not), nrow=2, byrow=TRUE)
fisher_result <- fisher.test(data_p1)

cat("Part D: Fisher's exact test results\n")
cat("  R code: fisher.test(matrix(c(7, 3, 2, 8), nrow=2, byrow=TRUE))\n")
cat("  p-value (two-sided):", round(fisher_result$p.value, 4), "\n")
cat("  Odds Ratio:", round(fisher_result$estimate, 4), "\n")
cat("  95% CI for OR: (", round(fisher_result$conf.int[1], 4), ",",
    round(fisher_result$conf.int[2], 4), ")\n\n")

# Part E: Conclusion
cat("Part E: Conclusion\n")
if (fisher_result$p.value < 0.05) {
  cat("  Significant evidence of treatment effectiveness (p < 0.05).\n")
  cat("  The treatment appears to improve outcomes.\n\n")
} else {
  cat("  No significant evidence of treatment effectiveness (p ≥ 0.05).\n\n")
}

################################################################################
# PROBLEM 2: CHI-SQUARE TEST OF INDEPENDENCE
################################################################################

cat("PROBLEM 2: Chi-Square Test of Independence\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Data
smoker_hd <- 75
smoker_no <- 425
nonsmoker_hd <- 35
nonsmoker_no <- 465
n_total <- 1000

# Row and column totals
row1 <- smoker_hd + smoker_no
row2 <- nonsmoker_hd + nonsmoker_no
col1 <- smoker_hd + nonsmoker_hd
col2 <- smoker_no + nonsmoker_no

# Part B: Expected counts
exp_smoker_hd <- row1 * col1 / n_total
exp_smoker_no <- row1 * col2 / n_total
exp_nonsmoker_hd <- row2 * col1 / n_total
exp_nonsmoker_no <- row2 * col2 / n_total

cat("Part B: Expected counts\n")
cat("  Smoker/Heart Disease:", exp_smoker_hd, "\n")
cat("  Smoker/No Heart Disease:", exp_smoker_no, "\n")
cat("  Non-smoker/Heart Disease:", exp_nonsmoker_hd, "\n")
cat("  Non-smoker/No Heart Disease:", exp_nonsmoker_no, "\n\n")

# Part C: Chi-square statistic
chi_sq_2 <- ((smoker_hd - exp_smoker_hd)^2 / exp_smoker_hd) +
             ((smoker_no - exp_smoker_no)^2 / exp_smoker_no) +
             ((nonsmoker_hd - exp_nonsmoker_hd)^2 / exp_nonsmoker_hd) +
             ((nonsmoker_no - exp_nonsmoker_no)^2 / exp_nonsmoker_no)

cat("Part C: Chi-square test statistic\n")
cat("  χ² =", round(chi_sq_2, 4), "\n\n")

# Part D: df and p-value
df_2 <- (2-1) * (2-1)
p_value_2 <- pchisq(chi_sq_2, df_2, lower.tail = FALSE)

cat("Part D: df and p-value\n")
cat("  df =", df_2, "\n")
cat("  p-value =", format(p_value_2, scientific = TRUE, digits = 4), "\n\n")

cat("  Conclusion: Strong evidence of association between smoking and\n")
cat("  heart disease (p < 0.05).\n\n")

################################################################################
# PROBLEM 3: EFFECT SIZES - RR AND OR (WEEK 9 PREVIEW)
################################################################################

cat("PROBLEM 3: Effect Sizes - RR and OR (WEEK 9 PREVIEW)\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Data
exposed_disease <- 80
exposed_no_disease <- 420
unexposed_disease <- 40
unexposed_no_disease <- 460

# Create matrix
data_p3 <- matrix(c(exposed_disease, exposed_no_disease,
                    unexposed_disease, unexposed_no_disease),
                  nrow=2, byrow=TRUE)

# Part A: Relative Risk
risk_exposed <- exposed_disease / (exposed_disease + exposed_no_disease)
risk_unexposed <- unexposed_disease / (unexposed_disease + unexposed_no_disease)
RR <- risk_exposed / risk_unexposed

cat("Part A: Relative Risk\n")
cat("  Risk in exposed:", round(risk_exposed, 4), "\n")
cat("  Risk in unexposed:", round(risk_unexposed, 4), "\n")
cat("  Relative Risk (RR):", round(RR, 4), "\n\n")

# Part B: Interpretation
cat("Part B: Interpretation\n")
cat("  The exposed group has", round(RR, 2), "times the risk of disease\n")
cat("  compared to the unexposed group.\n\n")

# Part C: Odds Ratio
OR_manual <- (exposed_disease * unexposed_no_disease) /
             (exposed_no_disease * unexposed_disease)
cat("Part C: Odds Ratio\n")
cat("  OR (manual calculation):", round(OR_manual, 4), "\n\n")

# Part D: Compare RR and OR
cat("Part D: Comparison of RR and OR\n")
cat("  RR:", round(RR, 4), "\n")
cat("  OR:", round(OR_manual, 4), "\n")
cat("  They are similar because disease is relatively rare (12% overall).\n")
cat("  When disease is rare, OR approximates RR.\n\n")

# Part E: R verification and CI
fisher_result_p3 <- fisher.test(data_p3)
cat("Part E: Fisher's exact test in R\n")
cat("  R code: fisher.test(matrix(c(80, 420, 40, 460), nrow=2, byrow=TRUE))\n")
cat("  OR from R:", round(fisher_result_p3$estimate, 4), "\n")
cat("  95% CI for OR: (", round(fisher_result_p3$conf.int[1], 4), ",",
    round(fisher_result_p3$conf.int[2], 4), ")\n\n")

# Part F: Conclusion
cat("Part F: Conclusion\n")
if (fisher_result_p3$conf.int[1] > 1) {
  cat("  The 95% CI does NOT include 1.0, so there is significant evidence\n")
  cat("  of an association between exposure and disease (p < 0.05).\n")
  cat("  The exposed group has significantly higher odds of disease.\n\n")
} else if (fisher_result_p3$conf.int[2] < 1) {
  cat("  The 95% CI does NOT include 1.0, so there is significant evidence\n")
  cat("  of a protective association (p < 0.05).\n\n")
} else {
  cat("  The 95% CI includes 1.0, so there is NO significant evidence\n")
  cat("  of an association (p >= 0.05).\n\n")
}

cat(paste(rep("=", 70), collapse=""), "\n")
cat("ALL ANSWERS VERIFIED COMPUTATIONALLY\n")
cat(paste(rep("=", 70), collapse=""), "\n")
