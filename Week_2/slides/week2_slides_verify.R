#!/usr/bin/env Rscript
# Verification script for Week 2 Slides
# ALL numerical calculations verified computationally

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 2 SLIDES - NUMERICAL VERIFICATION\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

# Example 1: Binomial - Vaccine Efficacy (Lines 396-414)
cat("EXAMPLE 1: Binomial - Vaccine Efficacy\n")
cat(paste(rep("-", 70), collapse=""), "\n")
n <- 20
p <- 0.90
k <- 18
prob <- dbinom(k, n, p)
mu <- n * p
sigma <- sqrt(n * p * (1-p))
cat("P(X = 18) where X ~ Binomial(20, 0.90)\n")
cat("Calculated: P(X=18) =", round(prob, 3), "\n")
cat("Slides show: 0.285\n")
cat("μ =", mu, "| σ =", round(sigma, 2), "\n")
cat("Match:", ifelse(abs(prob - 0.285) < 0.001, "✓ YES", "✗ NO"), "\n\n")

# Example 2: Carcinogen Exposure (Lines 169-194)
cat("EXAMPLE 2: Carcinogen Exposure - Binomial n=4, p=0.25\n")
cat(paste(rep("-", 70), collapse=""), "\n")
n <- 4
p <- 0.25
probs <- dbinom(0:4, n, p)
cat("P(X=0) =", round(probs[1], 3), "| Slides: 0.316 | Match:",
    ifelse(abs(probs[1] - 0.316) < 0.001, "✓", "✗"), "\n")
cat("P(X=1) =", round(probs[2], 3), "| Slides: 0.422 | Match:",
    ifelse(abs(probs[2] - 0.422) < 0.001, "✓", "✗"), "\n")
cat("P(X=2) =", round(probs[3], 3), "| Slides: 0.211 | Match:",
    ifelse(abs(probs[3] - 0.211) < 0.001, "✓", "✗"), "\n")
cat("P(X=3) =", round(probs[4], 3), "| Slides: 0.047 | Match:",
    ifelse(abs(probs[4] - 0.047) < 0.001, "✓", "✗"), "\n")
cat("P(X=4) =", round(probs[5], 3), "| Slides: 0.004 | Match:",
    ifelse(abs(probs[5] - 0.004) < 0.001, "✓", "✗"), "\n")
prob_at_least_1 <- 1 - probs[1]
cat("P(X ≥ 1) =", round(prob_at_least_1, 3), "| Slides: 0.684 | Match:",
    ifelse(abs(prob_at_least_1 - 0.684) < 0.001, "✓", "✗"), "\n\n")

# Example 3: Smoking and Lung Cancer - RR and OR (Lines 298-325)
cat("EXAMPLE 3: Smoking and Lung Cancer - Risk Ratio & Odds Ratio\n")
cat(paste(rep("-", 70), collapse=""), "\n")
# 2x2 table
cancer_smokers <- 60
no_cancer_smokers <- 440
cancer_nonsmokers <- 10
no_cancer_nonsmokers <- 490
total_smokers <- cancer_smokers + no_cancer_smokers
total_nonsmokers <- cancer_nonsmokers + no_cancer_nonsmokers

risk_smokers <- cancer_smokers / total_smokers
risk_nonsmokers <- cancer_nonsmokers / total_nonsmokers
RR <- risk_smokers / risk_nonsmokers
OR <- (cancer_smokers * no_cancer_nonsmokers) / (cancer_nonsmokers * no_cancer_smokers)

cat("Risk in smokers:", round(risk_smokers, 2), "| Slides: 0.12 | Match:",
    ifelse(abs(risk_smokers - 0.12) < 0.01, "✓", "✗"), "\n")
cat("Risk in non-smokers:", round(risk_nonsmokers, 2), "| Slides: 0.02 | Match:",
    ifelse(abs(risk_nonsmokers - 0.02) < 0.01, "✓", "✗"), "\n")
cat("Relative Risk:", round(RR, 1), "| Slides: 6.0 | Match:",
    ifelse(abs(RR - 6.0) < 0.1, "✓", "✗"), "\n")
cat("Odds Ratio:", round(OR, 2), "| Slides: 6.68 | Match:",
    ifelse(abs(OR - 6.68) < 0.01, "✓", "✗"), "\n\n")

# Example 4: Expected Value - Adverse Events (Lines 338-352)
cat("EXAMPLE 4: Expected Value - Adverse Events\n")
cat(paste(rep("-", 70), collapse=""), "\n")
x <- c(0, 1, 2, 3)
px <- c(0.70, 0.20, 0.08, 0.02)
EX <- sum(x * px)
cat("E(X) = 0(0.70) + 1(0.20) + 2(0.08) + 3(0.02)\n")
cat("Calculated: E(X) =", round(EX, 2), "\n")
cat("Slides show: 0.42\n")
cat("Match:", ifelse(abs(EX - 0.42) < 0.01, "✓ YES", "✗ NO"), "\n\n")

# Example 5: Disease Surveillance (Lines 466-488)
cat("EXAMPLE 5: Disease Surveillance Calculations\n")
cat(paste(rep("-", 70), collapse=""), "\n")
population <- 50000
new_cases <- 125
deaths <- 15

prob_disease <- new_cases / population
prob_death_given_disease <- deaths / new_cases
prob_death_and_disease <- deaths / population
incidence_rate <- (new_cases / population) * 100000
case_fatality_rate <- (deaths / new_cases) * 100
mortality_rate <- (deaths / population) * 100000

cat("P(disease) =", round(prob_disease, 4),
    "| Slides: 0.0025 | Match:", ifelse(abs(prob_disease - 0.0025) < 0.0001, "✓", "✗"), "\n")
cat("P(death|disease) =", round(prob_death_given_disease, 2),
    "| Slides: 0.12 | Match:", ifelse(abs(prob_death_given_disease - 0.12) < 0.01, "✓", "✗"), "\n")
cat("P(death and disease) =", round(prob_death_and_disease, 4),
    "| Slides: 0.0003 | Match:", ifelse(abs(prob_death_and_disease - 0.0003) < 0.0001, "✓", "✗"), "\n")
cat("Incidence rate:", round(incidence_rate, 0), "per 100,000",
    "| Slides: 250 | Match:", ifelse(abs(incidence_rate - 250) < 1, "✓", "✗"), "\n")
cat("Case fatality rate:", round(case_fatality_rate, 0), "%",
    "| Slides: 12% | Match:", ifelse(abs(case_fatality_rate - 12) < 1, "✓", "✗"), "\n")
cat("Mortality rate:", round(mortality_rate, 0), "per 100,000",
    "| Slides: 30 | Match:", ifelse(abs(mortality_rate - 30) < 1, "✓", "✗"), "\n\n")

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 2 SLIDES VERIFICATION COMPLETE\n")
cat(paste(rep("=", 70), collapse=""), "\n")
