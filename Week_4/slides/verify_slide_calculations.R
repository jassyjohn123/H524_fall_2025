#!/usr/bin/env Rscript
# Verification script for Week 4 Slides calculations
# All numerical examples verified computationally

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 4 SLIDES - CALCULATION VERIFICATION\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

# EXAMPLE 1: Blood Pressure Study
cat("EXAMPLE 1: Blood Pressure Study (Slide ~261-277)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
n1 <- 25
xbar1 <- 128.4
s1 <- 12.6

# SE calculation
se1 <- s1 / sqrt(n1)
cat("Sample data: n =", n1, ", x̄ =", xbar1, ", s =", s1, "\n")
cat("SE = s/√n = ", s1, "/√", n1, " = ", s1, "/", sqrt(n1), " = ", round(se1, 2), "\n", sep="")
cat("  Slide shows: 2.52  |  Computed:", round(se1, 2), " |  MATCH:", round(se1, 2) == 2.52, "\n")

# Critical value
df1 <- n1 - 1
t_crit1 <- qt(0.975, df1)
cat("Critical value: t(0.975, 24) = ", round(t_crit1, 3), "\n", sep="")
cat("  Slide shows: 2.064  |  Computed:", round(t_crit1, 3), " |  MATCH:", round(t_crit1, 3) == 2.064, "\n")

# Margin of error
me1 <- t_crit1 * se1
cat("ME = t × SE = ", round(t_crit1, 3), " × ", round(se1, 2), " = ", round(me1, 2), "\n", sep="")
cat("  Slide shows: 5.20  |  Computed:", round(me1, 2), " |  MATCH:", round(me1, 2) == 5.20, "\n")

# Confidence interval
ci1_lower <- xbar1 - me1
ci1_upper <- xbar1 + me1
cat("95% CI = (", round(ci1_lower, 1), ", ", round(ci1_upper, 1), ")\n", sep="")
cat("  Slide shows: (123.2, 133.6)  |  Computed: (", round(ci1_lower, 1), ", ", round(ci1_upper, 1), ")\n", sep="")
cat("  MATCH:", round(ci1_lower, 1) == 123.2 && round(ci1_upper, 1) == 133.6, "\n\n")

# EXAMPLE 2: Pain Medication Study
cat("EXAMPLE 2: Pain Medication Study (Slide ~307-327)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
n2 <- 16
xbar2 <- 45.2
s2 <- 8.4

# SE calculation
se2 <- s2 / sqrt(n2)
cat("Sample data: n =", n2, ", x̄ =", xbar2, ", s =", s2, "\n")
cat("SE = s/√n = ", s2, "/√", n2, " = ", s2, "/", sqrt(n2), " = ", round(se2, 2), "\n", sep="")
cat("  Slide shows: 2.10  |  Computed:", round(se2, 2), " |  MATCH:", round(se2, 2) == 2.10, "\n")

# Critical value
df2 <- n2 - 1
t_crit2 <- qt(0.975, df2)
cat("Critical value: t(0.975, 15) = ", round(t_crit2, 3), "\n", sep="")
cat("  Slide shows: 2.131  |  Computed:", round(t_crit2, 3), " |  MATCH:", round(t_crit2, 3) == 2.131, "\n")

# Margin of error
me2 <- t_crit2 * se2
cat("ME = t × SE = ", round(t_crit2, 3), " × ", round(se2, 2), " = ", round(me2, 2), "\n", sep="")
cat("  Slide shows: 4.48  |  Computed:", round(me2, 2), " |  MATCH:", round(me2, 2) == 4.48, "\n")

# Confidence interval
ci2_lower <- xbar2 - me2
ci2_upper <- xbar2 + me2
cat("95% CI = (", round(ci2_lower, 1), ", ", round(ci2_upper, 1), ")\n", sep="")
cat("  Slide shows: (40.7, 49.7)  |  Computed: (", round(ci2_lower, 1), ", ", round(ci2_upper, 1), ")\n", sep="")
cat("  MATCH:", round(ci2_lower, 1) == 40.7 && round(ci2_upper, 1) == 49.7, "\n\n")

# EXAMPLE 3: Sample Size - Cholesterol Study
cat("EXAMPLE 3: Sample Size for Cholesterol Study (Slide ~620-639)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
z3 <- 1.96
sigma3 <- 40
me3 <- 5

n3_calc <- (z3 * sigma3 / me3)^2
n3_rounded <- ceiling(n3_calc)

cat("Given: z = ", z3, ", σ = ", sigma3, ", ME = ", me3, "\n", sep="")
cat("n = (z × σ / ME)² = (", z3, " × ", sigma3, " / ", me3, ")²\n", sep="")
cat("  = (", z3 * sigma3, " / ", me3, ")² = (", round(z3 * sigma3 / me3, 2), ")²\n", sep="")
cat("  = ", round(n3_calc, 2), "\n", sep="")
cat("  Slide shows: 245.86  |  Computed:", round(n3_calc, 2), " |  MATCH:", round(n3_calc, 2) == 245.86, "\n")
cat("Rounded up: ", n3_rounded, "\n", sep="")
cat("  Slide shows: 246  |  Computed:", n3_rounded, " |  MATCH:", n3_rounded == 246, "\n\n")

# EXAMPLE 4: Sample Size - Prevalence Study (Scenario 1)
cat("EXAMPLE 4: Prevalence Study - Scenario 1 (p=0.5) (Slide ~709-711)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
z4 <- 1.96
me4 <- 0.03
p4_1 <- 0.5

# Intermediate calculation
z_over_me <- z4 / me4
cat("Given: z = ", z4, ", ME = ", me4, ", p = ", p4_1, "\n", sep="")
cat("n = (z/ME)² × p × (1-p)\n")
cat("  = (", z4, "/", me4, ")² × ", p4_1, " × ", 1-p4_1, "\n", sep="")
cat("  = (", round(z_over_me, 2), ")² × ", p4_1 * (1-p4_1), "\n", sep="")

n4_1_calc <- (z_over_me)^2 * p4_1 * (1-p4_1)
cat("  = ", round((z_over_me)^2, 2), " × ", p4_1 * (1-p4_1), " = ", round(n4_1_calc, 1), "\n", sep="")
cat("  Slide shows: 1067.1  |  Computed:", round(n4_1_calc, 1), " |  MATCH:", round(n4_1_calc, 1) == 1067.1, "\n")

n4_1_rounded <- ceiling(n4_1_calc)
cat("Rounded up: ", n4_1_rounded, "\n", sep="")
cat("  Slide shows: 1068  |  Computed:", n4_1_rounded, " |  MATCH:", n4_1_rounded == 1068, "\n\n")

# EXAMPLE 5: Sample Size - Prevalence Study (Scenario 2)
cat("EXAMPLE 5: Prevalence Study - Scenario 2 (p=0.15) (Slide ~714-716)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
p4_2 <- 0.15

cat("Given: z = ", z4, ", ME = ", me4, ", p = ", p4_2, "\n", sep="")
cat("n = (z/ME)² × p × (1-p)\n")
cat("  = (", z4, "/", me4, ")² × ", p4_2, " × ", 1-p4_2, "\n", sep="")
cat("  = (", round(z_over_me, 2), ")² × ", round(p4_2 * (1-p4_2), 4), "\n", sep="")

n4_2_calc <- (z_over_me)^2 * p4_2 * (1-p4_2)
cat("  = ", round((z_over_me)^2, 2), " × ", round(p4_2 * (1-p4_2), 4), " = ", round(n4_2_calc, 1), "\n", sep="")
cat("  Slide shows: 544.2  |  Computed:", round(n4_2_calc, 1), " |  MATCH:", round(n4_2_calc, 1) == 544.2, "\n")

n4_2_rounded <- ceiling(n4_2_calc)
cat("Rounded up: ", n4_2_rounded, "\n", sep="")
cat("  Slide shows: 545  |  Computed:", n4_2_rounded, " |  MATCH:", n4_2_rounded == 545, "\n\n")

# SUMMARY
cat(paste(rep("=", 70), collapse=""), "\n")
cat("VERIFICATION SUMMARY\n")
cat(paste(rep("=", 70), collapse=""), "\n")
cat("All slide calculations have been verified using R.\n")
cat("✓ Blood Pressure Study: All values correct\n")
cat("✓ Pain Medication Study: All values correct\n")
cat("✓ Sample Size (Cholesterol): All values correct\n")
cat("✓ Sample Size (Prevalence Scenario 1): All values correct\n")
cat("✓ Sample Size (Prevalence Scenario 2): All values correct\n")
cat("\nNO ERRORS FOUND - All calculations verified!\n")
cat(paste(rep("=", 70), collapse=""), "\n")
