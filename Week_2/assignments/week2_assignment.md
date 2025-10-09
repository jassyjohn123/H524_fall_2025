# H524 Introduction to Biostatistics
## Week 2: Introduction to Probability - Homework Assignment

**Due Date:** End of Week 3
**Total Points:** 100
**Format:** Submit through Canvas

---

## Instructions
- Show all work for full credit
- Round probabilities to 4 decimal places unless otherwise specified
- Round percentages to 1 decimal place
- Include R code where specified
- You may use R to check your work

---

## Part 1: Basic R and Probability Fundamentals (25 points)

### Question 1: Basic R Operations (5 points)
Write R code to:
a) Create a vector with the following systolic blood pressures: 118, 132, 145, 128, 155, 122, 138 (1 point)
b) Calculate the mean and standard deviation (2 points)
c) Determine how many patients have high blood pressure (≥140 mmHg) (2 points)

### Question 2: Simple Probability (5 points)
In a hospital emergency department, records show:
- 40% of patients come for injuries
- 35% come for illnesses
- 25% come for other reasons

a) What is the probability the next patient does NOT come for an injury? (2 points)
b) If 200 patients visit the ED this week, how many would you expect to come for illnesses? (3 points)

### Question 3: Sample Space and Events (5 points)
A clinical trial randomly assigns patients to three treatment groups: Drug A, Drug B, or Placebo.
- 50 patients receive Drug A
- 75 patients receive Drug B
- 75 patients receive Placebo

a) What is the probability a randomly selected patient received Drug A? (2 points)
b) What is the probability a randomly selected patient did NOT receive placebo? (3 points)

### Question 4: Complement Rule (5 points)
A screening test for diabetes has a 95% specificity (true negative rate).

a) What is the probability of a false positive? Show your work using the complement rule. (3 points)
b) Explain in plain language what this false positive probability means. (2 points)

### Question 5: Addition Rule (5 points)
In a study of 300 adults:
- 120 have high blood pressure
- 90 have high cholesterol
- 30 have both conditions

a) Calculate P(high BP OR high cholesterol) using the addition rule. Show your work. (4 points)
b) Are these events mutually exclusive? Explain. (1 point)

---

## Part 2: Conditional Probability (20 points)

### Question 6: Basic Conditional Probability (6 points)
In a group of 500 hospital patients:
- 200 are smokers
- 150 have respiratory complications
- 100 are smokers with respiratory complications

a) Calculate P(respiratory complications | smoker). Show your work. (3 points)
b) Calculate P(smoker | respiratory complications). Show your work. (3 points)

### Question 7: Law of Total Probability (7 points)
A clinic's patient population:
- 60% are adults, 40% are children
- Among adults, 20% have allergies
- Among children, 35% have allergies

a) What is the overall probability that a randomly selected patient has allergies? Show your work using the law of total probability. (5 points)
b) If a patient has allergies, what is the probability they are a child? (2 points)

### Question 8: Independence (7 points)
Two screening tests are given:
- P(Test A positive) = 0.10
- P(Test B positive) = 0.15
- P(both positive) = 0.015

a) Are Test A and Test B independent? Show your work. (5 points)
b) Explain what independence would mean in this clinical context. (2 points)

---

## Part 3: Diagnostic Testing and 2×2 Tables (30 points)

### Question 9: Sensitivity and Specificity Definitions (6 points)
A rapid flu test is being evaluated.

a) Define sensitivity in terms of conditional probability using proper notation [Pr(· | ·)]. (2 points)
b) Define specificity in terms of conditional probability using proper notation. (2 points)
c) Explain in plain language what a 90% sensitivity means for patients who actually have the flu. (2 points)

### Question 10: Creating a 2×2 Table (10 points)
A COVID-19 rapid antigen test has:
- Sensitivity = 85%
- Specificity = 95%

In a community where 2% of people currently have COVID-19, 10,000 people are tested.

a) Create a complete 2×2 table showing:
   - Disease status (rows): Has COVID / No COVID
   - Test result (columns): Positive / Negative
   - Fill in all four cells with actual counts (6 points)

b) Add row and column totals to your table. (2 points)

c) Verify your sensitivity and specificity calculations match the given values. (2 points)

### Question 11: PPV and NPV Calculation (8 points)
Using the 2×2 table from Question 10:

a) Calculate the Positive Predictive Value (PPV). Show your work. (3 points)
b) Calculate the Negative Predictive Value (NPV). Show your work. (3 points)
c) Explain in one sentence what the PPV means for someone who tests positive. (2 points)

### Question 12: The Counterintuitive Case (6 points)
Consider an HIV screening test with excellent performance:
- Sensitivity = 99.5%
- Specificity = 98.5%
- Population prevalence = 0.1% (1 in 1,000)

Imagine screening 100,000 people.

a) Without doing calculations, would you expect the PPV to be high or low? Why? (2 points)
b) Create the 2×2 table with actual counts for 100,000 people screened. (3 points)
c) Calculate the PPV and explain why it might surprise people despite the excellent sensitivity and specificity. (1 point)

---

## Part 4: Risk Measures (15 points)

### Question 13: Relative Risk (8 points)
A 5-year cohort study of 1,000 people examined coffee consumption and heart disease:
- 400 heavy coffee drinkers: 60 developed heart disease
- 600 light/non coffee drinkers: 48 developed heart disease

a) Calculate the risk of heart disease in heavy coffee drinkers. (2 points)
b) Calculate the risk of heart disease in light/non coffee drinkers. (2 points)
c) Calculate the Relative Risk (RR). (2 points)
d) Interpret the RR in one complete sentence. (2 points)

### Question 14: Understanding Risk Ratios (7 points)
For each Relative Risk value below, explain what it means:

a) RR = 1.0 (2 points)
b) RR = 2.5 (2 points)
c) RR = 0.6 (2 points)
d) When RR > OR, is the disease common or rare? (1 point)

---

## Part 5: Probability Distributions in R (10 points)

### Question 15: Binomial Distribution (5 points)
A new medication has a 75% success rate. A hospital treats 20 patients with this medication.

a) What is the probability that exactly 15 patients respond successfully? Write the R code and provide the answer. (2 points)
b) What is the probability that at least 16 patients respond successfully? Write the R code and provide the answer. (3 points)

### Question 16: Normal Distribution (5 points)
Adult cholesterol levels are normally distributed with mean = 200 mg/dL and SD = 40 mg/dL.

a) What proportion of adults have cholesterol levels above 240 mg/dL (high risk)? Write the R code and provide the answer. (2 points)
b) What cholesterol level represents the 90th percentile? Write the R code and provide the answer. (3 points)

---

## Bonus: AI-Enhanced Learning (5 bonus points)

### Question 17: AI Verification (5 bonus points)
Choose ONE problem from Part 3 (Diagnostic Testing).

a) Ask an AI tool (like Claude, ChatGPT) to solve it. Include your exact prompt. (1 point)
b) Verify the AI's answer by working through it yourself. Did the AI get it right? (2 points)
c) Identify one strength and one potential limitation of using AI for this type of problem. (2 points)

---

## Submission Requirements

### Required Files:
1. **PDF Document** with all written work, tables, and calculations
2. **R Script File (.R)** with all R code properly commented
3. **AI Usage Documentation** (if applicable):
   - Prompts used
   - How you verified outputs
   - Your own understanding of the solutions

### Formatting Guidelines:
- Clearly label each question number
- Show all calculation steps
- For 2×2 tables, draw clear grids with labels
- Round consistently per instructions

---

## Grading Rubric

| Category | Points | Criteria |
|----------|--------|----------|
| **Calculations** | 40 | Correct formulas, accurate arithmetic |
| **Methods** | 30 | Appropriate approach, proper notation |
| **Interpretation** | 20 | Clear explanations, correct context |
| **R Code** | 10 | Working code, proper comments |
| **Bonus** | +5 | Thoughtful AI integration |

---

## Academic Integrity

You are encouraged to:
- ✓ Use AI tools to check your work
- ✓ Ask AI to explain concepts
- ✓ Verify calculations with AI

You must NOT:
- ✗ Submit AI-generated work without understanding it
- ✗ Copy solutions without showing your reasoning
- ✗ Use AI as a substitute for learning

**Remember:** The goal is to develop YOUR ability to solve these problems, with AI as a learning aid.
