#!/usr/bin/env Rscript
# ============================================================================
# VERIFICATION SCRIPT: Week 6 ANOVA Worksheet - All Answers
# ============================================================================
# This script computes ALL numerical answers for the Week 6 worksheet
# Following CLAUDE.md mandate: NEVER use mental math, ALWAYS verify with R
# ============================================================================

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 6 WORKSHEET - VERIFIED ANSWERS\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

# ============================================================================
# PROBLEM 1: Statistical Power
# ============================================================================
cat("PROBLEM 1: Statistical Power\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Parameters
mu0 <- 140  # Current mean BP
mu1 <- 135  # Target mean BP (5 mmHg reduction)
sigma <- 18  # SD
alpha <- 0.05

cat("Parameters: mu0=140, mu1=135, delta=5, sd=18, alpha=0.05\n\n")

# Part A: Power with n=50
cat("Part A: Power with n=50\n")
result_a <- power.t.test(n = 50, delta = 5, sd = 18,
                         sig.level = 0.05, type = "one.sample")
cat("Power:", round(result_a$power, 4), "(", round(result_a$power*100, 1), "%)\n\n")

# Part B: Sample size for 80% power
cat("Part B: Sample size for 80% power\n")
result_b <- power.t.test(delta = 5, sd = 18, sig.level = 0.05,
                         power = 0.80, type = "one.sample")
cat("Required n:", round(result_b$n, 2), "\n")
cat("Ceiling n:", ceiling(result_b$n), "patients\n\n")

# Part C: Interpretation (text answer)
cat("Part C: What does 80% power mean?\n")
cat("ANSWER: If the drug truly reduces BP by 5 mmHg, we have an 80% chance\n")
cat("        of detecting this effect (rejecting H0) with our study.\n\n")

# Part D: Smallest detectable effect with n=100
cat("Part D: Smallest effect detectable with n=100 at 80% power\n")
result_d <- power.t.test(n = 100, sd = 18, sig.level = 0.05,
                         power = 0.80, type = "one.sample")
cat("Minimum delta:", round(result_d$delta, 2), "mmHg\n\n")

# ============================================================================
# PROBLEM 2: Two-Sample t-Test (Weight Loss)
# ============================================================================
cat("PROBLEM 2: Two-Sample t-Test\n")
cat(paste(rep("-", 70), collapse=""), "\n")

diet_a <- c(3.2, 4.5, 2.8, 5.1, 3.9, 4.2, 3.6, 4.8, 3.3, 4.0, 3.7, 4.4)
diet_b <- c(5.2, 6.1, 4.8, 5.9, 5.5, 6.3, 5.0, 5.7, 5.4, 6.0, 5.3, 5.8)

# Part A: Summary statistics
cat("Part A: Summary Statistics\n")
cat("Diet A: mean =", round(mean(diet_a), 2), "kg, SD =",
    round(sd(diet_a), 2), "kg, n =", length(diet_a), "\n")
cat("Diet B: mean =", round(mean(diet_b), 2), "kg, SD =",
    round(sd(diet_b), 2), "kg, n =", length(diet_b), "\n\n")

# Part B: Hypotheses (text)
cat("Part B: Hypotheses\n")
cat("H0: mu_A = mu_B (or mu_B - mu_A = 0)\n")
cat("HA: mu_B > mu_A (Diet B results in greater weight loss)\n\n")

# Part C: Two-sample t-test
cat("Part C: Two-sample t-test (one-sided, Diet B > Diet A)\n")
result_2c <- t.test(diet_b, diet_a, var.equal = TRUE, alternative = "greater")
cat("t-statistic:", round(result_2c$statistic, 3), "\n")
cat("df:", result_2c$parameter, "\n")
cat("p-value:", format(result_2c$p.value, scientific = TRUE), "\n\n")

# Part D: Conclusion
cat("Part D: Conclusion\n")
if (result_2c$p.value < 0.05) {
  cat("Since p <", result_2c$p.value, "< 0.05, we reject H0.\n")
  cat("There is strong evidence that Diet B results in significantly greater\n")
  cat("weight loss than Diet A (mean difference =",
      round(mean(diet_b) - mean(diet_a), 2), "kg).\n\n")
} else {
  cat("Since p = ", result_2c$p.value, "> 0.05, we fail to reject H0.\n\n")
}

# Part E: 95% CI
cat("Part E: 95% Confidence Interval for mu_B - mu_A\n")
result_2e <- t.test(diet_b, diet_a, var.equal = TRUE, conf.level = 0.95)
cat("95% CI: (", round(result_2e$conf.int[1], 2), ",",
    round(result_2e$conf.int[2], 2), ") kg\n")
cat("Interpretation: We are 95% confident the true difference in mean weight\n")
cat("loss (Diet B - Diet A) is between", round(result_2e$conf.int[1], 2),
    "and", round(result_2e$conf.int[2], 2), "kg.\n\n")

# ============================================================================
# PROBLEM 3: Paired t-Test (Knee Flexibility)
# ============================================================================
cat("PROBLEM 3: Paired t-Test\n")
cat(paste(rep("-", 70), collapse=""), "\n")

before <- c(115, 110, 120, 105, 118, 112, 108, 122, 114, 116)
after <- c(125, 120, 128, 115, 130, 122, 118, 135, 124, 126)

# Part A: Differences
differences <- after - before
cat("Part A: Differences (After - Before)\n")
cat("Differences:", paste(differences, collapse=", "), "\n\n")

# Part B: Mean and SD of differences
cat("Part B: Mean and SD of differences\n")
mean_diff <- mean(differences)
sd_diff <- sd(differences)
cat("Mean difference (d̄):", round(mean_diff, 2), "degrees\n")
cat("SD of differences (sd):", round(sd_diff, 2), "degrees\n\n")

# Part C: Hypotheses
cat("Part C: Hypotheses\n")
cat("H0: mu_d = 0 (no improvement in flexibility)\n")
cat("HA: mu_d > 0 (flexibility improves after treatment)\n\n")

# Part D: Paired t-test
cat("Part D: Paired t-test\n")
result_3d <- t.test(differences, mu = 0, alternative = "greater")
cat("t-statistic:", round(result_3d$statistic, 3), "\n")
cat("df:", result_3d$parameter, "\n")
cat("p-value:", format(result_3d$p.value, scientific = TRUE), "\n\n")

# Part E: Conclusion
cat("Part E: Conclusion\n")
cat("Since p < 0.001, there is very strong evidence that the treatment\n")
cat("significantly improves knee flexibility. On average, flexibility\n")
cat("increased by", round(mean_diff, 1), "degrees.\n\n")

# Part F: Why paired test? (text)
cat("Part F: Why not independent two-sample test?\n")
cat("ANSWER: Because the same patients are measured twice (before/after).\n")
cat("The observations are dependent. Using independent t-test would ignore\n")
cat("the pairing and lose power by not controlling for between-subject\n")
cat("variability.\n\n")

# ============================================================================
# PROBLEM 4: One-Way ANOVA (Exercise Programs)
# ============================================================================
cat("PROBLEM 4: One-Way ANOVA\n")
cat(paste(rep("-", 70), collapse=""), "\n")

walking <- c(3.2, 2.8, 3.5, 3.0, 3.3)
swimming <- c(4.5, 4.8, 4.2, 4.6, 4.4)
cycling <- c(5.8, 6.1, 5.5, 6.0, 5.7)
gym <- c(6.2, 6.5, 5.8, 6.3, 6.0)

# Verify means and SDs from worksheet
cat("Verify group statistics from worksheet:\n")
cat("Walking: mean =", round(mean(walking), 2), ", SD =", round(sd(walking), 2), "\n")
cat("Swimming: mean =", round(mean(swimming), 2), ", SD =", round(sd(swimming), 2), "\n")
cat("Cycling: mean =", round(mean(cycling), 2), ", SD =", round(sd(cycling), 2), "\n")
cat("Gym: mean =", round(mean(gym), 2), ", SD =", round(sd(gym), 2), "\n\n")

# Part A: Hypotheses
cat("Part A: Hypotheses\n")
cat("H0: mu_walking = mu_swimming = mu_cycling = mu_gym (all means equal)\n")
cat("HA: At least one mean differs\n\n")

# Part B: Why ANOVA? (text)
cat("Part B: Why ANOVA instead of multiple t-tests?\n")
cat("ANSWER: Multiple pairwise t-tests inflate Type I error rate. With 4 groups,\n")
cat("we'd need 6 comparisons, giving overall alpha ~ 0.26 instead of 0.05.\n")
cat("ANOVA controls family-wise error rate at 0.05.\n\n")

# Part C: ANOVA
cat("Part C: One-Way ANOVA\n")
weight_loss <- c(walking, swimming, cycling, gym)
program <- factor(rep(c("Walking", "Swimming", "Cycling", "Gym"), each=5),
                  levels=c("Walking", "Swimming", "Cycling", "Gym"))
data_anova <- data.frame(weight_loss, program)

model <- aov(weight_loss ~ program, data=data_anova)
anova_result <- summary(model)[[1]]

cat("F-statistic:", round(anova_result["program", "F value"], 2), "\n")
cat("df1 (between):", anova_result["program", "Df"], "\n")
cat("df2 (within):", anova_result["Residuals", "Df"], "\n")
cat("p-value:", format(anova_result["program", "Pr(>F)"], scientific=TRUE), "\n\n")

# Part D: Conclusion
cat("Part D: Conclusion\n")
cat("Since p < 0.001, we reject H0. There is very strong evidence that\n")
cat("the four exercise programs differ in effectiveness for weight loss.\n\n")

# Part E: Tukey's HSD
cat("Part E: Tukey's HSD Post-Hoc Test\n")
tukey_result <- TukeyHSD(model)
print(tukey_result)

cat("\nSignificant pairwise comparisons (p < 0.05):\n")
sig_comps <- tukey_result$program[tukey_result$program[, "p adj"] < 0.05, ]
for (i in 1:nrow(sig_comps)) {
  cat("-", rownames(sig_comps)[i], ": p =",
      format(sig_comps[i, "p adj"], scientific=TRUE), "\n")
}
cat("\n")

# Part F: Recommendation
cat("Part F: Recommendation\n")
cat("Based on the analysis, Gym workouts result in the highest mean weight\n")
cat("loss (6.16 kg), followed by Cycling (5.82 kg). Both are significantly\n")
cat("better than Walking (3.16 kg) and Swimming (4.50 kg).\n")
cat("Recommendation: Gym or Cycling programs for maximum weight loss.\n\n")

# ============================================================================
# PROBLEM 5: Choosing the Right Test
# ============================================================================
cat("PROBLEM 5: Choosing the Right Test\n")
cat(paste(rep("-", 70), collapse=""), "\n")

cat("Scenario A (glucose before/after medication):\n")
cat("  Test: Paired t-test\n")
cat("  Reason: Same patients measured twice (dependent samples)\n\n")

cat("Scenario B (IQ scores, preschool vs no preschool):\n")
cat("  Test: Two-sample t-test (independent samples)\n")
cat("  Reason: Two independent groups being compared\n\n")

cat("Scenario C (satisfaction across 5 hospitals):\n")
cat("  Test: One-way ANOVA\n")
cat("  Reason: Comparing means across more than 2 groups\n\n")

cat("Scenario D (fertilizer comparison, split fields):\n")
cat("  Test: Paired t-test\n")
cat("  Reason: Each field serves as its own control (paired design)\n\n")

cat("Scenario E (sample size for pain reduction trial):\n")
cat("  Test/Analysis: Power analysis using power.t.test()\n")
cat("  Reason: Need to determine required sample size for desired power\n\n")

# ============================================================================
# FINAL SUMMARY
# ============================================================================
cat(paste(rep("=", 70), collapse=""), "\n")
cat("ALL WORKSHEET ANSWERS VERIFIED\n")
cat("All numerical values computed using R (no mental math)\n")
cat("Ready to create answer key LaTeX file\n")
cat(paste(rep("=", 70), collapse=""), "\n")
