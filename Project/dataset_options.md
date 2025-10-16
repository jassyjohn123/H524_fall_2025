# Dataset Options for H524 Group Projects

## Overview
This document provides 7 curated biostatistics datasets suitable for group projects in H524 Introduction to Biostatistics. Each dataset is publicly available, ethically sourced, and appropriate for descriptive statistics, hypothesis testing, and regression analysis.

---

## Dataset 1: NHANES 2015-2016 (Subset)

### Description
The National Health and Nutrition Examination Survey (NHANES) is a nationally representative survey of the US population that assesses health and nutritional status. This subset focuses on cardiovascular health, physical measurements, and laboratory results.

### Variables Included
- **Demographics**: Age, Sex, Race/Ethnicity, Education
- **Physical measurements**: Height, Weight, BMI, Blood Pressure (Systolic, Diastolic)
- **Laboratory**: Total Cholesterol, HDL, LDL, Triglycerides, Glucose
- **Lifestyle**: Smoking status, Physical activity level, Alcohol consumption
- **Health outcomes**: Diabetes diagnosis, Hypertension diagnosis

### Sample Research Questions
1. Is there a significant association between BMI category (normal, overweight, obese) and systolic blood pressure?
2. Do males and females differ significantly in HDL cholesterol levels after controlling for age?
3. Is physical activity level associated with lower prevalence of diabetes?

### How to Access
- **Source**: CDC NHANES (https://www.cdc.gov/nchs/nhanes/)
- **Direct access**: Available through R package `NHANES`
- Install: `install.packages("NHANES")`

### R Code Snippet
```r
# Load NHANES data
library(NHANES)
data(NHANES)

# Preview the data
str(NHANES)
summary(NHANES)

# Select relevant subset
nhanes_subset <- NHANES[, c("Age", "Gender", "Race1", "Education",
                             "BMI", "BPSysAve", "BPDiaAve",
                             "TotChol", "HDLChol", "Diabetes",
                             "PhysActive", "Smoke100")]

# Remove missing data for key variables
nhanes_clean <- na.omit(nhanes_subset)
head(nhanes_clean)
```

### Why It's Appropriate
NHANES is a gold-standard public health dataset with well-documented variables. The data includes both continuous and categorical variables suitable for all course topics. Students can practice data cleaning, descriptive statistics, and hypothesis testing with real-world health data.

---

## Dataset 2: Framingham Heart Study (Teaching Version)

### Description
The Framingham Heart Study is one of the most influential longitudinal studies in cardiovascular epidemiology. This teaching dataset contains baseline data on cardiovascular risk factors and 10-year coronary heart disease (CHD) outcomes.

### Variables Included
- **Demographics**: Sex, Age, Education level
- **Risk factors**: Smoking status (current smoker), Cigarettes per day
- **Clinical measurements**: Systolic BP, Diastolic BP, Total Cholesterol, BMI, Heart Rate, Glucose
- **Medical history**: BP medication, Prevalent stroke, Prevalent hypertension, Diabetes
- **Outcome**: 10-year CHD risk (binary outcome)

### Sample Research Questions
1. Are systolic blood pressure and total cholesterol significant predictors of 10-year CHD risk?
2. Does the relationship between age and CHD risk differ by sex?
3. Is there a dose-response relationship between cigarettes per day and CHD risk among smokers?

### How to Access
- **Source**: Available through multiple R packages
- **Primary source**: `frisk` package or download from Kaggle
- URL: https://www.kaggle.com/datasets/dileep070/heart-disease-prediction-using-logistic-regression

### R Code Snippet
```r
# Load Framingham data from URL
framingham_url <- "https://raw.githubusercontent.com/selva86/datasets/master/framingham.csv"
framingham <- read.csv(framingham_url)

# Preview the data
str(framingham)
summary(framingham)

# Check for missing values
colSums(is.na(framingham))

# Basic exploration
table(framingham$TenYearCHD)  # Outcome distribution
hist(framingham$age, main="Age Distribution", xlab="Age")
```

### Why It's Appropriate
The Framingham dataset is a classic epidemiological dataset that students may have heard of. It provides clear clinical variables with biological meaning, making interpretation straightforward. The binary outcome (CHD risk) is ideal for comparing groups and testing associations.

---

## Dataset 3: COVID-19 Outcomes and Risk Factors

### Description
This dataset contains de-identified patient records from COVID-19 cases, including demographics, comorbidities, and outcomes. Data compiled from public health reporting systems during the 2020-2021 pandemic period.

### Variables Included
- **Demographics**: Age group, Sex, Race/Ethnicity
- **Comorbidities**: Diabetes, Hypertension, Cardiovascular disease, Chronic lung disease, Obesity
- **Clinical presentation**: Symptoms (fever, cough, shortness of breath), Days from symptom onset to testing
- **Outcomes**: Hospitalization, ICU admission, Mechanical ventilation, Death
- **Other**: Vaccination status (if applicable)

### Sample Research Questions
1. Do patients with obesity have significantly higher rates of hospitalization compared to non-obese patients?
2. Is there a significant association between number of comorbidities and ICU admission?
3. Does age group significantly predict mortality after controlling for comorbidities?

### How to Access
- **Source**: CDC COVID-19 Case Surveillance Public Use Data
- URL: https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf
- **Note**: Large dataset - recommend sampling or filtering by date range

### R Code Snippet
```r
# Load COVID-19 data (using sample/filtered version)
# Full dataset is very large - use subset for teaching
covid_url <- "https://data.cdc.gov/api/views/vbim-akqf/rows.csv?accessType=DOWNLOAD"

# For classroom use, load a manageable subset
# Option 1: Read first 10000 rows
covid_data <- read.csv(covid_url, nrows=10000)

# Option 2: Use pre-filtered state-level data
# Students can filter to specific time period or states
str(covid_data)
summary(covid_data)

# Recode variables as needed
covid_data$hosp_yn <- factor(covid_data$hosp_yn,
                               levels=c("Yes", "No", "Unknown", "Missing"))
```

### Why It's Appropriate
Highly relevant and timely dataset that students can relate to. Clear research questions about risk factors and outcomes. Good for practicing categorical data analysis and relative risk calculations. Large sample size allows for subgroup analyses.

---

## Dataset 4: Breast Cancer Wisconsin (Diagnostic)

### Description
This dataset contains measurements from digitized images of fine needle aspirate (FNA) of breast masses. Features describe characteristics of cell nuclei present in the images. Widely used for classification and diagnostic studies.

### Variables Included
- **ID**: Patient ID
- **Diagnosis**: Malignant (M) or Benign (B)
- **Nuclear features** (mean, SE, and worst values for each):
  - Radius, Texture, Perimeter, Area, Smoothness
  - Compactness, Concavity, Concave points, Symmetry, Fractal dimension
- Total: 30 continuous predictor variables

### Sample Research Questions
1. Do malignant tumors have significantly larger mean radius than benign tumors?
2. Is there a correlation between tumor area and concavity in malignant cases?
3. Which nuclear features are most strongly associated with malignancy?

### How to Access
- **Source**: UCI Machine Learning Repository
- Available in R through multiple packages
- Direct URL: https://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+(Diagnostic)

### R Code Snippet
```r
# Load breast cancer data
library(mlbench)
data(BreastCancer)

# Or load from URL
bc_url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data"
bc_data <- read.csv(bc_url, header=FALSE)

# Add column names
colnames(bc_data) <- c("ID", "Diagnosis",
                        paste0("radius_", c("mean", "se", "worst")),
                        paste0("texture_", c("mean", "se", "worst")),
                        paste0("perimeter_", c("mean", "se", "worst")),
                        paste0("area_", c("mean", "se", "worst")),
                        paste0("smoothness_", c("mean", "se", "worst")),
                        paste0("compactness_", c("mean", "se", "worst")),
                        paste0("concavity_", c("mean", "se", "worst")),
                        paste0("concave_pts_", c("mean", "se", "worst")),
                        paste0("symmetry_", c("mean", "se", "worst")),
                        paste0("fractal_dim_", c("mean", "se", "worst")))

# Preview
str(bc_data)
table(bc_data$Diagnosis)

# Focus on mean values for simpler analysis
bc_subset <- bc_data[, c("Diagnosis",
                          grep("_mean", colnames(bc_data), value=TRUE))]
```

### Why It's Appropriate
Clean, well-documented dataset with no missing values. Contains both continuous measurements and binary outcome. Excellent for comparing two groups (malignant vs benign) and exploring correlations among multiple continuous variables. Medical context is clear and interpretable.

---

## Dataset 5: Low Birth Weight Study

### Description
This classic dataset from Hosmer and Lemeshow examines risk factors associated with giving birth to low birth weight infants (< 2500 grams). Contains data on 189 births at Baystate Medical Center, Springfield, MA.

### Variables Included
- **Outcome**: Low birth weight (binary: <2500g or >=2500g)
- **Demographics**: Mother's age, Mother's race
- **Medical history**: Number of previous premature labors, History of hypertension, Presence of uterine irritability
- **Pregnancy factors**: Number of physician visits during first trimester
- **Lifestyle**: Smoking status during pregnancy, Mother's weight at last menstrual period

### Sample Research Questions
1. Is maternal smoking during pregnancy associated with increased risk of low birth weight?
2. Does mother's age have a linear relationship with infant birth weight?
3. Is there a significant interaction between smoking and number of prenatal visits on birth weight?

### How to Access
- **Source**: Available in R package `MASS`
- Install: `install.packages("MASS")`
- Original source: Hosmer, D.W. and Lemeshow, S. (1989) Applied Logistic Regression

### R Code Snippet
```r
# Load low birth weight data
library(MASS)
data(birthwt)

# Preview
str(birthwt)
summary(birthwt)

# Convert factors with meaningful labels
birthwt$race <- factor(birthwt$race,
                        levels=c(1,2,3),
                        labels=c("White", "Black", "Other"))
birthwt$smoke <- factor(birthwt$smoke,
                         levels=c(0,1),
                         labels=c("Non-smoker", "Smoker"))
birthwt$low <- factor(birthwt$low,
                       levels=c(0,1),
                       labels=c("Normal", "Low"))

# Descriptive statistics by group
aggregate(bwt ~ smoke, data=birthwt, FUN=mean)
table(birthwt$low, birthwt$smoke)
```

### Why It's Appropriate
Manageable sample size (n=189) ideal for student projects. Clear clinical outcome with important public health implications. Mix of continuous and categorical predictors. Well-suited for two-sample tests, ANOVA, and introduction to multivariable analysis. Historical dataset widely used in teaching.

---

## Dataset 6: Diabetes Health Indicators (BRFSS)

### Description
This dataset is derived from the CDC's Behavioral Risk Factor Surveillance System (BRFSS), containing survey responses related to diabetes diagnosis and health risk behaviors. Includes responses from over 250,000 individuals.

### Variables Included
- **Outcome**: Diabetes status (0=no diabetes, 1=prediabetes, 2=diabetes)
- **Health indicators**: BMI, High blood pressure, High cholesterol, Smoker status
- **Health behaviors**: Physical activity, Fruits/vegetables consumption, Heavy alcohol consumption
- **Demographics**: Age, Sex, Education, Income
- **Healthcare access**: Any healthcare coverage, Could not see doctor due to cost
- **General health**: Self-reported health status (excellent to poor), Mental health days, Physical health days
- **Other**: Difficulty walking/climbing stairs, Stroke history, Heart disease/attack history

### Sample Research Questions
1. Is there a dose-response relationship between BMI category and diabetes prevalence?
2. Do individuals with diabetes report significantly more poor physical health days than non-diabetics?
3. Is physical activity associated with lower diabetes risk after adjusting for BMI?

### How to Access
- **Source**: Kaggle / UCI ML Repository
- URL: https://www.kaggle.com/datasets/alexteboul/diabetes-health-indicators-dataset
- **Note**: Multiple versions available (full 253k, balanced 70k, binary outcome)

### R Code Snippet
```r
# Load diabetes health indicators
# Download from Kaggle or use direct link if available
diabetes_url <- "https://raw.githubusercontent.com/imanewman/Diabetes-Classification/master/data/diabetes_binary_health_indicators_BRFSS2015.csv"
diabetes <- read.csv(diabetes_url)

# Preview
str(diabetes)
summary(diabetes)

# Check distribution of outcome
table(diabetes$Diabetes_binary)
prop.table(table(diabetes$Diabetes_binary))

# Create BMI categories
diabetes$BMI_category <- cut(diabetes$BMI,
                              breaks=c(0, 18.5, 25, 30, Inf),
                              labels=c("Underweight", "Normal", "Overweight", "Obese"))

# Explore relationship
table(diabetes$Diabetes_binary, diabetes$BMI_category)
```

### Why It's Appropriate
Very large sample size allows for complex analyses and subgroup comparisons. Multiple health indicators provide numerous research question options. Binary outcome simplifies interpretation. Realistic public health data with policy implications. Students can practice sampling strategies if full dataset is too large.

---

## Dataset 7: Lung Capacity Study

### Description
This dataset contains measurements of lung capacity (Forced Expiratory Volume - FEV) and associated factors for 654 participants in a health study. Ideal for exploring relationships between continuous outcomes and multiple predictors.

### Variables Included
- **Outcome**: Forced Expiratory Volume (FEV) in liters
- **Physical**: Age (years), Height (inches)
- **Demographic**: Gender (male/female)
- **Environmental/Behavioral**: Smoke (smoking status), Caesarean (born via C-section or not)

### Sample Research Questions
1. Is there a significant positive correlation between age and lung capacity in children/adolescents?
2. Does smoking status significantly reduce lung capacity after controlling for age and height?
3. Is the relationship between height and lung capacity different for males and females?

### How to Access
- **Source**: Available from various R package repositories
- Can be loaded from: https://github.com/cran/GLMsData/tree/master/data
- Also available through direct download

### R Code Snippet
```r
# Load lung capacity data
# Option 1: From URL
lungcap_url <- "https://raw.githubusercontent.com/byuistaticsprep/prep/master/data/LungCapData.csv"
lungcap <- read.csv(lungcap_url)

# Option 2: From local file (if downloaded)
# lungcap <- read.csv("LungCapData.csv")

# Preview
str(lungcap)
summary(lungcap)

# Check for missing values
sum(is.na(lungcap))

# Basic visualizations
hist(lungcap$FEV, main="Distribution of Lung Capacity (FEV)", xlab="FEV (L)")
plot(lungcap$Age, lungcap$FEV, xlab="Age", ylab="FEV (L)",
     main="Lung Capacity (FEV) vs Age")

# Summary by smoking status
aggregate(FEV ~ Smoke, data=lungcap, FUN=mean)
```

### Why It's Appropriate
Clean dataset with no missing values and moderate sample size. Clear continuous outcome suitable for correlation and regression analysis. Simple variables that are easy to interpret. Good for demonstrating confounding (smoking appears protective until you control for age). Appropriate for all major course topics: descriptive stats, t-tests, ANOVA, correlation, and linear regression.

---

## General Guidelines for Student Projects

### Dataset Selection
- Groups should select ONE dataset for their final project
- Consider research interests and complexity level
- Ensure the dataset has sufficient variables for the required analyses

### Required Analyses
Each project should include:
1. **Descriptive statistics**: Summary tables, appropriate graphs
2. **Two-sample comparisons**: t-tests or non-parametric equivalents
3. **Categorical associations**: Chi-square tests or Fisher's exact test
4. **Correlation analysis**: Between continuous variables
5. **Simple linear regression**: One predictor, one outcome
6. **Presentation**: Clear interpretation and conclusions

### Data Ethics
- All datasets are de-identified and publicly available
- Proper citation of data sources is required
- Interpretation should be scientifically sound and avoid overgeneralization

### R Packages Needed
```r
# Install required packages
install.packages(c("NHANES", "MASS", "mlbench", "dplyr", "ggplot2",
                   "readr", "tidyr", "knitr"))
```

---

## Additional Resources

### Where to Find More Datasets
- **R built-in datasets**: Type `data()` in R console
- **CDC Data Portal**: https://data.cdc.gov/
- **UCI ML Repository**: https://archive.ics.uci.edu/ml/
- **Kaggle Datasets**: https://www.kaggle.com/datasets (filter for health/medicine)
- **OpenIntro Statistics**: https://www.openintro.org/data/

### Questions?
Contact the instructor if:
- A dataset link is broken
- You need help accessing or loading a dataset
- Your group wants to propose an alternative dataset
- You need guidance on appropriate research questions

---

*Last updated: October 2025*
