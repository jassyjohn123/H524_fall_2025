# H524 Project Datasets - Quick Reference

## Overview
This directory contains curated biostatistics datasets for student group projects in H524 Introduction to Biostatistics (Fall 2025).

## Files in This Directory

### 1. `dataset_options.md`
Comprehensive documentation for all 7 curated datasets including:
- Dataset descriptions
- Variable lists
- Sample research questions
- Access instructions
- R code examples
- Appropriateness rationale

### 2. `code/dataset_loaders.R`
R script with pre-built functions to load and explore each dataset. Simply source this file and use the loader functions.

## Quick Start

### Option 1: Use Pre-built Loader Functions
```r
# Source the loader script
source("code/dataset_loaders.R")

# Load a specific dataset
nhanes_data <- load_nhanes()
framingham_data <- load_framingham()
birthweight_data <- load_birthweight()
breast_cancer_data <- load_breast_cancer()
diabetes_data <- load_diabetes()
lungcap_data <- load_lungcap()

# Explore a dataset
explore_dataset(nhanes_data, "NHANES")
```

### Option 2: Load All Datasets at Once
```r
source("code/dataset_loaders.R")
all_datasets <- load_all_datasets()

# Access individual datasets
all_datasets$nhanes
all_datasets$framingham
all_datasets$birthweight
```

## Available Datasets

| # | Dataset Name | Observations | Source | Difficulty |
|---|--------------|--------------|--------|------------|
| 1 | NHANES 2015-2016 | 10,000 (subset) | R package | Easy |
| 2 | Framingham Heart Study | 4,240 | GitHub/CSV | Easy |
| 3 | COVID-19 Outcomes | 253,680+ | CDC API | Medium |
| 4 | Breast Cancer Wisconsin | 569 | UCI ML Repository | Easy |
| 5 | Low Birth Weight Study | 189 | R package (MASS) | Easy |
| 6 | Diabetes Health Indicators | 253,680 | GitHub/CSV | Medium |
| 7 | Lung Capacity Study | 654 | GitHub/CSV | Easy |

## Dataset Recommendations by Analysis Type

### For Beginners
- **Low Birth Weight Study** (n=189): Small, manageable dataset with clear variables
- **Lung Capacity Study** (n=654): Clean data, no missing values, straightforward relationships
- **Breast Cancer Wisconsin** (n=569): No missing data, binary outcome, good for two-sample tests

### For Intermediate Analysis
- **Framingham Heart Study** (n=4,240): Classic epidemiology dataset, well-documented
- **NHANES** (subset): Nationally representative, multiple health indicators

### For Advanced Students
- **Diabetes Health Indicators** (n=253k): Large dataset, requires sampling strategy
- **COVID-19 Outcomes** (n=253k): Timely topic, complex data structure

## Required R Packages

The following packages are automatically installed when you source `dataset_loaders.R`:
- `NHANES`: For NHANES dataset
- `MASS`: For birth weight dataset
- `dplyr`: For data manipulation
- `ggplot2`: For visualization

Additional recommended packages:
```r
install.packages(c("knitr", "tidyr", "readr"))
```

## Troubleshooting

### Dataset Won't Load
1. Check internet connection (most datasets load from URLs)
2. Verify R packages are installed: `source("code/dataset_loaders.R")` will auto-install
3. For large datasets (Diabetes, COVID), loading may take 1-2 minutes

### Missing Data
- Some datasets have missing values by design (e.g., NHANES)
- Use `load_nhanes(clean=TRUE)` to automatically remove rows with missing data
- Check missing data with: `colSums(is.na(dataset))`

### Dataset Too Large
For Diabetes and COVID-19 datasets:
```r
# These functions return both full and sample datasets
diabetes_data <- load_diabetes()
diabetes_data$sample  # 5,000 row sample
diabetes_data$full    # Full 253k rows

covid_data <- load_covid_sample(nrows=5000)  # Load only 5000 rows
```

## Getting Help

### Within R
```r
# View dataset structure
str(dataset_name)

# View summary statistics
summary(dataset_name)

# Use the explore_dataset function
explore_dataset(dataset_name, "My Dataset")
```

### Documentation
- Full dataset documentation: See `dataset_options.md`
- Variable descriptions: Available in loader function output
- Research questions: Listed in `dataset_options.md`

### Contact
If you encounter issues:
1. Check `dataset_options.md` for alternative download methods
2. Verify internet connection for URL-based datasets
3. Contact the instructor if problems persist

## Tips for Project Success

1. **Choose early**: Give your group time to explore the data before the deadline
2. **Start small**: Use `head()`, `summary()`, and basic plots before complex analyses
3. **Check assumptions**: Verify normality, equal variances, etc. before statistical tests
4. **Document everything**: Keep track of data cleaning steps and transformations
5. **Cite properly**: Include data source citations in your final report

## Data Ethics Reminder

All datasets provided are:
- De-identified (no personal information)
- Publicly available
- Appropriate for educational use

Students must:
- Cite data sources properly
- Interpret results responsibly
- Avoid overgeneralization
- Respect the scientific nature of the data

---

*Last updated: October 2025*
*For questions, contact the H524 instructor*
