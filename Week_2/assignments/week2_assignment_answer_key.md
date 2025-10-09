# H524 Assignment 2: Introduction to Probability - ANSWER KEY

**Total Points: 100 (+ 5 bonus)**

---

## Question 1: Basic R Operations (5 points)

**Question:** Write R code to:
a) Create a vector with the following systolic blood pressures: 118, 132, 145, 128, 155, 122, 138 (1 point)
b) Calculate the mean and standard deviation (2 points)
c) Determine how many patients have high blood pressure (≥140 mmHg) (2 points)

**ANSWER:**

```r
# a) Create vector of systolic blood pressures
bp <- c(118, 132, 145, 128, 155, 122, 138)

# b) Calculate mean and standard deviation
mean_bp <- mean(bp)
sd_bp <- sd(bp)
mean_bp  # 134
sd_bp    # 13.06

# c) Count patients with high blood pressure (≥140 mmHg)
high_bp_count <- sum(bp >= 140)
high_bp_count  # 2
```

**Grading rubric:**
- Part a (1 point): Correct vector creation
- Part b (2 points): 1 point for mean, 1 point for SD
- Part c (2 points): Correct logical comparison and counting

---

## Question 2a: Complement Probability (2 points)

**Question:** In a hospital emergency department, 40% of patients come for injuries, 35% come for illnesses, and 25% come for other reasons. What is the probability the next patient does NOT come for an injury?

**ANSWER:** **0.60**

**Solution:**
P(NOT injury) = 1 - P(injury) = 1 - 0.40 = 0.60

**Explanation:** The complement rule states that the probability of an event not occurring is 1 minus the probability it does occur.

---

## Question 2b: Expected Value (3 points)

**Question:** If 200 patients visit the ED this week, how many would you expect to come for illnesses?

**ANSWER:** **70**

**Solution:**
Expected value = n × p = 200 × 0.35 = 70 patients

**Explanation:** Expected value is the total number of trials multiplied by the probability of success.

---

## Question 3: Sample Space and Events (5 points)

**Question:** A clinical trial randomly assigns patients to three treatment groups:
- 50 patients receive Drug A
- 75 patients receive Drug B
- 75 patients receive Placebo

a) What is the probability a randomly selected patient received Drug A? (2 points)
b) What is the probability a randomly selected patient did NOT receive placebo? (3 points)

**ANSWER:**

**Part a (2 points):**
Total patients = 50 + 75 + 75 = 200
P(Drug A) = 50/200 = 0.25 or 25%

**Part b (3 points):**
Method 1 (Complement Rule):
P(NOT placebo) = 1 - P(placebo) = 1 - (75/200) = 1 - 0.375 = 0.625 or 62.5%

Method 2 (Direct calculation):
P(NOT placebo) = P(Drug A or Drug B) = (50 + 75)/200 = 125/200 = 0.625 or 62.5%

**Grading rubric:**
- Part a: 1 point for correct setup, 1 point for correct answer
- Part b: 1 point for identifying correct approach, 1 point for calculation, 1 point for correct answer

---

## Question 4a: False Positive Probability (3 points)

**Question:** A screening test for diabetes has a 95% specificity (true negative rate). What is the probability of a false positive?

**ANSWER:** **0.05**

**Solution:**
Specificity = P(test negative | no disease) = 0.95
False positive rate = 1 - Specificity = 1 - 0.95 = 0.05

**Explanation:** Specificity is the probability of testing negative when disease is absent. The false positive rate (testing positive when disease is absent) is the complement of specificity.

---

## Question 4b: Interpretation (2 points)

**Question:** Explain in plain language what the false positive probability of 0.05 means.

**ANSWER:**

A false positive probability of 0.05 means that among people who do NOT have diabetes, 5% will test positive on this screening test (a false alarm). In other words, for every 100 people without diabetes who take the test, we expect about 5 to incorrectly receive a positive result.

**Grading rubric:**
- 1 point for mentioning it applies to people without the disease
- 1 point for explaining the rate/proportion correctly

---

## Question 5: Addition Rule (5 points)

**Question:** In a study of 300 adults:
- 120 have high blood pressure
- 90 have high cholesterol
- 30 have both conditions

a) Calculate P(high BP OR high cholesterol) using the addition rule. Show your work. (4 points)
b) Are these events mutually exclusive? Explain. (1 point)

**ANSWER:**

**Part a (4 points):**

P(high BP) = 120/300 = 0.40
P(high cholesterol) = 90/300 = 0.30
P(both) = 30/300 = 0.10

Using the addition rule:
P(high BP OR high cholesterol) = P(high BP) + P(high cholesterol) - P(both)
P(high BP OR high cholesterol) = 0.40 + 0.30 - 0.10 = 0.60

**Verification:** We can also count directly: 120 + 90 - 30 = 180 people have at least one condition
P = 180/300 = 0.60 ✓

**Part b (1 point):**

No, these events are NOT mutually exclusive because 30 people have both conditions. Mutually exclusive events cannot occur simultaneously (their intersection would be zero). Since P(both) = 0.10 ≠ 0, the events overlap and are not mutually exclusive.

**Grading rubric:**
- Part a: 1 point for individual probabilities, 2 points for correct addition rule formula, 1 point for correct final answer
- Part b: 1 point for correct answer with valid reasoning

---

## Question 6: Basic Conditional Probability (6 points)

**Question:** In a group of 500 hospital patients:
- 200 are smokers
- 150 have respiratory complications
- 100 are smokers with respiratory complications

a) Calculate P(respiratory complications | smoker). Show your work. (3 points)
b) Calculate P(smoker | respiratory complications). Show your work. (3 points)

**ANSWER:**

**Part a (3 points):**

P(respiratory complications | smoker) = P(respiratory complications AND smoker) / P(smoker)
P(respiratory complications | smoker) = (100/500) / (200/500) = 100/200 = 0.50 or 50%

**Interpretation:** Among smokers, 50% have respiratory complications.

**Part b (3 points):**

P(smoker | respiratory complications) = P(smoker AND respiratory complications) / P(respiratory complications)
P(smoker | respiratory complications) = (100/500) / (150/500) = 100/150 = 0.667 or 66.7%

**Interpretation:** Among patients with respiratory complications, 66.7% are smokers.

**Note:** These two conditional probabilities are different! P(A|B) ≠ P(B|A) in general.

**Grading rubric:**
- Part a: 1 point for correct formula, 1 point for calculation, 1 point for answer
- Part b: 1 point for correct formula, 1 point for calculation, 1 point for answer

---

## Question 7: Law of Total Probability (7 points)

**Question:** A clinic's patient population:
- 60% are adults, 40% are children
- Among adults, 20% have allergies
- Among children, 35% have allergies

a) What is the overall probability that a randomly selected patient has allergies? Show your work using the law of total probability. (5 points)
b) If a patient has allergies, what is the probability they are a child? (2 points)

**ANSWER:**

**Part a (5 points):**

Given:
- P(Adult) = 0.60, P(Child) = 0.40
- P(Allergies | Adult) = 0.20
- P(Allergies | Child) = 0.35

Using the Law of Total Probability:
P(Allergies) = P(Allergies | Adult) × P(Adult) + P(Allergies | Child) × P(Child)
P(Allergies) = (0.20)(0.60) + (0.35)(0.40)
P(Allergies) = 0.12 + 0.14 = 0.26 or 26%

**Part b (2 points):**

Using Bayes' Theorem:
P(Child | Allergies) = P(Allergies | Child) × P(Child) / P(Allergies)
P(Child | Allergies) = (0.35)(0.40) / 0.26
P(Child | Allergies) = 0.14 / 0.26 = 0.538 or 53.8%

**Interpretation:** Among patients with allergies, about 54% are children.

**Grading rubric:**
- Part a: 1 point for identifying correct formula, 2 points for calculating each component, 1 point for addition, 1 point for correct final answer
- Part b: 1 point for correct approach/formula, 1 point for correct answer

---

## Question 8: Independence (7 points)

**Question:** Two screening tests are given:
- P(Test A positive) = 0.10
- P(Test B positive) = 0.15
- P(both positive) = 0.015

a) Are Test A and Test B independent? Show your work. (5 points)
b) Explain what independence would mean in this clinical context. (2 points)

**ANSWER:**

**Part a (5 points):**

For independence, we need: P(A AND B) = P(A) × P(B)

Check:
- P(A) × P(B) = 0.10 × 0.15 = 0.015
- P(A AND B) = 0.015

Since P(A AND B) = P(A) × P(B), **YES, Test A and Test B are independent.**

Alternative check using conditional probability:
P(A | B) = P(A AND B) / P(B) = 0.015 / 0.15 = 0.10 = P(A)

Since P(A | B) = P(A), the tests are independent.

**Part b (2 points):**

Independence means that knowing the result of Test A does not change the probability of Test B being positive. In this clinical context, it means the two tests are measuring different aspects of health that don't influence each other. A positive result on one test neither increases nor decreases the likelihood of a positive result on the other test.

**Grading rubric:**
- Part a: 2 points for stating independence condition, 2 points for calculation, 1 point for conclusion
- Part b: 1 point for general definition, 1 point for clinical context application

---

## Question 9: Sensitivity and Specificity Definitions (6 points)

**Question:** A rapid flu test is being evaluated.

a) Define sensitivity in terms of conditional probability using proper notation [Pr(· | ·)]. (2 points)
b) Define specificity in terms of conditional probability using proper notation. (2 points)
c) Explain in plain language what a 90% sensitivity means for patients who actually have the flu. (2 points)

**ANSWER:**

**Part a (2 points):**

Sensitivity = Pr(Test Positive | Disease Present)

Also called the true positive rate. It is the probability the test correctly identifies those with the disease.

**Part b (2 points):**

Specificity = Pr(Test Negative | Disease Absent)

Also called the true negative rate. It is the probability the test correctly identifies those without the disease.

**Part c (2 points):**

A 90% sensitivity means that among all patients who actually have the flu, 90% will test positive (correctly detected). In other words, the test will correctly identify 9 out of every 10 people who truly have the flu. The remaining 10% of flu patients will receive a false negative result (test says no flu, but they actually have it).

**Grading rubric:**
- Part a: 1 point for correct notation, 1 point for correct explanation
- Part b: 1 point for correct notation, 1 point for correct explanation
- Part c: 1 point for correct interpretation, 1 point for mentioning false negatives or similar concept

---

## Question 10: Creating a 2×2 Table (10 points)

**Question:** A COVID-19 rapid antigen test has:
- Sensitivity = 85%
- Specificity = 95%

In a community where 2% of people currently have COVID-19, 10,000 people are tested.

a) Create a complete 2×2 table showing disease status (Has COVID / No COVID) in rows and test result (Positive / Negative) in columns. (6 points)
b) Add row and column totals to your table. (2 points)
c) Verify your sensitivity and specificity calculations match the given values. (2 points)

**ANSWER:**

**Parts a & b (8 points):**

Step 1: Calculate disease prevalence
- Has COVID: 2% × 10,000 = 200 people
- No COVID: 98% × 10,000 = 9,800 people

Step 2: Apply sensitivity (85%) to those with COVID
- True Positives (TP): 85% × 200 = 170
- False Negatives (FN): 15% × 200 = 30

Step 3: Apply specificity (95%) to those without COVID
- True Negatives (TN): 95% × 9,800 = 9,310
- False Positives (FP): 5% × 9,800 = 490

**Complete 2×2 Table:**

|                    | Test Positive | Test Negative | **Total** |
|--------------------|---------------|---------------|-----------|
| **Has COVID**      | 170 (TP)      | 30 (FN)       | **200**   |
| **No COVID**       | 490 (FP)      | 9,310 (TN)    | **9,800** |
| **Total**          | **660**       | **9,340**     | **10,000**|

**Part c (2 points):**

Verify Sensitivity:
Sensitivity = TP / (TP + FN) = 170 / 200 = 0.85 = 85% ✓

Verify Specificity:
Specificity = TN / (TN + FP) = 9,310 / 9,800 = 0.95 = 95% ✓

**Grading rubric:**
- Part a: 2 points for correct disease totals, 2 points for correct TP/FN, 2 points for correct TN/FP
- Part b: 1 point for row totals, 1 point for column totals
- Part c: 1 point for sensitivity verification, 1 point for specificity verification

---

## Question 11: PPV and NPV Calculation (8 points)

**Question:** Using the 2×2 table from Question 10:

a) Calculate the Positive Predictive Value (PPV). Show your work. (3 points)
b) Calculate the Negative Predictive Value (NPV). Show your work. (3 points)
c) Explain in one sentence what the PPV means for someone who tests positive. (2 points)

**ANSWER:**

**Part a (3 points):**

PPV = True Positives / (True Positives + False Positives)
PPV = TP / (TP + FP) = 170 / (170 + 490) = 170 / 660 = 0.258 or 25.8%

**Part b (3 points):**

NPV = True Negatives / (True Negatives + False Negatives)
NPV = TN / (TN + FN) = 9,310 / (9,310 + 30) = 9,310 / 9,340 = 0.997 or 99.7%

**Part c (2 points):**

The PPV of 25.8% means that among all people who test positive, only about 26% actually have COVID-19, while 74% are false positives.

**Grading rubric:**
- Part a: 1 point for correct formula, 1 point for calculation, 1 point for answer
- Part b: 1 point for correct formula, 1 point for calculation, 1 point for answer
- Part c: 2 points for clear, accurate interpretation

---

## Question 12: The Counterintuitive Case (6 points)

**Question:** Consider an HIV screening test with excellent performance:
- Sensitivity = 99.5%
- Specificity = 98.5%
- Population prevalence = 0.1% (1 in 1,000)

Imagine screening 100,000 people.

a) Without doing calculations, would you expect the PPV to be high or low? Why? (2 points)
b) Create the 2×2 table with actual counts for 100,000 people screened. (3 points)
c) Calculate the PPV and explain why it might surprise people despite the excellent sensitivity and specificity. (1 point)

**ANSWER:**

**Part a (2 points):**

I would expect the PPV to be relatively LOW despite the excellent test performance. This is because the prevalence is very low (0.1%). When disease is rare, even a small false positive rate (1.5%) applied to the large number of disease-free individuals will generate many false positives, potentially outnumbering the true positives.

**Part b (3 points):**

Step 1: Calculate disease prevalence
- Has HIV: 0.1% × 100,000 = 100 people
- No HIV: 99.9% × 100,000 = 99,900 people

Step 2: Apply sensitivity (99.5%)
- TP: 99.5% × 100 = 99.5 ≈ 100 (round to 100)
- FN: 0.5% × 100 = 0.5 ≈ 0

Step 3: Apply specificity (98.5%)
- TN: 98.5% × 99,900 = 98,401.5 ≈ 98,402
- FP: 1.5% × 99,900 = 1,498.5 ≈ 1,498

**2×2 Table:**

|                | Test Positive | Test Negative | **Total**  |
|----------------|---------------|---------------|------------|
| **Has HIV**    | 100 (TP)      | 0 (FN)        | **100**    |
| **No HIV**     | 1,498 (FP)    | 98,402 (TN)   | **99,900** |
| **Total**      | **1,598**     | **98,402**    | **100,000**|

**Part c (1 point):**

PPV = TP / (TP + FP) = 100 / (100 + 1,498) = 100 / 1,598 = 0.063 or 6.3%

This result surprises people because despite having excellent sensitivity (99.5%) and specificity (98.5%), only about 6% of positive tests actually indicate true HIV infection. This counterintuitive result occurs because the disease is so rare (0.1%) that the small number of false positives (1.5% of 99,900 = 1,498) vastly outnumber the true positives (100). This demonstrates why PPV depends heavily on disease prevalence, not just test accuracy.

**Key insight:** Even highly accurate tests have low PPV when screening for rare diseases in low-prevalence populations.

**Grading rubric:**
- Part a: 1 point for "low" prediction, 1 point for valid reasoning about prevalence
- Part b: 1 point for disease totals, 1 point for TP/FN, 1 point for TN/FP
- Part c: 0.5 points for calculation, 0.5 points for explanation of the paradox

---

## Question 13: Relative Risk (8 points)

**Question:** A 5-year cohort study of 1,000 people examined coffee consumption and heart disease:
- 400 heavy coffee drinkers: 60 developed heart disease
- 600 light/non coffee drinkers: 48 developed heart disease

a) Calculate the risk of heart disease in heavy coffee drinkers. (2 points)
b) Calculate the risk of heart disease in light/non coffee drinkers. (2 points)
c) Calculate the Relative Risk (RR). (2 points)
d) Interpret the RR in one complete sentence. (2 points)

**ANSWER:**

**Part a (2 points):**

Risk in heavy drinkers = Number with disease / Total exposed
Risk in heavy drinkers = 60 / 400 = 0.15 or 15%

**Part b (2 points):**

Risk in light/non drinkers = Number with disease / Total unexposed
Risk in light/non drinkers = 48 / 600 = 0.08 or 8%

**Part c (2 points):**

Relative Risk (RR) = Risk in exposed / Risk in unexposed
RR = 0.15 / 0.08 = 1.875 or 1.88

**Part d (2 points):**

Heavy coffee drinkers have 1.88 times the risk of developing heart disease compared to light/non coffee drinkers, or alternatively, heavy coffee drinking is associated with an 88% increased risk of heart disease.

**Note:** This is an observational study, so we cannot conclude causation. The association might be due to confounding factors.

**Grading rubric:**
- Part a: 1 point for correct calculation, 1 point for correct answer
- Part b: 1 point for correct calculation, 1 point for correct answer
- Part c: 1 point for correct formula/calculation, 1 point for correct answer
- Part d: 1 point for mentioning comparative risk, 1 point for correct interpretation of magnitude

---

## Question 14: Understanding Risk Ratios (7 points)

**Question:** For each Relative Risk value below, explain what it means:

a) RR = 1.0 (2 points)
b) RR = 2.5 (2 points)
c) RR = 0.6 (2 points)
d) When RR > OR, is the disease common or rare? (1 point)

**ANSWER:**

**Part a (2 points):**

RR = 1.0 means there is NO association between the exposure and the outcome. The risk in the exposed group equals the risk in the unexposed group. The exposure neither increases nor decreases risk.

**Part b (2 points):**

RR = 2.5 means the exposed group has 2.5 times the risk of the outcome compared to the unexposed group. Alternatively, the exposure is associated with a 150% increase in risk [(2.5 - 1.0) × 100% = 150%].

**Part c (2 points):**

RR = 0.6 means the exposed group has 0.6 times the risk (60% of the risk) of the outcome compared to the unexposed group. This indicates a protective effect - the exposure reduces risk by 40% [(1.0 - 0.6) × 100% = 40%].

**Part d (1 point):**

When RR > OR, the disease is **COMMON**.

The odds ratio (OR) approximates the relative risk (RR) well only when the disease is rare (<10%). When disease is common, OR overestimates RR (moves further from 1.0), so RR > OR for risk factors (RR > 1) and RR < OR for protective factors (RR < 1).

**Grading rubric:**
- Parts a, b, c: 1 point for general interpretation, 1 point for specific meaning
- Part d: 1 point for correct answer with brief reasoning

---

## Question 15: Binomial Distribution (5 points)

**Question:** A new medication has a 75% success rate. A hospital treats 20 patients with this medication.

a) What is the probability that exactly 15 patients respond successfully? Write the R code and provide the answer. (2 points)
b) What is the probability that at least 16 patients respond successfully? Write the R code and provide the answer. (3 points)

**ANSWER:**

**Part a (2 points):**

```r
# Probability that exactly 15 respond successfully
dbinom(15, size = 20, prob = 0.75)
```

**Answer: 0.2023** or approximately 20.23%

**Part b (3 points):**

```r
# Probability that at least 16 respond successfully
# Method 1: Sum of individual probabilities
sum(dbinom(16:20, size = 20, prob = 0.75))

# Method 2: Using upper tail
1 - pbinom(15, size = 20, prob = 0.75)

# Method 3: Using lower.tail = FALSE
pbinom(15, size = 20, prob = 0.75, lower.tail = FALSE)
```

**Answer: 0.4148** or approximately 41.48%

**Explanation:**
- n = 20 trials (patients)
- p = 0.75 success probability
- Part a asks for P(X = 15)
- Part b asks for P(X ≥ 16) = P(X = 16) + P(X = 17) + P(X = 18) + P(X = 19) + P(X = 20)

**Grading rubric:**
- Part a: 1 point for correct R code, 1 point for correct answer
- Part b: 1.5 points for correct R code, 1.5 points for correct answer

---

## Question 16: Normal Distribution (5 points)

**Question:** Adult cholesterol levels are normally distributed with mean = 200 mg/dL and SD = 40 mg/dL.

a) What proportion of adults have cholesterol levels above 240 mg/dL (high risk)? Write the R code and provide the answer. (2 points)
b) What cholesterol level represents the 90th percentile? Write the R code and provide the answer. (3 points)

**ANSWER:**

**Part a (2 points):**

```r
# Proportion with cholesterol above 240 mg/dL
1 - pnorm(240, mean = 200, sd = 40)

# Alternative: using lower.tail = FALSE
pnorm(240, mean = 200, sd = 40, lower.tail = FALSE)
```

**Answer: 0.1587** or approximately 15.87%

**Interpretation:** About 16% of adults have high-risk cholesterol levels (>240 mg/dL).

**Part b (3 points):**

```r
# Cholesterol level at 90th percentile
qnorm(0.90, mean = 200, sd = 40)
```

**Answer: 251.3** mg/dL (approximately 251 mg/dL)

**Interpretation:** 90% of adults have cholesterol levels below 251.3 mg/dL, and 10% have levels above this value.

**Statistical note:** The value 240 mg/dL is (240 - 200) / 40 = 1 standard deviation above the mean. Using the empirical rule or z-table, P(Z > 1.0) ≈ 0.1587.

**Grading rubric:**
- Part a: 1 point for correct R code, 1 point for correct answer
- Part b: 1.5 points for correct R code, 1.5 points for correct answer

---

## Bonus Question 17: AI Verification (5 bonus points)

**Question:** Choose ONE problem from Part 3 (Diagnostic Testing).

a) Ask an AI tool (like Claude, ChatGPT) to solve it. Include your exact prompt. (1 point)
b) Verify the AI's answer by working through it yourself. Did the AI get it right? (2 points)
c) Identify one strength and one potential limitation of using AI for this type of problem. (2 points)

**SAMPLE ANSWER:** (Answers will vary by student)

**Part a (1 point):**

Example prompt to AI:
> "A COVID-19 rapid antigen test has a sensitivity of 85% and specificity of 95%. In a community where 2% of people currently have COVID-19, 10,000 people are tested. Create a 2×2 table with actual counts and calculate the Positive Predictive Value (PPV) and Negative Predictive Value (NPV)."

**Part b (2 points):**

Student verification would include:
- Working through the calculation independently
- Comparing AI's 2×2 table to their own
- Checking PPV and NPV calculations
- Noting any discrepancies

Example verification:
"The AI correctly calculated that 200 people have COVID (2% of 10,000) and 9,800 don't. It correctly applied sensitivity to get TP=170 and FN=30, and specificity to get TN=9,310 and FP=490. The PPV calculation of 25.8% and NPV of 99.7% matched my own calculations. The AI got it completely right."

**Part c (2 points):**

**Strength:** AI tools can quickly set up the correct framework (2×2 table structure), apply formulas systematically, and catch arithmetic errors. They can also provide step-by-step explanations and verify calculations multiple ways. This is particularly helpful for complex multi-step problems where organization matters.

**Limitation:** AI may not always provide the clinical interpretation or context that helps understanding WHY the answer matters. For example, it might calculate PPV = 25.8% correctly but not emphasize the counterintuitive nature of this low value despite excellent test performance, or explain the implications for clinical decision-making. Students might also over-rely on AI without developing their own problem-solving intuition and understanding of when to use each formula.

**Grading rubric:**
- Part a: 1 point for including a clear, appropriate prompt
- Part b: 1 point for showing verification work, 1 point for accuracy assessment
- Part c: 1 point for meaningful strength, 1 point for meaningful limitation

---

## Point Summary

| Question | Points | Topic |
|----------|--------|-------|
| Q1       | 5      | R Operations |
| Q2a      | 2      | Complement Probability |
| Q2b      | 3      | Expected Value |
| Q3       | 5      | Sample Space |
| Q4a      | 3      | False Positive |
| Q4b      | 2      | Interpretation |
| Q5       | 5      | Addition Rule |
| Q6       | 6      | Conditional Probability |
| Q7       | 7      | Law of Total Probability |
| Q8       | 7      | Independence |
| Q9       | 6      | Sensitivity/Specificity Definitions |
| Q10      | 10     | 2×2 Table |
| Q11      | 8      | PPV and NPV |
| Q12      | 6      | Counterintuitive Case |
| Q13      | 8      | Relative Risk |
| Q14      | 7      | Understanding Risk Ratios |
| Q15      | 5      | Binomial Distribution |
| Q16      | 5      | Normal Distribution |
| **Total**| **100**| |
| Q17 (Bonus) | +5  | AI Verification |

---

**End of Answer Key**
