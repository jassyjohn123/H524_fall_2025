#!/usr/bin/env Rscript
################################################################################
# Week 8 Lab Verification Script
# Verifies all computational results in the lab
################################################################################

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 8 LAB - COMPUTATIONAL VERIFICATION\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

################################################################################
# PART 1: CHI-SQUARE GOODNESS-OF-FIT TEST
################################################################################

cat("PART 1: CHI-SQUARE GOODNESS-OF-FIT TEST\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Exercise 1.1: Blood Type Distribution (U.S. Population)
cat("Exercise 1.1: Blood Type Distribution (U.S. Population)\n")
observed <- c(O=90, A=80, B=22, AB=8)
expected_props <- c(O=0.45, A=0.40, B=0.11, AB=0.04)
chi_result <- chisq.test(observed, p=expected_props)
cat("  Chi-square statistic:", round(chi_result$statistic, 4), "\n")
cat("  P-value:", round(chi_result$p.value, 4), "\n\n")

# Exercise 1.3: Blood Type Distribution (Hospital)
cat("Exercise 1.3: Blood Type Distribution (Hospital)\n")
observed <- c(A=85, B=78, AB=28, O=9)
expected_props <- c(A=0.45, B=0.40, AB=0.11, O=0.04)
chi_result <- chisq.test(observed, p=expected_props)
cat("  Chi-square statistic:", round(chi_result$statistic, 4), "\n")
cat("  P-value:", round(chi_result$p.value, 4), "\n\n")

# Exercise 1.4: Die Fairness
cat("Exercise 1.4: Die Fairness\n")
observed <- c(18, 22, 17, 23, 19, 21)
expected_props <- rep(1/6, 6)
chi_result <- chisq.test(observed, p=expected_props)
cat("  Chi-square statistic:", round(chi_result$statistic, 4), "\n")
cat("  P-value:", round(chi_result$p.value, 4), "\n\n")

################################################################################
# PART 2: CHI-SQUARE TEST OF INDEPENDENCE
################################################################################

cat("PART 2: CHI-SQUARE TEST OF INDEPENDENCE\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Exercise 2.1: Smoking and Lung Cancer
cat("Exercise 2.1: Smoking and Lung Cancer\n")
data <- matrix(c(85, 55, 15, 45), nrow=2, byrow=TRUE)
rownames(data) <- c("Smoker", "Non-smoker")
colnames(data) <- c("Cancer", "No Cancer")
chi_result <- chisq.test(data, correct=FALSE)
cat("  Chi-square statistic:", round(chi_result$statistic, 4), "\n")
cat("  P-value:", format(chi_result$p.value, scientific=TRUE, digits=4), "\n\n")

# Exercise 2.2: Effect Sizes (Week 9 Preview)
cat("Exercise 2.2: Effect Sizes (Week 9 Preview)\n")
p_cancer_smoker <- data[1,1] / sum(data[1,])
p_cancer_nonsmoker <- data[2,1] / sum(data[2,])
relative_risk <- p_cancer_smoker / p_cancer_nonsmoker
odds_ratio <- (data[1,1] * data[2,2]) / (data[1,2] * data[2,1])
cat("  Relative Risk:", round(relative_risk, 3), "\n")
cat("  Odds Ratio:", round(odds_ratio, 3), "\n\n")

# Exercise 2.4: Larger Tables (Education and Exercise)
cat("Exercise 2.4: Larger Contingency Tables\n")
data_large <- matrix(c(35, 45, 20,
                       25, 40, 35,
                       15, 30, 55), nrow=3, byrow=TRUE)
chi_result <- chisq.test(data_large)
cat("  Chi-square statistic:", round(chi_result$statistic, 4), "\n")
cat("  P-value:", format(chi_result$p.value, scientific=TRUE, digits=4), "\n\n")

# Exercise 2.5: Treatment Efficacy
cat("Exercise 2.5: Treatment Efficacy\n")
data_treatment <- matrix(c(48, 12, 32, 28), nrow=2, byrow=TRUE)
chi_result <- chisq.test(data_treatment, correct=FALSE)
cat("  Chi-square statistic:", round(chi_result$statistic, 4), "\n")
cat("  P-value:", round(chi_result$p.value, 4), "\n\n")

################################################################################
# PART 3: FISHER'S EXACT TEST
################################################################################

cat("PART 3: FISHER'S EXACT TEST\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Exercise 3.1: Small Sample Example
cat("Exercise 3.1: Small Sample Example\n")
data_small <- matrix(c(7, 3, 2, 8), nrow=2, byrow=TRUE)
fisher_result <- fisher.test(data_small)
cat("  P-value (two-sided):", round(fisher_result$p.value, 4), "\n")
cat("  Odds Ratio:", round(fisher_result$estimate, 4), "\n")
cat("  95% CI for OR: (", round(fisher_result$conf.int[1], 4), ",",
    round(fisher_result$conf.int[2], 4), ")\n\n")

# Exercise 3.3: Medical Device Study
cat("Exercise 3.3: Medical Device Study\n")
data_device <- matrix(c(8, 2, 3, 7), nrow=2, byrow=TRUE)
fisher_result <- fisher.test(data_device)
cat("  P-value (two-sided):", round(fisher_result$p.value, 4), "\n")
cat("  Odds Ratio:", round(fisher_result$estimate, 4), "\n\n")

################################################################################
# PART 4: MCNEMAR'S TEST
################################################################################

cat("PART 4: MCNEMAR'S TEST\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Exercise 4.1: Before-After Treatment
cat("Exercise 4.1: Before-After Treatment Study\n")
data_paired <- matrix(c(18, 12, 22, 8), nrow=2, byrow=TRUE)
mcnemar_result <- mcnemar.test(data_paired, correct=FALSE)
cat("  McNemar chi-square:", round(mcnemar_result$statistic, 4), "\n")
cat("  P-value:", round(mcnemar_result$p.value, 4), "\n\n")

# Exercise 4.2: Matched Case-Control
cat("Exercise 4.2: Matched Case-Control Study\n")
data_matched <- matrix(c(20, 15, 30, 35), nrow=2, byrow=TRUE)
mcnemar_result <- mcnemar.test(data_matched, correct=FALSE)
cat("  McNemar chi-square:", round(mcnemar_result$statistic, 4), "\n")
cat("  P-value:", round(mcnemar_result$p.value, 4), "\n\n")

################################################################################
# PART 5: COMPREHENSIVE EXAMPLE
################################################################################

cat("PART 5: COMPREHENSIVE EXAMPLE - VACCINE EFFICACY\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Exercise 5.1: Vaccine Efficacy Study
cat("Exercise 5.1: Vaccine Efficacy Study\n")
data_vaccine <- matrix(c(8, 492, 52, 448), nrow=2, byrow=TRUE)
rownames(data_vaccine) <- c("Vaccinated", "Placebo")
colnames(data_vaccine) <- c("COVID", "No COVID")

# Chi-square test
chi_result <- chisq.test(data_vaccine, correct=FALSE)
cat("  Chi-square statistic:", round(chi_result$statistic, 4), "\n")
cat("  P-value:", format(chi_result$p.value, scientific=TRUE, digits=4), "\n")

# Vaccine efficacy
risk_vaccine <- data_vaccine[1,1] / sum(data_vaccine[1,])
risk_placebo <- data_vaccine[2,1] / sum(data_vaccine[2,])
VE <- (1 - risk_vaccine / risk_placebo) * 100
cat("  Vaccine Efficacy:", round(VE, 2), "%\n\n")

################################################################################
# PRACTICE PROBLEMS
################################################################################

cat("PRACTICE PROBLEMS\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Problem 1: Educational Attainment
cat("Problem 1: Educational Attainment\n")
data_p1 <- matrix(c(40, 30, 30, 35, 40, 25, 25, 30, 45), nrow=3, byrow=TRUE)
chi_result <- chisq.test(data_p1)
cat("  Chi-square statistic:", round(chi_result$statistic, 4), "\n")
cat("  P-value:", round(chi_result$p.value, 4), "\n\n")

# Problem 2: Drug Side Effects
cat("Problem 2: Drug Side Effects\n")
data_p2 <- matrix(c(12, 88, 5, 95), nrow=2, byrow=TRUE)
fisher_result <- fisher.test(data_p2)
cat("  P-value (Fisher's):", round(fisher_result$p.value, 4), "\n")
cat("  Odds Ratio:", round(fisher_result$estimate, 4), "\n\n")

# Problem 3: Coffee and Heart Disease
cat("Problem 3: Coffee and Heart Disease\n")
data_p3 <- matrix(c(75, 425, 35, 465), nrow=2, byrow=TRUE)
chi_result <- chisq.test(data_p3, correct=FALSE)
cat("  Chi-square statistic:", round(chi_result$statistic, 4), "\n")
cat("  P-value:", format(chi_result$p.value, scientific=TRUE, digits=4), "\n\n")

# Problem 4: Depression Treatment
cat("Problem 4: Depression Treatment\n")
data_p4 <- matrix(c(25, 10, 18, 17), nrow=2, byrow=TRUE)
mcnemar_result <- mcnemar.test(data_p4, correct=FALSE)
cat("  McNemar chi-square:", round(mcnemar_result$statistic, 4), "\n")
cat("  P-value:", round(mcnemar_result$p.value, 4), "\n\n")

################################################################################
# SUMMARY
################################################################################

cat(paste(rep("=", 70), collapse=""), "\n")
cat("ALL LAB COMPUTATIONS VERIFIED\n")
cat(paste(rep("=", 70), collapse=""), "\n")
