################################################################################
# H524 Introduction to Biostatistics
# Week 8 Worksheet: Contingency Tables and Chi-Square Tests
# R Code Solutions
# Fall 2025
################################################################################

# Clear workspace
rm(list = ls())
options(scipen = 999)  # Avoid scientific notation

################################################################################
# PROBLEM 1: FISHER'S EXACT TEST
################################################################################

cat("PROBLEM 1: Fisher's Exact Test\n")
cat(paste(rep("=", 70), collapse=""), "\n")

# Create data
data_fisher <- matrix(c(7, 3, 2, 8), nrow=2, byrow=TRUE)
rownames(data_fisher) <- c("Treatment", "Control")
colnames(data_fisher) <- c("Improved", "Not Improved")

cat("\nData:\n")
print(data_fisher)

# Part A: Expected counts
cat("\nPart A: Expected counts\n")
row_totals <- rowSums(data_fisher)
col_totals <- colSums(data_fisher)
n_total <- sum(data_fisher)

expected_matrix <- outer(row_totals, col_totals) / n_total
rownames(expected_matrix) <- rownames(data_fisher)
colnames(expected_matrix) <- colnames(data_fisher)
print(expected_matrix)

# Part B: Check assumptions
cat("\nPart B: Chi-square assumptions\n")
cat("Rule: All expected counts should be ≥ 5\n")
cat("Smallest expected count:", min(expected_matrix), "\n")
if (min(expected_matrix) < 5) {
  cat("Assumptions VIOLATED - use Fisher's exact test\n")
} else {
  cat("Assumptions satisfied\n")
}

# Part C: Which test to use
cat("\nPart C: Appropriate test\n")
cat("Fisher's exact test (chi-square assumptions violated)\n")

# Part D: Fisher's exact test
cat("\nPart D: Fisher's exact test results\n")
fisher_result <- fisher.test(data_fisher)
cat("R code: fisher.test(matrix(c(7, 3, 2, 8), nrow=2, byrow=TRUE))\n\n")
print(fisher_result)

cat("\nP-value (two-sided):", round(fisher_result$p.value, 4), "\n")
cat("Odds Ratio:", round(fisher_result$estimate, 4), "\n")
cat("95% CI for OR: (", round(fisher_result$conf.int[1], 4), ",",
    round(fisher_result$conf.int[2], 4), ")\n")

# Part E: Conclusion
cat("\nPart E: Conclusion\n")
if (fisher_result$p.value < 0.05) {
  cat("Significant evidence of treatment effectiveness (p < 0.05).\n")
} else {
  cat("No significant evidence of treatment effectiveness (p ≥ 0.05).\n")
  cat("However, p-value is close to 0.05, suggesting possible effect.\n")
  cat("Larger study may be warranted.\n")
}

################################################################################
# PROBLEM 2: CHI-SQUARE TEST OF INDEPENDENCE
################################################################################

cat("\n\n")
cat("PROBLEM 2: Chi-Square Test of Independence\n")
cat(paste(rep("=", 70), collapse=""), "\n")

# Create the data
data <- matrix(c(75, 425, 35, 465), nrow=2, byrow=TRUE)
rownames(data) <- c("Smoker", "Non-smoker")
colnames(data) <- c("Heart Disease", "No Heart Disease")

cat("\nData:\n")
print(data)

# Part A: Hypotheses
cat("\nPart A: Hypotheses\n")
cat("H0: Smoking status and heart disease are independent\n")
cat("HA: Smoking status and heart disease are not independent\n")

# Part B: Expected counts
cat("\nPart B: Expected counts\n")
row_totals <- rowSums(data)
col_totals <- colSums(data)
n_total <- sum(data)

expected_matrix <- outer(row_totals, col_totals) / n_total
rownames(expected_matrix) <- rownames(data)
colnames(expected_matrix) <- colnames(data)
print(expected_matrix)

# Part C: Chi-square statistic
cat("\nPart C: Chi-square test statistic\n")
chi_sq <- sum((data - expected_matrix)^2 / expected_matrix)
cat("χ² =", round(chi_sq, 4), "\n")

# Part D: df and p-value
cat("\nPart D: df and p-value\n")
df <- (nrow(data) - 1) * (ncol(data) - 1)
p_value <- pchisq(chi_sq, df, lower.tail = FALSE)
cat("df =", df, "\n")
cat("p-value =", format(p_value, scientific = TRUE, digits = 4), "\n")

cat("\nConclusion: Strong evidence of association between smoking and\n")
cat("heart disease (p < 0.05).\n")

# Verify with R function
cat("\nVerification using R's chisq.test():\n")
result <- chisq.test(data, correct = FALSE)
print(result)

################################################################################
# PROBLEM 3: EFFECT SIZES - RR AND OR (WEEK 9 PREVIEW - OPTIONAL)
################################################################################

cat("\n\n")
cat("PROBLEM 3: Effect Sizes - RR and OR (WEEK 9 PREVIEW - OPTIONAL)\n")
cat(paste(rep("=", 70), collapse=""), "\n")

# Create data
data_rr <- matrix(c(80, 420, 40, 460), nrow=2, byrow=TRUE)
rownames(data_rr) <- c("Exposed", "Unexposed")
colnames(data_rr) <- c("Disease", "No Disease")

cat("\nData:\n")
print(data_rr)

# Part A: Relative Risk
cat("\nPart A: Relative Risk\n")
risk_exposed <- data_rr[1,1] / sum(data_rr[1,])
risk_unexposed <- data_rr[2,1] / sum(data_rr[2,])
RR <- risk_exposed / risk_unexposed

cat("Risk in exposed group =", data_rr[1,1], "/", sum(data_rr[1,]),
    "=", round(risk_exposed, 4), "\n")
cat("Risk in unexposed group =", data_rr[2,1], "/", sum(data_rr[2,]),
    "=", round(risk_unexposed, 4), "\n")
cat("Relative Risk (RR) =", round(RR, 4), "\n")

# Part B: Interpret RR
cat("\nPart B: Interpretation\n")
cat("The exposed group has", round(RR, 2),
    "times the risk of disease compared to the unexposed group.\n")

# Part C: Odds Ratio
cat("\nPart C: Odds Ratio\n")
OR <- (data_rr[1,1] * data_rr[2,2]) / (data_rr[1,2] * data_rr[2,1])
cat("OR = (80 × 460) / (420 × 40) =", round(OR, 4), "\n")

# Part D: Compare RR and OR
cat("\nPart D: Compare RR and OR\n")
cat("RR =", round(RR, 4), "\n")
cat("OR =", round(OR, 4), "\n")
cat("They are similar because disease is relatively rare (12% overall).\n")
cat("When disease is rare, OR approximates RR.\n")

# Part E: R verification and CI
cat("\nPart E: Fisher's exact test in R\n")
fisher_result <- fisher.test(data_rr)
cat("R code: fisher.test(matrix(c(80, 420, 40, 460), nrow=2, byrow=TRUE))\n\n")
print(fisher_result)

cat("\nOR from R:", round(fisher_result$estimate, 4), "\n")
cat("95% CI for OR: (", round(fisher_result$conf.int[1], 4), ",",
    round(fisher_result$conf.int[2], 4), ")\n")

# Part F: Conclusion
cat("\nPart F: Conclusion\n")
if (fisher_result$conf.int[1] > 1) {
  cat("The 95% CI does NOT include 1.0, so there is significant evidence\n")
  cat("of an association between exposure and disease (p < 0.05).\n")
  cat("The exposed group has significantly higher odds of disease.\n")
} else if (fisher_result$conf.int[2] < 1) {
  cat("The 95% CI does NOT include 1.0, so there is significant evidence\n")
  cat("of a protective association (p < 0.05).\n")
} else {
  cat("The 95% CI includes 1.0, so there is NO significant evidence\n")
  cat("of an association (p >= 0.05).\n")
}

################################################################################
# END OF WORKSHEET CODE
################################################################################

cat("\n\n")
cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 8 WORKSHEET CODE COMPLETE\n")
cat(paste(rep("=", 70), collapse=""), "\n")
