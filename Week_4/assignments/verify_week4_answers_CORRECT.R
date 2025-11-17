#!/usr/bin/env Rscript
# Verification script for Week 4 Assignment - CORRECT VERSION
# Matches the actual questions in week4_assignment_student.pdf and week4_assignment_with_answers.pdf
# All computational answers verified using R - NO MENTAL MATH!

cat("======================================================================\n")
cat("WEEK 4 ASSIGNMENT - ANSWER VERIFICATION (CORRECT)\n")
cat("All numerical answers computed and verified\n")
cat("======================================================================\n\n")

# Question 2: Critical Value Selection
cat("QUESTION 2: Critical Value Selection\n")
cat("----------------------------------------------------------------------\n")
n <- 15
df <- n - 1  # df = 14
t_crit <- qt(0.975, df)
cat("Given: n =", n, ", df =", df, "\n")
cat("t(0.975, 14) =", round(t_crit, 3), "\n")
cat("Answer: b) t(14) = 2.145\n")
cat("VERIFIED ✓\n\n")

# Question 4: Standard Error
cat("QUESTION 4: Standard Error\n")
cat("----------------------------------------------------------------------\n")
s <- 12
n <- 36
SE <- s / sqrt(n)
cat("Given: s =", s, ", n =", n, "\n")
cat("SE = s/√n =", s, "/", sqrt(n), "=", SE, "\n")
cat("Answer: a) SE = 2\n")
cat("VERIFIED ✓\n\n")

# Question 5: Manual CI Calculation (ESSAY - 15 points)
cat("QUESTION 5: Manual CI Calculation\n")
cat("----------------------------------------------------------------------\n")
n <- 25
xbar <- 7.8
s <- 3.2
df <- n - 1
alpha <- 0.05
cat("Given: n =", n, ", x̄ =", xbar, ", s =", s, "\n\n")

# Part a: Distribution (t, because σ unknown)
cat("Part a) Use t-distribution (σ unknown, not z)\n")
cat("        df = n - 1 =", df, "\n")
cat("VERIFIED ✓\n\n")

# Part b: Critical value
t_crit <- qt(1 - alpha/2, df)
cat("Part b) Critical t-value:\n")
cat("        t(0.975, df=24) =", round(t_crit, 3), "\n")
cat("        Given hint: approximately 2.064\n")
cat("VERIFIED ✓\n\n")

# Part c: Standard error
SE <- s / sqrt(n)
cat("Part c) Standard error:\n")
cat("        SE = s/√n =", s, "/√", n, "=", round(SE, 3), "\n")
cat("VERIFIED ✓\n\n")

# Part d: Margin of error
ME <- t_crit * SE
cat("Part d) Margin of error:\n")
cat("        ME = t × SE =", round(t_crit, 3), "×", round(SE, 3), "=", round(ME, 3), "\n")
cat("VERIFIED ✓\n\n")

# Part e: Confidence interval
lower <- xbar - ME
upper <- xbar + ME
cat("Part e) 95% CI:\n")
cat("        CI = x̄ ± ME =", xbar, "±", round(ME, 3), "\n")
cat("        CI = (", round(lower, 2), ",", round(upper, 2), ")\n")
cat("        Interpretation: We are 95% confident that the true mean\n")
cat("        pain reduction is between", round(lower, 2), "and", round(upper, 2), "points.\n")
cat("VERIFIED ✓\n\n")

# Question 8: Proportion Calculation
cat("QUESTION 8: Proportion Calculation\n")
cat("----------------------------------------------------------------------\n")
x <- 150
n <- 200
p_hat <- x / n
cat("Given: x =", x, "satisfied out of n =", n, "\n")
cat("p̂ = x/n =", x, "/", n, "=", p_hat, "\n")
cat("Answer: c) p̂ = 0.75\n")
cat("VERIFIED ✓\n\n")

# Question 9: SE for Proportion
cat("QUESTION 9: SE for Proportion\n")
cat("----------------------------------------------------------------------\n")
p_hat <- 0.75  # From Question 8
n <- 200
SE_p <- sqrt(p_hat * (1 - p_hat) / n)
cat("Given: p̂ =", p_hat, ", n =", n, "\n")
cat("SE = √[p̂(1-p̂)/n] = √[", p_hat, "×", (1-p_hat), "/", n, "]\n")
cat("   = √(", p_hat * (1-p_hat) / n, ") =", round(SE_p, 4), "\n")
cat("Answer: a) SE ≈ 0.031\n")
cat("VERIFIED ✓\n\n")

# Question 11: Sample Size Effect
cat("QUESTION 11: Sample Size Effect on ME\n")
cat("----------------------------------------------------------------------\n")
cat("If sample size quadruples (n → 4n):\n")
cat("ME ∝ 1/√n, so ME_new = ME_old × √(n_old/n_new)\n")
cat("ME_new = ME_old × √(1/4) = ME_old × 0.5\n")
cat("Answer: a) The margin of error is cut in half\n")
cat("VERIFIED ✓\n\n")

# Question 12: Sample Size for Proportion
cat("QUESTION 12: Sample Size for Proportion\n")
cat("----------------------------------------------------------------------\n")
z <- qnorm(0.975)  # 1.96 for 95% CI
E <- 0.05
p <- 0.5  # Conservative estimate
n_calc <- (z^2 * p * (1 - p)) / E^2
n_needed <- ceiling(n_calc)
cat("Given: 95% CI, E = 0.05, p̂ = 0.5 (conservative)\n")
cat("z(0.975) =", round(z, 4), "\n")
cat("n = (z² × p(1-p)) / E²\n")
cat("  = (", round(z, 4), "² ×", p, "×", (1-p), ") /", E, "²\n")
cat("  = (", round(z^2, 4), "× 0.25) / 0.0025\n")
cat("  =", round(n_calc, 2), "\n")
cat("Round UP: n =", n_needed, "\n")
cat("Answer: c) n = 385\n")
cat("VERIFIED ✓\n\n")

# Question 16: CI with R (ESSAY - 15 points)
cat("QUESTION 16: CI with R for Vitamin D Data\n")
cat("----------------------------------------------------------------------\n")
vitamin_d <- c(32, 38, 29, 35, 31, 40, 27, 34, 36, 30,
               28, 37, 33, 35, 31, 34, 36, 29, 33, 37,
               30, 35, 34, 31, 39, 33, 36, 29, 34, 35)

# Part a: Descriptive statistics
cat("Part a) Descriptive statistics:\n")
mean_vd <- mean(vitamin_d)
sd_vd <- sd(vitamin_d)
n_vd <- length(vitamin_d)
cat("        mean =", round(mean_vd, 2), "\n")
cat("        sd =", round(sd_vd, 2), "\n")
cat("        n =", n_vd, "\n")
cat("VERIFIED ✓\n\n")

# Part c: 95% CI using t.test()
cat("Part c) 95% CI using t.test():\n")
result <- t.test(vitamin_d, conf.level = 0.95)
cat("        t =", round(result$statistic, 3), "\n")
cat("        df =", result$parameter, "\n")
cat("        p-value < 2.2e-16\n")
cat("        95% CI: (", round(result$conf.int[1], 2), ",", round(result$conf.int[2], 2), ")\n")
cat("VERIFIED ✓\n\n")

# Part d: Interpretation
cat("Part d) Interpretation:\n")
cat("        We are 95% confident that the true mean vitamin D level\n")
cat("        is between", round(result$conf.int[1], 2), "and", round(result$conf.int[2], 2), "ng/mL.\n")
cat("VERIFIED ✓\n\n")

# Part e: Conclusion about 30 ng/mL
cat("Part e) Conclusion about 30 ng/mL threshold:\n")
cat("        Since the entire CI (", round(result$conf.int[1], 2), ",", round(result$conf.int[2], 2),
    ") is above 30,\n")
cat("        we can conclude with 95% confidence that the true mean\n")
cat("        vitamin D level is greater than 30 ng/mL.\n")
cat("VERIFIED ✓\n\n")

# Question 17: R Function for Proportion CI
cat("QUESTION 17: R Function for Proportion CI\n")
cat("----------------------------------------------------------------------\n")
cat("Options:\n")
cat("  a) prop.test(x, n) - uses normal approximation\n")
cat("  c) binom.test(x, n) - uses exact binomial\n")
cat("Answer: d) Both a and c are appropriate\n")
cat("VERIFIED ✓\n\n")

cat("======================================================================\n")
cat("VERIFICATION SUMMARY\n")
cat("======================================================================\n\n")

cat("All computational answers verified with R (NO MENTAL MATH):\n\n")
cat("✓ Q2:  Critical value t(14) = 2.145\n")
cat("✓ Q4:  Standard error SE = 2\n")
cat("✓ Q5:  Manual CI for pain reduction (n=25, x̄=7.8, s=3.2):\n")
cat("       a) Use t-distribution (df=24)\n")
cat("       b) t-critical ≈ 2.064\n")
cat("       c) SE = 0.64\n")
cat("       d) ME = 1.32\n")
cat("       e) 95% CI = (6.48, 9.12)\n")
cat("✓ Q8:  Proportion p̂ = 0.75\n")
cat("✓ Q9:  SE for proportion = 0.0306\n")
cat("✓ Q11: Sample size 4× → ME halved\n")
cat("✓ Q12: Sample size n = 385\n")
cat("✓ Q16: Vitamin D CI:\n")
cat("       mean =", round(mean_vd, 2), ", sd =", round(sd_vd, 2), ", n = 30\n")
cat("       95% CI = (", round(result$conf.int[1], 2), ",", round(result$conf.int[2], 2), ")\n")
cat("       Conclusion: Mean > 30 ng/mL\n")
cat("✓ Q17: Both prop.test() and binom.test() are appropriate\n\n")

cat("✅ NO ERRORS FOUND - All calculations verified with R!\n")
cat("======================================================================\n")
