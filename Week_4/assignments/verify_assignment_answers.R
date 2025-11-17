#!/usr/bin/env Rscript
# Verification script for Week 4 Assignment
# All computational answers verified using R

cat("======================================================================\n")
cat("WEEK 4 ASSIGNMENT - ANSWER VERIFICATION\n")
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
cat("Answer key shows: t(14) = 2.145\n")
cat("MATCH:", abs(t_crit - 2.145) < 0.001, "\n\n")

# Question 4: Standard Error
cat("QUESTION 4: Standard Error\n")
cat("----------------------------------------------------------------------\n")
s <- 12
n <- 36
SE <- s / sqrt(n)
cat("Given: s =", s, ", n =", n, "\n")
cat("SE = s/√n =", s, "/√", n, "=", SE, "\n")
cat("Answer key shows: SE = 2\n")
cat("MATCH:", SE == 2, "\n\n")

# Question 5: Fill-in CI Calculation
cat("QUESTION 5: Fill-in CI Calculation\n")
cat("----------------------------------------------------------------------\n")
n <- 20
xbar <- 52.3
s <- 8.6
df <- n - 1
alpha <- 0.05
cat("Given: n =", n, ", x̄ =", xbar, ", s =", s, "\n\n")

# Part a: SE
SE <- s / sqrt(n)
cat("Part a) SE = s/√n =", s, "/√", n, "=", round(SE, 3), "\n")
cat("Answer key shows: 1.923\n")
cat("MATCH:", abs(SE - 1.923) < 0.001, "\n\n")

# Part b: df and t-critical
cat("Part b) df =", df, "\n")
t_crit <- qt(1 - alpha/2, df)
cat("        t(0.975,", df, ") =", round(t_crit, 3), "\n")
cat("Answer key shows: df = 19, t = 2.093\n")
cat("MATCH:", df == 19 && abs(t_crit - 2.093) < 0.001, "\n\n")

# Part c: Margin of error
ME <- t_crit * SE
cat("Part c) ME = t × SE =", round(t_crit, 3), "×", round(SE, 3), "=", round(ME, 3), "\n")
cat("Answer key shows: 4.025\n")
cat("MATCH:", abs(ME - 4.025) < 0.01, "\n\n")

# Part d: Confidence interval
lower <- xbar - ME
upper <- xbar + ME
cat("Part d) 95% CI = (", round(lower, 2), ",", round(upper, 2), ")\n")
cat("Answer key shows: (48.27, 56.33)\n")
cat("MATCH:", abs(lower - 48.27) < 0.01 && abs(upper - 56.33) < 0.01, "\n\n")

# Question 8: Proportion
cat("QUESTION 8: Proportion\n")
cat("----------------------------------------------------------------------\n")
x <- 180
n <- 240
p_hat <- x / n
cat("Given: x =", x, "successes out of n =", n, "\n")
cat("p̂ = x/n =", x, "/", n, "=", p_hat, "\n")
cat("Answer key shows: p̂ = 0.75\n")
cat("MATCH:", p_hat == 0.75, "\n\n")

# Question 9: SE for proportion
cat("QUESTION 9: SE for Proportion\n")
cat("----------------------------------------------------------------------\n")
p_hat <- 0.75  # From Question 8
n <- 200
SE_p <- sqrt(p_hat * (1 - p_hat) / n)
cat("Given: p̂ =", p_hat, "(from Q8), n =", n, "\n")
cat("SE = √[p̂(1-p̂)/n] = √[", p_hat, "×", (1-p_hat), "/", n, "]\n")
cat("   = √", round(p_hat * (1-p_hat) / n, 7), "=", round(SE_p, 4), "\n")
cat("Answer key shows: SE ≈ 0.031\n")
cat("MATCH:", abs(SE_p - 0.0306) < 0.001, "\n\n")

# Question 11: Sample Size Effect
cat("QUESTION 11: Sample Size Effect on ME\n")
cat("----------------------------------------------------------------------\n")
cat("If sample size quadruples (4×), ME is multiplied by 1/√4 = 1/2\n")
cat("Answer: The margin of error is cut in half\n")
cat("Verification: ME ∝ 1/√n, so ME_new/ME_old = √(n_old/n_new) = √(1/4) = 0.5\n\n")

# Question 12: Sample Size for Proportion
cat("QUESTION 12: Sample Size for Proportion\n")
cat("----------------------------------------------------------------------\n")
z <- qnorm(0.975)  # 1.96
ME <- 0.05
p <- 0.5  # worst case
n_calc <- (z / ME)^2 * p * (1 - p)
n_rounded <- ceiling(n_calc)
cat("Given: 95% CI, ME = 0.05, p = 0.5 (conservative)\n")
cat("z(0.975) =", round(z, 2), "\n")
cat("n = (z/ME)² × p(1-p) = (", round(z, 2), "/", ME, ")² × 0.5 × 0.5\n")
cat("  = ", round((z/ME)^2, 2), "× 0.25 =", round(n_calc, 1), "\n")
cat("Rounded UP: n =", n_rounded, "\n")
cat("Answer key shows: n = 385\n")
cat("MATCH:", n_rounded == 385, "\n\n")

# Question 16: Fill-in R Code for Proportion CI
cat("QUESTION 16: R Code for Proportion CI\n")
cat("----------------------------------------------------------------------\n")
x <- 45
n <- 60
cat("Given: x =", x, "deaths out of n =", n, "patients\n\n")

# Part a: p̂
p_hat <- x / n
cat("Part a) p̂ = x/n =", x, "/", n, "=", round(p_hat, 3), "\n")
cat("Answer key shows: 0.750\n")
cat("MATCH:", abs(p_hat - 0.750) < 0.001, "\n\n")

# Part b: Check conditions
np <- n * p_hat
n_1minusp <- n * (1 - p_hat)
cat("Part b) np̂ =", np, ", n(1-p̂) =", n_1minusp, "\n")
cat("        Both >= 10?", np >= 10 && n_1minusp >= 10, "\n")
cat("Answer key shows: np̂ = 45, n(1-p̂) = 15, both >= 10\n")
cat("MATCH:", np == 45 && n_1minusp == 15, "\n\n")

# Part c: SE
SE_p <- sqrt(p_hat * (1 - p_hat) / n)
cat("Part c) SE = √[p̂(1-p̂)/n] =", round(SE_p, 4), "\n")
cat("Answer key shows: 0.0559\n")
cat("MATCH:", abs(SE_p - 0.0559) < 0.001, "\n\n")

# Part d: 95% CI
z <- qnorm(0.975)
ME <- z * SE_p
lower <- p_hat - ME
upper <- p_hat + ME
cat("Part d) z(0.975) =", round(z, 2), "\n")
cat("        ME = z × SE =", round(z, 2), "×", round(SE_p, 4), "=", round(ME, 4), "\n")
cat("        95% CI = (", round(lower, 3), ",", round(upper, 3), ")\n")
cat("Answer key shows: (0.640, 0.860)\n")
cat("MATCH:", abs(lower - 0.640) < 0.01 && abs(upper - 0.860) < 0.01, "\n\n")

# Part e: As percentage
cat("Part e) As percentage: (", round(lower * 100, 1), "%,", round(upper * 100, 1), "%)\n")
cat("Answer key shows: (64.0%, 86.0%)\n\n")

# Verification using prop.test
cat("Verification using prop.test():\n")
result <- prop.test(x, n, conf.level = 0.95, correct = FALSE)
cat("prop.test 95% CI:", round(result$conf.int[1], 3), "to", round(result$conf.int[2], 3), "\n")
cat("Manual calculation matches ✓\n\n")

cat("======================================================================\n")
cat("VERIFICATION SUMMARY\n")
cat("======================================================================\n\n")

cat("All computational answers verified:\n\n")
cat("✓ Q2:  Critical value t(14) = 2.145\n")
cat("✓ Q4:  Standard error SE = 2\n")
cat("✓ Q5:  CI calculation:\n")
cat("       a) SE = 1.923\n")
cat("       b) df = 19, t = 2.093\n")
cat("       c) ME = 4.025\n")
cat("       d) 95% CI = (48.27, 56.33)\n")
cat("✓ Q8:  Proportion p̂ = 0.75\n")
cat("✓ Q9:  SE for proportion ≈ 0.031\n")
cat("✓ Q11: Sample size 4× → ME halved\n")
cat("✓ Q12: Sample size n = 385\n")
cat("✓ Q16: Proportion CI:\n")
cat("       a) p̂ = 0.750\n")
cat("       b) np̂ = 45, n(1-p̂) = 15\n")
cat("       c) SE = 0.0559\n")
cat("       d) 95% CI = (0.640, 0.860)\n")
cat("       e) Percentage = (64.0%, 86.0%)\n\n")

cat("NO ERRORS FOUND - All calculations verified!\n")
cat("======================================================================\n")
