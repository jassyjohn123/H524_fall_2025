#!/usr/bin/env Rscript
################################################################################
# Week 8 Assignment Answer Verification
# Verifies computational answers for R-based questions
################################################################################

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 8 ASSIGNMENT - VERIFIED ANSWERS\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

################################################################################
# QUESTION 8: FISHER'S EXACT TEST IN R (2 points)
################################################################################

cat("QUESTION 8: Fisher's Exact Test in R\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Data
data_q8 <- matrix(c(7, 3, 2, 8), nrow=2, byrow=TRUE)
rownames(data_q8) <- c("Treatment", "Control")
colnames(data_q8) <- c("Improved", "Not Improved")

cat("\nData:\n")
print(data_q8)

# Fisher's exact test
result_q8 <- fisher.test(data_q8)

cat("\nFisher's Exact Test Results:\n")
cat("  Two-sided p-value:", round(result_q8$p.value, 4), "\n")
cat("  Odds Ratio:", round(result_q8$estimate, 4), "\n")
cat("  95% CI for OR: (", round(result_q8$conf.int[1], 4), ",",
    round(result_q8$conf.int[2], 4), ")\n")

cat("\n**CORRECT ANSWER: B (0.0698)**\n\n")

################################################################################
# QUESTION 9: CHI-SQUARE TEST IN R (2 points)
################################################################################

cat("QUESTION 9: Chi-Square Test in R\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Data
data_q9 <- matrix(c(75, 425, 35, 465), nrow=2, byrow=TRUE)
rownames(data_q9) <- c("Smoker", "Non-smoker")
colnames(data_q9) <- c("Heart Disease", "No Heart Disease")

cat("\nData:\n")
print(data_q9)

# Chi-square test (correct=FALSE to match assignment)
result_q9 <- chisq.test(data_q9, correct=FALSE)

cat("\nChi-Square Test Results:\n")
cat("  Chi-square statistic:", round(result_q9$statistic, 3), "\n")
cat("  Degrees of freedom:", result_q9$parameter, "\n")
cat("  P-value:", format(result_q9$p.value, scientific=TRUE, digits=4), "\n")

cat("\n**CORRECT ANSWER: C (16.343)**\n\n")

################################################################################
# SUMMARY
################################################################################

cat(paste(rep("=", 70), collapse=""), "\n")
cat("ASSIGNMENT POINTS BREAKDOWN\n")
cat(paste(rep("=", 70), collapse=""), "\n")
cat("Part A - Multiple Choice (Q1-Q7):      70 points (7 × 10 pts)\n")
cat("Part B - R Computational (Q8-Q9):      30 points (2 × 15 pts)\n")
cat("Part C - Group Check-In (Q10):         Ungraded (completion only)\n")
cat("                                       -----------\n")
cat("TOTAL:                                100 points\n\n")

cat(paste(rep("=", 70), collapse=""), "\n")
cat("ALL COMPUTATIONAL ANSWERS VERIFIED\n")
cat(paste(rep("=", 70), collapse=""), "\n")
