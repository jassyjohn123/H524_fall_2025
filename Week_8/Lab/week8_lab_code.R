#!/usr/bin/env Rscript
# ==============================================================================
# H524 WEEK 8 LAB: CATEGORICAL DATA ANALYSIS
# Complete Code from Lab Exercises
# Fall 2025
# ==============================================================================
#
# This script contains all code from Week 8 Lab
# Use this to follow along in lab or for reference
#
# Topics covered:
# - Chi-square goodness-of-fit test
# - Chi-square test of independence
# - Fisher's exact test
# - McNemar's test (paired data)
#
# ==============================================================================

# ==============================================================================
# PART 1: CHI-SQUARE GOODNESS-OF-FIT TEST
# ==============================================================================

cat("\n========== PART 1: CHI-SQUARE GOODNESS-OF-FIT TEST ==========\n")

# ------------------------------------------------------------------------------
# Exercise 1.1: Blood Type Distribution
# ------------------------------------------------------------------------------

cat("\n--- Exercise 1.1: Blood Type Distribution ---\n")

# Observed counts from hospital sample
observed <- c(O=85, A=78, B=28, AB=9)
total <- sum(observed)

cat("Total sample size:", total, "\n")
cat("Observed counts:\n")
print(observed)

# Expected proportions (from population)
expected_props <- c(O=0.45, A=0.40, B=0.11, AB=0.04)

# Chi-square goodness-of-fit test
chi_result <- chisq.test(observed, p=expected_props)

cat("\nChi-square test results:\n")
print(chi_result)

# Extract components
cat("\nTest statistic:", round(chi_result$statistic, 3), "\n")
cat("Degrees of freedom:", chi_result$parameter, "\n")
cat("P-value:", round(chi_result$p.value, 4), "\n")

# Expected counts
cat("\nExpected counts:\n")
print(round(chi_result$expected, 2))

# Compare observed vs expected
comparison <- data.frame(
  BloodType = names(observed),
  Observed = as.numeric(observed),
  Expected = round(chi_result$expected, 2),
  Difference = as.numeric(observed) - round(chi_result$expected, 2)
)
print(comparison)

# ------------------------------------------------------------------------------
# Exercise 1.2: Visualizing Goodness-of-Fit
# ------------------------------------------------------------------------------

cat("\n--- Exercise 1.2: Visualizing Goodness-of-Fit ---\n")

# Create visualization
library(graphics)

# Prepare data for plotting
blood_data <- rbind(
  Observed = as.numeric(observed),
  Expected = chi_result$expected
)
colnames(blood_data) <- names(observed)

# Grouped barplot
barplot(blood_data, beside=TRUE,
        col=c("steelblue", "coral"),
        legend=rownames(blood_data),
        main="Blood Type Distribution: Observed vs Expected",
        xlab="Blood Type", ylab="Count",
        args.legend=list(x="topright"))

# Add chi-square test result as text
text(x=6, y=max(blood_data)*0.9,
     labels=paste0("Chi-square = ", round(chi_result$statistic, 2),
                   "\nP-value = ", round(chi_result$p.value, 3)),
     pos=4, cex=0.9)

# ------------------------------------------------------------------------------
# Exercise 1.3: Blood Type Distribution
# ------------------------------------------------------------------------------

cat("\n--- Exercise 1.3: Blood Type Distribution ---\n")

# Observed counts
observed <- c(A=85, B=78, AB=28, O=9)
total <- sum(observed)

# Expected proportions (U.S. population)
expected_props <- c(A=0.45, B=0.40, AB=0.11, O=0.04)

# Chi-square test
chi_result <- chisq.test(observed, p=expected_props)

cat("Chi-square test results:\n")
print(chi_result)

cat("\nTest statistic:", round(chi_result$statistic, 4), "\n")
cat("P-value:", round(chi_result$p.value, 4), "\n")

# ------------------------------------------------------------------------------
# Exercise 1.4: Practice - Die Fairness
# ------------------------------------------------------------------------------

cat("\n--- Exercise 1.4: Practice - Die Fairness ---\n")

# Observed counts
observed <- c(18, 22, 17, 23, 19, 21)
names(observed) <- paste0("Face_", 1:6)

# Expected proportions (fair die)
expected_props <- rep(1/6, 6)

# Chi-square test
chi_result <- chisq.test(observed, p=expected_props)

cat("Chi-square test results:\n")
print(chi_result)

cat("\nTest statistic:", round(chi_result$statistic, 4), "\n")
cat("P-value:", round(chi_result$p.value, 4), "\n")

# ==============================================================================
# PART 2: CHI-SQUARE TEST OF INDEPENDENCE
# ==============================================================================

cat("\n========== PART 2: CHI-SQUARE TEST OF INDEPENDENCE ==========\n")

# ------------------------------------------------------------------------------
# Exercise 2.1: 2x2 Contingency Table
# ------------------------------------------------------------------------------

cat("\n--- Exercise 2.1: Smoking and Lung Cancer ---\n")

# Create contingency table
data <- matrix(c(85, 55, 15, 45), nrow=2, byrow=TRUE)
rownames(data) <- c("Smoker", "Non-smoker")
colnames(data) <- c("Cancer", "No Cancer")

cat("Contingency table:\n")
print(data)

# Add row and column totals
cat("\nWith marginals:\n")
print(addmargins(data))

# Chi-square test of independence
chi_result <- chisq.test(data, correct=FALSE)

cat("\nChi-square test results:\n")
print(chi_result)

cat("\nTest statistic:", round(chi_result$statistic, 4), "\n")
cat("Degrees of freedom:", chi_result$parameter, "\n")
cat("P-value:", format(chi_result$p.value, scientific=TRUE, digits=4), "\n")

# Expected frequencies
cat("\nExpected frequencies:\n")
print(round(chi_result$expected, 2))

# ------------------------------------------------------------------------------
# Exercise 2.2: Calculating Effect Sizes (Week 9 Preview - Optional)
# ------------------------------------------------------------------------------

cat("\n--- Exercise 2.2: Calculating Effect Sizes ---\n")

# Using the smoking/cancer data from above

# Calculate Relative Risk
p_cancer_smoker <- data[1,1] / sum(data[1,])
p_cancer_nonsmoker <- data[2,1] / sum(data[2,])

relative_risk <- p_cancer_smoker / p_cancer_nonsmoker

cat("Risk Calculations:\n")
cat("==================\n")
cat("Risk of cancer among smokers:", round(p_cancer_smoker, 4), "\n")
cat("Risk of cancer among non-smokers:", round(p_cancer_nonsmoker, 4), "\n")
cat("Relative Risk:", round(relative_risk, 3), "\n\n")

# Calculate Odds Ratio
odds_ratio <- (data[1,1] * data[2,2]) / (data[1,2] * data[2,1])
cat("Odds Ratio:", round(odds_ratio, 3), "\n\n")

# Confidence interval for OR (using log transformation)
a <- data[1,1]
b <- data[1,2]
c <- data[2,1]
d <- data[2,2]

log_or <- log(odds_ratio)
se_log_or <- sqrt(1/a + 1/b + 1/c + 1/d)
ci_log <- log_or + c(-1.96, 1.96) * se_log_or
ci_or <- exp(ci_log)

cat("95% Confidence Interval for OR:\n")
cat("(", round(ci_or[1], 3), ", ", round(ci_or[2], 3), ")\n\n", sep="")

# Interpretation
cat("Interpretation:\n")
cat("- Smokers are", round(relative_risk, 2),
    "times more likely to have lung cancer\n")
cat("- The odds of cancer among smokers are", round(odds_ratio, 2),
    "times the odds among non-smokers\n")
cat("- We're 95% confident the true OR is between",
    round(ci_or[1], 2), "and", round(ci_or[2], 2), "\n")

# ------------------------------------------------------------------------------
# Exercise 2.3: Visualizing 2x2 Tables
# ------------------------------------------------------------------------------

cat("\n--- Exercise 2.3: Visualizing 2x2 Tables ---\n")

# Multiple visualization approaches

par(mfrow=c(2,2))  # 2x2 plot layout

# 1. Mosaic plot
mosaicplot(data, main="Mosaic Plot",
           color=c("red", "lightblue"),
           xlab="Smoking Status", ylab="Cancer Status")

# 2. Grouped barplot (counts)
barplot(data, beside=TRUE, legend=TRUE,
        col=c("darkred", "darkgreen"),
        main="Counts by Group",
        xlab="Cancer Status", ylab="Count",
        args.legend=list(x="topright", title="Smoking"))

# 3. Row proportions (shows risk by smoking status)
prop_row <- prop.table(data, margin=1)
barplot(prop_row, beside=TRUE, legend=TRUE,
        col=c("darkred", "darkgreen"),
        main="Cancer Rate by Smoking Status",
        xlab="Cancer Status", ylab="Proportion",
        args.legend=list(x="topright", title="Smoking"))

# 4. Column proportions (shows smoking distribution by cancer status)
prop_col <- prop.table(data, margin=2)
barplot(prop_col, col=c("darkred", "darkgreen"),
        main="Smoking Distribution by Cancer Status",
        xlab="Cancer Status", ylab="Proportion",
        legend=TRUE,
        args.legend=list(x="topleft", title="Smoking"))

par(mfrow=c(1,1))  # Reset layout

# ------------------------------------------------------------------------------
# Exercise 2.4: Larger Contingency Tables
# ------------------------------------------------------------------------------

cat("\n--- Exercise 2.4: Larger Contingency Tables ---\n")

# Create 3x3 table
data <- matrix(c(45, 20, 5,   # Young
                 30, 35, 15,  # Middle
                 15, 25, 10), # Older
               nrow=3, byrow=TRUE)
rownames(data) <- c("Young (<40)", "Middle (40-60)", "Older (>60)")
colnames(data) <- c("Mild", "Moderate", "Severe")

cat("Disease Severity by Age Group:\n")
print(data)
cat("\nWith margins:\n")
print(addmargins(data))

# Chi-square test
chi_result <- chisq.test(data)

cat("\nChi-square Test:\n")
cat("================\n")
cat("Test statistic:", round(chi_result$statistic, 3), "\n")
cat("Degrees of freedom:", chi_result$parameter, "\n")
cat("P-value:", format.pval(chi_result$p.value, digits=4), "\n\n")

# Expected counts
cat("Expected counts:\n")
print(round(chi_result$expected, 2))

# Standardized residuals (show which cells contribute most)
std_residuals <- chi_result$residuals
cat("\nStandardized Residuals:\n")
cat("(Values > 2 or < -2 indicate major contributors to chi-square)\n")
print(round(std_residuals, 2))

# Visualization
mosaicplot(data, main="Disease Severity by Age Group",
           color=c("lightgreen", "yellow", "red"),
           xlab="Age Group", ylab="Severity")

# ------------------------------------------------------------------------------
# Exercise 2.5: Practice - Treatment Efficacy
# ------------------------------------------------------------------------------

cat("\n--- Exercise 2.5: Practice - Treatment Efficacy ---\n")

# Enter data
data <- matrix(c(48, 12,   # Drug: cured, not cured
                 32, 28),  # Placebo: cured, not cured
               nrow=2, byrow=TRUE)
rownames(data) <- c("Drug", "Placebo")
colnames(data) <- c("Cured", "Not Cured")

# Display table
cat("Treatment Efficacy Study:\n")
print(addmargins(data))

# Chi-square test
chi_result <- chisq.test(data, correct=FALSE)
cat("\nChi-square test:\n")
print(chi_result)

# Calculate effect sizes
rr <- (data[1,1]/sum(data[1,])) / (data[2,1]/sum(data[2,]))
or <- (data[1,1]*data[2,2]) / (data[1,2]*data[2,1])

cat("\nEffect Sizes:\n")
cat("Relative Risk:", round(rr, 3), "\n")
cat("Odds Ratio:", round(or, 3), "\n")

# Visualize
barplot(prop.table(data, margin=1), beside=TRUE,
        col=c("steelblue", "coral"),
        legend=TRUE, main="Cure Rates by Treatment",
        xlab="Outcome", ylab="Proportion")

# ==============================================================================
# PART 3: FISHER'S EXACT TEST
# ==============================================================================

cat("\n========== PART 3: FISHER'S EXACT TEST ==========\n")

# ------------------------------------------------------------------------------
# Exercise 3.1: Small Sample Example
# ------------------------------------------------------------------------------

cat("\n--- Exercise 3.1: Small Sample Example ---\n")

# Small sample data
data <- matrix(c(8, 2,   # Exposed: disease, no disease
                 3, 7),  # Not exposed: disease, no disease
               nrow=2, byrow=TRUE)
rownames(data) <- c("Exposed", "Not Exposed")
colnames(data) <- c("Disease", "No Disease")

cat("Small Sample Study:\n")
print(data)
print(addmargins(data))

# Check chi-square assumptions
chi_result <- chisq.test(data, correct=FALSE)
cat("\nExpected counts:\n")
print(round(chi_result$expected, 2))

cat("\nNote: Some expected counts < 5, so Fisher's exact test preferred\n\n")

# Fisher's exact test
fisher_result <- fisher.test(data)

cat("Fisher's Exact Test Results:\n")
cat("=============================\n")
print(fisher_result)

cat("\nKey results:\n")
cat("P-value (two-sided):", round(fisher_result$p.value, 4), "\n")
cat("Odds Ratio estimate:", round(fisher_result$estimate, 3), "\n")
cat("95% CI for OR: (",
    round(fisher_result$conf.int[1], 3), ", ",
    round(fisher_result$conf.int[2], 3), ")\n", sep="")

# ------------------------------------------------------------------------------
# Exercise 3.2: Comparing Fisher's vs Chi-Square
# ------------------------------------------------------------------------------

cat("\n--- Exercise 3.2: Comparing Fisher's vs Chi-Square ---\n")

# For comparison purposes with same data

cat("Comparison of Tests:\n")
cat("====================\n\n")

# Chi-square test (for comparison, though not ideal here)
chi_result <- chisq.test(data, correct=FALSE)
cat("Chi-square test:\n")
cat("  Test statistic:", round(chi_result$statistic, 3), "\n")
cat("  P-value:", round(chi_result$p.value, 4), "\n\n")

# Fisher's exact test
fisher_result <- fisher.test(data)
cat("Fisher's exact test:\n")
cat("  P-value:", round(fisher_result$p.value, 4), "\n")
cat("  Odds Ratio:", round(fisher_result$estimate, 3), "\n")
cat("  95% CI:", round(fisher_result$conf.int, 3), "\n\n")

cat("Note: Fisher's exact test is more reliable for small samples\n")
cat("Chi-square may give misleading results when expected counts < 5\n")

# ------------------------------------------------------------------------------
# Exercise 3.3: Practice - Medical Device Study
# ------------------------------------------------------------------------------

cat("\n--- Exercise 3.3: Practice - Medical Device Study ---\n")

# Very small pilot study
data <- matrix(c(5, 1,   # New device: success, failure
                 2, 6),  # Standard: success, failure
               nrow=2, byrow=TRUE)
rownames(data) <- c("New Device", "Standard")
colnames(data) <- c("Success", "Failure")

# Use Fisher's exact test
fisher_result <- fisher.test(data)

cat("Medical Device Pilot Study:\n")
print(data)
cat("\nFisher's Exact Test:\n")
print(fisher_result)

# Interpretation
if (fisher_result$p.value < 0.05) {
  cat("\nConclusion: Significant difference between devices (p < 0.05)\n")
} else {
  cat("\nConclusion: No significant difference found (p >= 0.05)\n")
}

# ==============================================================================
# PART 4: MCNEMAR'S TEST FOR PAIRED DATA
# ==============================================================================

cat("\n========== PART 4: MCNEMAR'S TEST FOR PAIRED DATA ==========\n")

# ------------------------------------------------------------------------------
# Exercise 4.1: Before-After Treatment Study
# ------------------------------------------------------------------------------

cat("\n--- Exercise 4.1: Before-After Treatment Study ---\n")

# Create paired data table
# Rows = Before, Columns = After
data <- matrix(c(10, 20,   # Before Positive: After Pos, After Neg
                 5, 15),   # Before Negative: After Pos, After Neg
               nrow=2, byrow=TRUE)
rownames(data) <- c("Before: Positive", "Before: Negative")
colnames(data) <- c("After: Positive", "After: Negative")

cat("Before-After Study (Paired Data):\n")
print(data)
cat("\nTotal patients:", sum(data), "\n")

# Count discordant pairs
cat("\nDiscordant pairs:\n")
cat("  Positive -> Negative:", data[1,2], "\n")
cat("  Negative -> Positive:", data[2,1], "\n")

# McNemar's test
mcnemar_result <- mcnemar.test(data, correct=FALSE)

cat("\nMcNemar's Test Results:\n")
cat("=======================\n")
print(mcnemar_result)

# Interpretation
cat("\nInterpretation:\n")
if (mcnemar_result$p.value < 0.05) {
  cat("There IS a significant change in infection status after treatment\n")
  if (data[1,2] > data[2,1]) {
    cat("Treatment appears effective (more patients became negative)\n")
  }
} else {
  cat("No significant change in infection status after treatment\n")
}

# ------------------------------------------------------------------------------
# Exercise 4.2: Matched Case-Control Study
# ------------------------------------------------------------------------------

cat("\n--- Exercise 4.2: Matched Case-Control Study ---\n")

# Matched pairs: cases and controls
# Each case matched with a control on age, sex, etc.
data <- matrix(c(15, 8,    # Case exposed: Control exposed, not exposed
                 5, 30),   # Case not exposed: Control exposed, not exposed
               nrow=2, byrow=TRUE)
rownames(data) <- c("Case: Exposed", "Case: Not Exposed")
colnames(data) <- c("Control: Exposed", "Control: Not Exposed")

cat("Matched Case-Control Study:\n")
print(data)

# NOTE: Standard chi-square would be WRONG here (violates independence)
cat("\nWARNING: Cannot use standard chi-square test!\n")
cat("Pairs are matched (not independent)\n\n")

# Correct test: McNemar's
mcnemar_result <- mcnemar.test(data, correct=FALSE)

cat("McNemar's Test (correct for matched data):\n")
print(mcnemar_result)

# Calculate Odds Ratio for matched pairs
or_matched <- data[1,2] / data[2,1]
cat("\nOdds Ratio (matched pairs):", round(or_matched, 3), "\n")

# ==============================================================================
# PART 5: COMPREHENSIVE EXAMPLE - VACCINE EFFICACY
# ==============================================================================

cat("\n========== PART 5: COMPREHENSIVE EXAMPLE ==========\n")

# ------------------------------------------------------------------------------
# Exercise 5.1: Vaccine Efficacy Study
# ------------------------------------------------------------------------------

cat("\n--- Exercise 5.1: Vaccine Efficacy Study ---\n")

# Create data
data <- matrix(c(30, 470,    # Vaccinated: disease, no disease
                 85, 415),   # Placebo: disease, no disease
               nrow=2, byrow=TRUE)
rownames(data) <- c("Vaccinated", "Placebo")
colnames(data) <- c("Disease", "No Disease")

cat("========================================\n")
cat("Vaccine Efficacy Study Analysis\n")
cat("========================================\n\n")

# Display data
cat("Contingency Table:\n")
print(data)
print(addmargins(data))

# 1. Chi-square test
cat("\n\n1. CHI-SQUARE TEST OF INDEPENDENCE\n")
cat("------------------------------------\n")
chi_result <- chisq.test(data, correct=FALSE)
print(chi_result)

cat("\nExpected counts:\n")
print(round(chi_result$expected, 2))

# 2. Effect sizes
cat("\n\n2. EFFECT SIZES\n")
cat("----------------\n")

# Incidence rates
inc_vax <- data[1,1] / sum(data[1,])
inc_placebo <- data[2,1] / sum(data[2,])

cat("Disease incidence:\n")
cat("  Vaccinated:", round(inc_vax * 100, 2), "%\n")
cat("  Placebo:", round(inc_placebo * 100, 2), "%\n\n")

# Relative Risk
rr <- inc_vax / inc_placebo
cat("Relative Risk:", round(rr, 3), "\n")

# Vaccine Efficacy
ve <- (1 - rr) * 100
cat("Vaccine Efficacy:", round(ve, 2), "%\n\n")

# Odds Ratio
or <- (data[1,1] * data[2,2]) / (data[1,2] * data[2,1])
cat("Odds Ratio:", round(or, 3), "\n")

# 95% CI for OR
a <- data[1,1]; b <- data[1,2]; c <- data[2,1]; d <- data[2,2]
log_or <- log(or)
se_log_or <- sqrt(1/a + 1/b + 1/c + 1/d)
ci_or <- exp(log_or + c(-1.96, 1.96) * se_log_or)
cat("95% CI for OR: (", round(ci_or[1], 3), ", ",
    round(ci_or[2], 3), ")\n\n", sep="")

# 3. Interpretation
cat("\n3. INTERPRETATION\n")
cat("------------------\n")
cat("Statistical significance: p", ifelse(chi_result$p.value < 0.001,
    "< 0.001", paste("=", round(chi_result$p.value, 4))), "\n")
cat("  -> Strong evidence of association between vaccination and disease\n\n")

cat("Vaccine efficacy:", round(ve, 1), "%\n")
cat("  -> Vaccine reduces disease risk by", round(ve, 1), "%\n\n")

cat("Clinical interpretation:\n")
cat("  The vaccine significantly reduces disease incidence.\n")
cat("  Vaccinated individuals have", round((1-rr)*100, 1),
    "% lower risk than unvaccinated.\n")

# 4. Visualization
cat("\n\n4. VISUALIZATION\n")
cat("-----------------\n")

par(mfrow=c(1,2))

# Incidence comparison
inc_data <- c(inc_vax, inc_placebo) * 100
names(inc_data) <- c("Vaccinated", "Placebo")
barplot(inc_data, col=c("steelblue", "coral"),
        main="Disease Incidence by Group",
        ylab="Incidence (%)", ylim=c(0, max(inc_data)*1.2))
text(x=c(0.7, 1.9), y=inc_data + 1, labels=paste0(round(inc_data, 1), "%"))

# Mosaic plot
mosaicplot(data, main="Disease Status by Vaccination",
           color=c("red", "lightgreen"),
           xlab="Vaccination Status", ylab="Disease Status")

par(mfrow=c(1,1))

cat("\nAnalysis complete!\n")

# ==============================================================================
# PRACTICE PROBLEMS
# ==============================================================================

cat("\n========== PRACTICE PROBLEMS ==========\n")

# ------------------------------------------------------------------------------
# Problem 1: Educational Attainment
# ------------------------------------------------------------------------------

cat("\n--- Problem 1: Educational Attainment ---\n")

# Sample: No HS (8), HS (42), Bachelor's (55), Graduate (35)
observed <- c(NoHS=8, HS=42, Bachelors=55, Graduate=35)

# National proportions: No HS (12%), HS (30%), Bachelor's (35%), Graduate (23%)
expected_props <- c(NoHS=0.12, HS=0.30, Bachelors=0.35, Graduate=0.23)

# Chi-square goodness-of-fit test
chi_result <- chisq.test(observed, p=expected_props)

cat("Educational Attainment - Goodness of Fit Test\n")
print(chi_result)

cat("\nTest statistic:", round(chi_result$statistic, 4), "\n")
cat("P-value:", round(chi_result$p.value, 4), "\n")

# ------------------------------------------------------------------------------
# Problem 2: Drug Side Effects
# ------------------------------------------------------------------------------

cat("\n--- Problem 2: Drug Side Effects ---\n")

# Drug A: 15 with side effects, 85 without
# Drug B: 28 with side effects, 72 without
data <- matrix(c(15, 85, 28, 72), nrow=2, byrow=TRUE)
rownames(data) <- c("Drug A", "Drug B")
colnames(data) <- c("Side Effects", "No Side Effects")

cat("Drug Side Effects Data:\n")
print(data)

# a) Perform chi-square test
chi_result <- chisq.test(data, correct=FALSE)
cat("\nChi-square test:\n")
print(chi_result)

# b) Calculate and interpret relative risk
p_se_drugA <- data[1,1] / sum(data[1,])
p_se_drugB <- data[2,1] / sum(data[2,])
rr <- p_se_drugA / p_se_drugB

cat("\nRelative Risk:", round(rr, 3), "\n")
cat("Drug A has", round(rr, 2), "times the risk of side effects compared to Drug B\n")

# c) Calculate and interpret odds ratio with 95% CI
or <- (data[1,1] * data[2,2]) / (data[1,2] * data[2,1])
a <- data[1,1]; b <- data[1,2]; c <- data[2,1]; d <- data[2,2]
log_or <- log(or)
se_log_or <- sqrt(1/a + 1/b + 1/c + 1/d)
ci_or <- exp(log_or + c(-1.96, 1.96) * se_log_or)

cat("Odds Ratio:", round(or, 3), "\n")
cat("95% CI: (", round(ci_or[1], 3), ", ", round(ci_or[2], 3), ")\n", sep="")

# d) Create a visualization
barplot(prop.table(data, margin=1), beside=TRUE,
        col=c("coral", "steelblue"),
        legend=TRUE, main="Side Effect Rates by Drug",
        xlab="Side Effect Status", ylab="Proportion")

# ------------------------------------------------------------------------------
# Problem 3: Coffee and Heart Disease
# ------------------------------------------------------------------------------

cat("\n--- Problem 3: Coffee and Heart Disease ---\n")

# Coffee (disease=4, none=8), No coffee (disease=1, none=7)
data <- matrix(c(4, 8, 1, 7), nrow=2, byrow=TRUE)
rownames(data) <- c("Coffee Drinker", "Non-drinker")
colnames(data) <- c("Heart Disease", "No Heart Disease")

cat("Coffee and Heart Disease Study:\n")
print(data)

# a) Check if chi-square assumptions are met
chi_result <- chisq.test(data, correct=FALSE)
cat("\nExpected frequencies:\n")
print(round(chi_result$expected, 2))
cat("Some expected counts < 5, so Fisher's exact test is appropriate\n")

# b) Perform Fisher's exact test
fisher_result <- fisher.test(data)
cat("\nFisher's Exact Test:\n")
print(fisher_result)

# c) Interpret the results
cat("\nP-value:", round(fisher_result$p.value, 4), "\n")
cat("Odds Ratio:", round(fisher_result$estimate, 4), "\n")
if (fisher_result$p.value < 0.05) {
  cat("Conclusion: Significant association between coffee and heart disease (p < 0.05)\n")
} else {
  cat("Conclusion: No significant association found (p >= 0.05)\n")
}

# ------------------------------------------------------------------------------
# Problem 4: Depression Treatment
# ------------------------------------------------------------------------------

cat("\n--- Problem 4: Depression Treatment ---\n")

# Before depressed/After depressed (12)
# Before depressed/After not (18)
# Before not/After depressed (3)
# Before not/After not (7)
data <- matrix(c(12, 18, 3, 7), nrow=2, byrow=TRUE)
rownames(data) <- c("Before: Depressed", "Before: Not Depressed")
colnames(data) <- c("After: Depressed", "After: Not Depressed")

cat("Depression Treatment Study (Paired Data):\n")
print(data)

# a) Why is McNemar's test appropriate?
cat("\nMcNemar's test is appropriate because:\n")
cat("- Same patients measured before and after (paired data)\n")
cat("- Observations are not independent\n")
cat("- Standard chi-square would be incorrect\n")

# b) Perform the test
mcnemar_result <- mcnemar.test(data, correct=FALSE)
cat("\nMcNemar's Test:\n")
print(mcnemar_result)

# c) Interpret the results
cat("\nP-value:", round(mcnemar_result$p.value, 4), "\n")
cat("Discordant pairs: Improved=", data[1,2], ", Worsened=", data[2,1], "\n", sep="")
if (mcnemar_result$p.value < 0.05) {
  cat("Conclusion: Significant change in depression status (p < 0.05)\n")
  if (data[1,2] > data[2,1]) {
    cat("Treatment appears effective (more improved than worsened)\n")
  }
} else {
  cat("Conclusion: No significant change in depression status (p >= 0.05)\n")
}

# ==============================================================================
# SAVE YOUR WORK
# ==============================================================================

cat("\n========== SAVE YOUR WORK ==========\n")

# At the top of your R script, add:
# Name: Your Name
# Date: Today's Date
# Lab: Week 8 - Contingency Tables and Chi-Square Tests

# Save your workspace
save.image("week8_lab.RData")

# To load it later:
# load("week8_lab.RData")

# Save specific objects
# save(data, chi_result, fisher_result, file="week8_results.RData")

cat("\nWorkspace saved to week8_lab.RData\n")
cat("\n========== END OF LAB CODE ==========\n")
