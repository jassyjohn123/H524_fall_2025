# H524 Introduction to Biostatistics
## Week 2: Probability Concepts - Homework Assignment

**Due Date:** [End of Week 3]
**Total Points:** 100
**Format:** Submit through Canvas

---

## Instructions
- Show all work for full credit
- Round probabilities to 4 decimal places
- Round percentages to 1 decimal place
- Include R code where specified

---

## Part 1: Basic Probability Concepts (20 points)

### Question 1 (5 points)
A hospital emergency department sees 120 patients on a typical Saturday. Historical data shows:
- 45% come for injuries
- 30% come for illnesses
- 25% come for other reasons

What is the probability that the next patient:
a) Comes for an injury? (2 points)
b) Does NOT come for an illness? (3 points)

### Question 2 (5 points)
In a clinical trial with 200 participants:
- 80 received Drug A
- 120 received Drug B
- 25 participants receiving Drug A experienced side effects
- 18 participants receiving Drug B experienced side effects

Calculate the probability that a randomly selected participant:
a) Received Drug A (2 points)
b) Experienced side effects (3 points)

### Question 3 (5 points)
A medical screening test has the following characteristics:
- The test can be positive (+) or negative (-)
- The disease can be present (D) or absent (No D)

If P(+) = 0.15, P(D) = 0.02, and P(+ and D) = 0.018, find:
a) P(+ or D) using the addition rule (3 points)
b) Are the events "positive test" and "disease present" mutually exclusive? Explain. (2 points)

### Question 4 (5 points)
Write R code to simulate rolling two dice 10,000 times and calculate:
a) The probability of getting a sum equal to 7 (2 points)
b) The probability of getting doubles (same number on both dice) (3 points)

---

## Part 2: Conditional Probability and Independence (25 points)

### Question 5 (5 points)
In a study of 500 adults:
- 200 have hypertension
- 150 are obese
- 75 have both hypertension and obesity

Calculate:
a) P(Hypertension | Obesity) (3 points)
b) P(Obesity | Hypertension) (2 points)

### Question 6 (5 points)
A hospital reports that 60% of its patients have insurance. Among insured patients, 80% receive preventive care. Among uninsured patients, only 30% receive preventive care.

a) What is the probability a randomly selected patient receives preventive care? (3 points)
b) If a patient receives preventive care, what is the probability they have insurance? (2 points)

### Question 7 (5 points)
Two diagnostic tests are performed on the same patient:
- Test A has a 90% chance of being positive
- Test B has a 85% chance of being positive
- The probability both tests are positive is 77%

Are Test A and Test B independent? Show your work and explain. (5 points)

### Question 8 (10 points)
A genetic trait appears in 1% of the population. A family has 3 children.
a) Assuming independence, what is the probability that exactly one child has the trait? (4 points)
b) What is the probability that at least one child has the trait? (3 points)
c) Write R code to verify your answer to part (b) using simulation (3 points)

---

## Part 3: Diagnostic Tests (20 points)

### Question 9 (10 points)
A new rapid test for strep throat has:
- Sensitivity = 92%
- Specificity = 96%

In a pediatric clinic where 15% of sore throat cases are actually strep:
a) Define sensitivity and specificity in the context of this problem (4 points)
b) Calculate the probability of a false positive (2 points)
c) Calculate the probability of a false negative (2 points)
d) If 1000 children with sore throats are tested, how many false positives would you expect? (2 points)

### Question 10 (10 points)
Create a 2×2 contingency table for the following mammogram screening data:
- 10,000 women screened
- 100 have breast cancer
- Mammogram sensitivity = 90%
- Mammogram specificity = 95%

a) Fill in the 2×2 table with actual numbers (5 points)
b) Calculate PPV and NPV (3 points)
c) Interpret what PPV means for a woman receiving a positive mammogram (2 points)

---

## Part 4: Risk Measures (15 points)

### Question 11 (7 points)
A cohort study of 2000 people over 10 years found:
- 800 smokers: 120 developed lung disease
- 1200 non-smokers: 24 developed lung disease

Calculate:
a) Risk of lung disease in smokers (2 points)
b) Risk of lung disease in non-smokers (2 points)
c) Relative Risk (2 points)
d) Interpret the relative risk in one sentence (1 point)

### Question 12 (8 points)
In a case-control study:
- 100 cases (with disease): 40 exposed to risk factor
- 200 controls (without disease): 30 exposed to risk factor

a) Set up the 2×2 table (3 points)
b) Calculate the Odds Ratio (3 points)
c) Can you calculate Relative Risk from this case-control study? Why or why not? (2 points)

---

## Part 5: Random Variables and Distributions (20 points)

### Question 13 (5 points)
Number of emergency surgeries per day at a hospital:

| Surgeries (X) | 0 | 1 | 2 | 3 | 4 |
|--------------|---|---|---|---|---|
| P(X) | 0.10 | 0.25 | 0.35 | 0.20 | 0.10 |

Calculate:
a) Expected number of surgeries per day (3 points)
b) Standard deviation (2 points)

### Question 14 (7 points)
A new treatment has a 70% success rate. In a group of 15 patients:
a) What is the probability exactly 10 patients improve? (3 points)
b) What is the probability at least 12 patients improve? (2 points)
c) Write R code to calculate parts (a) and (b) (2 points)

### Question 15 (8 points)
Blood glucose levels in healthy adults are normally distributed with mean = 90 mg/dL and standard deviation = 10 mg/dL.

a) What proportion of healthy adults have glucose levels above 100 mg/dL? (3 points)
b) What is the 95th percentile of glucose levels? (2 points)
c) Between what two values do the middle 90% of glucose levels fall? (3 points)

---

## AI Integration Question (Bonus: 5 points)

### Question 16 (5 bonus points)
Use an AI tool (like Claude) to:
a) Generate R code to simulate and visualize the sampling distribution of the mean for a non-normal population (2 points)
b) Run the code and describe what it demonstrates about the Central Limit Theorem (2 points)
c) Identify one limitation or assumption in the AI-generated code (1 point)

---

## Submission Requirements

1. **Written Work:** Submit a PDF with all calculations shown
2. **R Code:** Submit a separate .R file with all code
3. **AI Usage:** If you used AI for any part, include:
   - The prompts you used
   - How you verified the AI output

## Grading Rubric

- **Accuracy (40%):** Correct answers and calculations
- **Method (30%):** Appropriate formulas and approaches
- **Clarity (20%):** Clear presentation and explanation
- **R Code (10%):** Working, commented code where required

---

## Academic Integrity Reminder

While AI tools are permitted for learning and verification, all submitted work must demonstrate your understanding. Simply copying AI output without comprehension is considered academic dishonesty.