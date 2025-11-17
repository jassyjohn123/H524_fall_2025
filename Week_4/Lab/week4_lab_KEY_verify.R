#!/usr/bin/env Rscript
# Week 4 Lab - Verification Script for Answer Key
# All numerical answers for the answer key are computed below

cat("======================================================================\n")
cat("WEEK 4 LAB ANSWER KEY - COMPUTATIONAL VERIFICATION\n")
cat("All answers computed using R for accuracy verification\n")
cat("======================================================================\n\n")

# ==============================================================================
# PROBLEM 1: Clinical Trial
# ==============================================================================
cat("PROBLEM 1: Clinical Trial (Cholesterol Reduction)\n")
cat("======================================================================\n\n")

# Given
n <- 30
xbar <- 28
s <- 12

cat("Given: n = 30, x̄ = 28 mg/dL, s = 12 mg/dL\n\n")

# Part (a): 95% CI
cat("Part (a): 95% Confidence Interval\n")
cat(paste(rep("-", 40), collapse=""), "\n", sep="")

SE <- s / sqrt(n)
df <- n - 1
t_crit_95 <- qt(0.975, df)
ME_95 <- t_crit_95 * SE
lower_95 <- xbar - ME_95
upper_95 <- xbar + ME_95

cat("SE = s/√n =", s, "/√", n, "=", round(SE, 4), "\n")
cat("df = n - 1 =", df, "\n")
cat("t(0.975, 29) =", round(t_crit_95, 4), "\n")
cat("ME = t × SE =", round(t_crit_95, 4), "×", round(SE, 4), "=", round(ME_95, 4), "\n")
cat("95% CI = (", round(lower_95, 2), ", ", round(upper_95, 2), ") mg/dL\n\n", sep="")

# Part (b): 99% CI
cat("Part (b): 99% Confidence Interval\n")
cat(paste(rep("-", 40), collapse=""), "\n", sep="")

t_crit_99 <- qt(0.995, df)
ME_99 <- t_crit_99 * SE
lower_99 <- xbar - ME_99
upper_99 <- xbar + ME_99

cat("t(0.995, 29) =", round(t_crit_99, 4), "\n")
cat("ME = t × SE =", round(t_crit_99, 4), "×", round(SE, 4), "=", round(ME_99, 4), "\n")
cat("99% CI = (", round(lower_99, 2), ", ", round(upper_99, 2), ") mg/dL\n\n", sep="")

# Part (d): Does CI support >= 25 mg/dL?
cat("Part (d): Does CI support reduction >= 25 mg/dL?\n")
cat(paste(rep("-", 40), collapse=""), "\n", sep="")
cat("95% CI = (", round(lower_95, 2), ", ", round(upper_95, 2), ")\n", sep="")
if (lower_95 >= 25) {
  cat("Result: YES - entire CI is above 25\n\n")
} else if (upper_95 < 25) {
  cat("Result: NO - entire CI is below 25\n\n")
} else {
  cat("Result: UNCLEAR - CI includes values both above and below 25\n")
  cat("Lower bound 23.52 < 25 means values < 25 are plausible\n\n")
}

# ==============================================================================
# PROBLEM 2: Adverse Events
# ==============================================================================
cat("\nPROBLEM 2: Adverse Events (Proportion)\n")
cat("======================================================================\n\n")

x <- 8
n_adv <- 150

cat("Given: x = 8 adverse events, n = 150 patients\n\n")

# Part (a): Check conditions
cat("Part (a): Check normal approximation conditions\n")
cat(paste(rep("-", 40), collapse=""), "\n", sep="")

p_hat <- x / n_adv
np <- n_adv * p_hat
n_1minusp <- n_adv * (1 - p_hat)

cat("p̂ = x/n = 8/150 =", round(p_hat, 4), "\n")
cat("np̂ =", round(np, 2), "(need >= 10)\n")
cat("n(1-p̂) =", round(n_1minusp, 2), "(need >= 10)\n")
cat("Assessment: Normal approximation is QUESTIONABLE (np̂ < 10)\n\n")

# Part (b): 95% CI using Wald method
cat("Part (b): 95% CI for proportion (Wald method)\n")
cat(paste(rep("-", 40), collapse=""), "\n", sep="")

SE_p <- sqrt(p_hat * (1 - p_hat) / n_adv)
z_crit <- qnorm(0.975)
ME_p <- z_crit * SE_p
lower_p <- p_hat - ME_p
upper_p <- p_hat + ME_p

cat("SE = √[p̂(1-p̂)/n] = √[", round(p_hat, 4), "×", round(1-p_hat, 4), "/150]\n", sep="")
cat("   = √", round(p_hat * (1-p_hat) / n_adv, 6), "=", round(SE_p, 4), "\n", sep="")
cat("z(0.975) =", round(z_crit, 4), "\n")
cat("ME = z × SE =", round(z_crit, 4), "×", round(SE_p, 4), "=", round(ME_p, 4), "\n")
cat("Wald CI = (", round(lower_p, 4), ", ", round(upper_p, 4), ")\n\n", sep="")

# Using prop.test for more accurate interval
cat("95% CI using prop.test() (continuity correction):\n")
result_prop <- prop.test(x, n_adv, conf.level = 0.95)
prop_lower <- result_prop$conf.int[1]
prop_upper <- result_prop$conf.int[2]
cat("Wilson score CI = (", round(prop_lower, 4), ", ", round(prop_upper, 4), ")\n\n", sep="")

# Part (c): Express as percentage
cat("Part (c): Express as percentage\n")
cat(paste(rep("-", 40), collapse=""), "\n", sep="")
cat("Wald 95% CI = (", round(lower_p*100, 2), "%, ", round(upper_p*100, 2), "%)\n", sep="")
cat("Wilson 95% CI = (", round(prop_lower*100, 2), "%, ", round(prop_upper*100, 2), "%)\n\n", sep="")

# ==============================================================================
# PROBLEM 3: Sample Size
# ==============================================================================
cat("\nPROBLEM 3: Study Planning (Sample Size)\n")
cat("======================================================================\n\n")

sigma <- 0.7
z <- qnorm(0.975)

cat("Given: σ = 0.7°F, 95% confidence (z = 1.96)\n\n")

# Part (a): ME = 0.2
cat("Part (a): Sample size for ME = 0.2°F\n")
cat(paste(rep("-", 40), collapse=""), "\n", sep="")

ME_a <- 0.2
n_a <- (z * sigma / ME_a)^2
n_a_rounded <- ceiling(n_a)

cat("n = (z × σ / ME)²\n")
cat("  = (", round(z, 4), "×", sigma, "/", ME_a, ")²\n", sep="")
cat("  = (", round(z * sigma, 3), "/", ME_a, ")²\n", sep="")
cat("  = (", round(z * sigma / ME_a, 2), ")²\n", sep="")
cat("  =", round(n_a, 2), "\n")
cat("Rounded UP: n =", n_a_rounded, "subjects\n\n")

# Part (b): ME = 0.1
cat("Part (b): Sample size for ME = 0.1°F\n")
cat(paste(rep("-", 40), collapse=""), "\n", sep="")

ME_b <- 0.1
n_b <- (z * sigma / ME_b)^2
n_b_rounded <- ceiling(n_b)

cat("n = (z × σ / ME)²\n")
cat("  = (", round(z, 4), "×", sigma, "/", ME_b, ")²\n", sep="")
cat("  = (", round(z * sigma, 3), "/", ME_b, ")²\n", sep="")
cat("  = (", round(z * sigma / ME_b, 2), ")²\n", sep="")
cat("  =", round(n_b, 2), "\n")
cat("Rounded UP: n =", n_b_rounded, "subjects\n\n")

# Part (c): Effect of doubling precision
cat("Part (c): Effect of doubling precision\n")
cat(paste(rep("-", 40), collapse=""), "\n", sep="")

factor_increase <- n_b_rounded / n_a_rounded
cat("ME: 0.2 → 0.1 (halved, precision doubled)\n")
cat("n: ", n_a_rounded, " → ", n_b_rounded, " (increased by factor of ", round(factor_increase, 2), ")\n\n", sep="")
cat("Relationship: Halving ME requires quadrupling sample size (2² = 4)\n\n")

# ==============================================================================
# SUMMARY TABLE
# ==============================================================================
cat("\n======================================================================\n")
cat("ANSWER KEY SUMMARY - ALL VERIFIED VALUES\n")
cat("======================================================================\n\n")

summary_data <- data.frame(
  Problem = c("P1.a", "P1.b", "P2.b Wald", "P2.b Wilson", "P3.a", "P3.b"),
  Answer = c(
    paste("(", round(lower_95, 2), ", ", round(upper_95, 2), ")", sep=""),
    paste("(", round(lower_99, 2), ", ", round(upper_99, 2), ")", sep=""),
    paste("(", round(lower_p, 4), ", ", round(upper_p, 4), ")", sep=""),
    paste("(", round(prop_lower, 4), ", ", round(prop_upper, 4), ")", sep=""),
    n_a_rounded,
    n_b_rounded
  ),
  Units = c("mg/dL", "mg/dL", "proportion", "proportion", "subjects", "subjects")
)

print(summary_data)

cat("\n======================================================================\n")
cat("ALL ANSWERS VERIFIED - READY FOR ANSWER KEY\n")
cat("======================================================================\n")
