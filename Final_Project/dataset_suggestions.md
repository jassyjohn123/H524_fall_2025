# Dataset Suggestions for Final Project

This document provides curated, accessible datasets for your final project. Choose data that matches your statistical method and research question.

---

## General Dataset Repositories

### 1. Kaggle Datasets
- **URL:** https://www.kaggle.com/datasets
- **Access:** Free account required
- **Best for:** Beginner-friendly, clean datasets with documentation
- **File formats:** CSV, JSON
- **Suggested search terms:** "health", "education", "survey", "correlation", "categorical"

### 2. UCI Machine Learning Repository
- **URL:** https://archive.ics.uci.edu/ml/datasets.php
- **Access:** Free, no account needed
- **Best for:** Classic datasets, well-documented
- **File formats:** CSV, TXT, ARFF
- **Note:** Great for regression and classification projects

### 3. Data.gov
- **URL:** https://data.gov
- **Access:** Free, no account needed
- **Best for:** Government data, public health, demographics
- **File formats:** CSV, JSON, XML
- **Note:** Very large datasets available - you may want to sample

### 4. Google Dataset Search
- **URL:** https://datasetsearch.research.google.com
- **Access:** Free search engine for datasets
- **Best for:** Finding datasets across multiple sources
- **Note:** Check license and accessibility before committing

### 5. FiveThirtyEight Data
- **URL:** https://data.fivethirtyeight.com
- **Access:** Free, hosted on GitHub
- **Best for:** Well-documented, interesting datasets with context
- **File formats:** CSV
- **Topics:** Politics, sports, economics, culture

---

## Datasets by Statistical Method

### Chi-Square Test (Categorical Data)

#### Titanic Survival Dataset
- **Source:** Kaggle
- **URL:** https://www.kaggle.com/competitions/titanic/data
- **Variables:** Survival, passenger class, sex, age, fare
- **Sample size:** ~900 passengers
- **Research questions:** Is survival independent of passenger class? Gender?
- **Notes:** Classic dataset, very well-documented

#### Movie Genre and Rating
- **Source:** Kaggle (search "IMDB movies")
- **Variables:** Genre, rating, year, duration
- **Sample size:** Varies (1,000-50,000+)
- **Research questions:** Is genre independent of rating category? Year?

#### Student Survey Data
- **Source:** UCI Repository
- **URL:** https://archive.ics.uci.edu/ml/datasets/Student+Performance
- **Variables:** School, sex, study time, grades, alcohol consumption
- **Sample size:** 649 students
- **Research questions:** Is alcohol consumption independent of grades?

---

### Correlation Analysis (Two Continuous Variables)

#### Life Expectancy and GDP
- **Source:** Gapminder / Kaggle
- **URL:** Search "gapminder" on Kaggle
- **Variables:** Life expectancy, GDP per capita, population, year
- **Sample size:** 200+ countries × multiple years
- **Research questions:** Correlation between GDP and life expectancy?

#### Air Quality Data
- **Source:** UCI Repository
- **URL:** https://archive.ics.uci.edu/ml/datasets/Air+Quality
- **Variables:** Temperature, humidity, pollutant levels
- **Sample size:** 9,000+ hourly measurements
- **Research questions:** Correlation between temperature and ozone?

#### Housing Prices
- **Source:** Kaggle (search "housing prices")
- **Variables:** Price, square footage, bedrooms, location
- **Sample size:** Varies (500-20,000+)
- **Research questions:** Correlation between square footage and price?

#### Exam Scores Dataset
- **Source:** Kaggle (search "students performance")
- **Variables:** Math score, reading score, writing score, study time
- **Sample size:** 1,000 students
- **Research questions:** Correlation between study time and scores?

---

### Linear Regression (One Outcome, One or More Predictors)

#### Boston Housing
- **Source:** Kaggle
- **URL:** Search "Boston housing dataset"
- **Variables:** Median home value, rooms, crime rate, distance to employment
- **Sample size:** 506 neighborhoods
- **Research questions:** Predict home value from number of rooms
- **Notes:** Classic dataset for regression

#### Medical Expenses
- **Source:** Kaggle
- **URL:** Search "insurance medical costs"
- **Variables:** Charges, age, BMI, children, smoker status, region
- **Sample size:** 1,300+ individuals
- **Research questions:** Predict medical costs from age and BMI

#### Salary Prediction
- **Source:** Kaggle (search "salary data")
- **Variables:** Salary, years of experience, education, job title
- **Sample size:** Varies
- **Research questions:** Predict salary from experience and education

---

### t-Test (Compare Two Groups)

#### Sleep Efficiency
- **Source:** Kaggle (search "sleep health")
- **Variables:** Sleep duration, age, gender, occupation, sleep quality
- **Sample size:** 400+ individuals
- **Research questions:** Do males and females differ in sleep duration?

#### Plant Growth Experiments
- **Source:** Built into R (datasets package)
- **R command:** `data(PlantGrowth)`
- **Variables:** Plant weight, treatment group
- **Sample size:** 30 plants
- **Research questions:** Do treatment groups differ from control?

#### Coffee and Alertness
- **Source:** Kaggle (search "coffee" or create simulated data)
- **Variables:** Alertness score, coffee consumption (yes/no), age
- **Sample size:** Varies or simulate ~100
- **Research questions:** Does coffee consumption affect alertness?

#### Test Scores: Method Comparison
- **Source:** Create or simulate
- **Variables:** Test score, teaching method (traditional vs. flipped)
- **Sample size:** 50-100 students
- **Research questions:** Do teaching methods produce different scores?

---

### ANOVA (Compare Three or More Groups)

#### Iris Dataset
- **Source:** Built into R (datasets package)
- **R command:** `data(iris)`
- **Variables:** Sepal length/width, petal length/width, species (3 types)
- **Sample size:** 150 flowers
- **Research questions:** Do petal lengths differ across species?
- **Notes:** Perfect for learning ANOVA

#### Diet and Weight Loss
- **Source:** Kaggle (search "diet weight loss")
- **Variables:** Weight loss, diet type (3-4 types), age, gender
- **Sample size:** 100-300 participants
- **Research questions:** Which diet produces most weight loss?

#### Anxiety by Study Method
- **Source:** Create or Kaggle (search "student anxiety")
- **Variables:** Anxiety score, study method (individual, group, online)
- **Sample size:** 60-150 students
- **Research questions:** Does anxiety differ by study method?

---

### Bootstrap Confidence Intervals

Bootstrap can be applied to almost any dataset where you want to estimate uncertainty. Good candidates:

#### Small Sample Datasets
- **Source:** Any dataset above with n < 50
- **Why:** Bootstrap is especially useful for small samples
- **Example:** Estimate mean with 95% CI using bootstrap

#### Skewed Data
- **Source:** Income data, housing prices, medical costs
- **Why:** Bootstrap doesn't assume normality
- **Example:** Median income with bootstrap CI

#### Correlation CI
- **Source:** Any correlation dataset above
- **Why:** Bootstrap provides CI for correlations
- **Example:** "What's the 95% CI for correlation between X and Y?"

---

## Creating Your Own Dataset

If you can't find suitable data, you can:

### 1. Survey Your Classmates
- Quick Google Form with 5-10 questions
- Aim for 30+ responses
- Topics: sleep, study habits, stress, social media use
- **Approval:** Check with instructor first

### 2. Collect Observational Data
- Count events (e.g., bike vs. car traffic at different times)
- Measure repeated observations (e.g., coffee prices at different shops)
- Record publicly available information (e.g., restaurant ratings)

### 3. Use Simulation in R
- Generate data that follows your research question
- Useful for understanding method mechanics
- Example: Simulate two groups with known difference for t-test

```r
set.seed(123)
control <- rnorm(30, mean=100, sd=15)
treatment <- rnorm(30, mean=110, sd=15)
data <- data.frame(
  score = c(control, treatment),
  group = rep(c("Control", "Treatment"), each=30)
)
```

---

## Dataset Selection Checklist

Before committing to a dataset, verify:

- [ ] **Size:** At least 30 observations (more is better)
- [ ] **Variables:** Contains the types needed for your method
- [ ] **Access:** You can download it easily
- [ ] **Quality:** No major missing data issues (or plan to handle them)
- [ ] **Documentation:** You understand what variables mean
- [ ] **Ethics:** Publicly available or you have permission to use
- [ ] **Interest:** You find the topic engaging
- [ ] **Scope:** Not too complex for a 10-minute presentation

---

## Tips for Data Exploration

Once you have your data:

1. **Load and inspect** - Look at first few rows, check variable types
2. **Summary statistics** - Means, SDs, ranges, counts
3. **Check for missing data** - Decide how to handle
4. **Visualize** - Histograms, boxplots, scatterplots
5. **Check assumptions** - Before running your statistical test
6. **Ask AI for help** - Use AI to explore and understand your data

---

## Getting Help

If you're struggling to find appropriate data:

- **Office Hours:** Dr. Molitor can suggest datasets for your question
- **Canvas Discussion:** Post what you're looking for, classmates may help
- **AI Tools:** Ask ChatGPT/Claude "Where can I find data about X for Y analysis?"
- **Librarian:** OSU librarians can help locate datasets

---

## Example Dataset-Method Pairings

| Research Question | Dataset | Method | Difficulty |
|-------------------|---------|--------|------------|
| Do survival rates differ by passenger class? | Titanic | Chi-Square | Easy |
| Is there correlation between GDP and life expectancy? | Gapminder | Correlation | Easy |
| Can we predict insurance costs from age and BMI? | Medical Insurance | Regression | Medium |
| Do males and females differ in sleep duration? | Sleep Health | t-test | Easy |
| Do iris species differ in petal length? | Iris | ANOVA | Easy |
| What's the 95% CI for median delivery time? | Any small dataset | Bootstrap | Medium |

---

## Dataset Ethics Reminder

- **Use publicly available data** or data you collected ethically
- **Cite your data source** in your presentation and write-up
- **Don't use proprietary data** without permission
- **Respect privacy** - no personal/identifiable information
- **Be transparent** about data cleaning or filtering choices

---

**Last Updated:** Fall 2025

**Questions?** Post in Canvas discussion or visit office hours

