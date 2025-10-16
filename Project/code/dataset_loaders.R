################################################################################
# Dataset Loaders for H524 Group Projects
# Fall 2025
#
# This script provides functions to load and perform basic exploration of
# 7 curated biostatistics datasets suitable for student projects.
#
# Each function loads the dataset, performs basic cleaning, and provides
# summary information.
################################################################################

# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org/"))

# Required packages
required_packages <- c("NHANES", "MASS", "mlbench", "dplyr", "ggplot2")

# Function to check and install packages
check_packages <- function() {
  for (pkg in required_packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      cat("Installing package:", pkg, "\n")
      install.packages(pkg, dependencies = TRUE)
    }
  }
}

# Run package check
check_packages()

################################################################################
# Dataset 1: NHANES 2015-2016
################################################################################

load_nhanes <- function(clean = TRUE) {
  cat("Loading NHANES dataset...\n")

  library(NHANES)
  data(NHANES)

  # Select relevant subset of variables
  nhanes_subset <- NHANES[, c("Age", "Gender", "Race1", "Education",
                               "BMI", "BPSysAve", "BPDiaAve",
                               "TotChol", "HDLChol", "Diabetes",
                               "PhysActive", "Smoke100")]

  if (clean) {
    cat("Removing rows with missing data...\n")
    nhanes_subset <- na.omit(nhanes_subset)
  }

  # Print summary
  cat("\n=== NHANES Dataset Summary ===\n")
  cat("Dimensions:", nrow(nhanes_subset), "rows x", ncol(nhanes_subset), "columns\n")
  cat("\nVariable types:\n")
  print(str(nhanes_subset))
  cat("\nFirst few rows:\n")
  print(head(nhanes_subset))
  cat("\nMissing data summary:\n")
  print(colSums(is.na(nhanes_subset)))

  return(nhanes_subset)
}


################################################################################
# Dataset 2: Framingham Heart Study
################################################################################

load_framingham <- function() {
  cat("Loading Framingham Heart Study dataset...\n")

  # Updated working URL
  framingham_url <- "https://raw.githubusercontent.com/GauravPadawe/Framingham-Heart-Study/master/framingham.csv"

  tryCatch({
    framingham <- read.csv(framingham_url)

    # Print summary
    cat("\n=== Framingham Dataset Summary ===\n")
    cat("Dimensions:", nrow(framingham), "rows x", ncol(framingham), "columns\n")
    cat("\nVariable types:\n")
    print(str(framingham))
    cat("\nFirst few rows:\n")
    print(head(framingham))
    cat("\nMissing data summary:\n")
    print(colSums(is.na(framingham)))
    cat("\nOutcome distribution (10-year CHD):\n")
    print(table(framingham$TenYearCHD))

    return(framingham)
  }, error = function(e) {
    cat("Error loading Framingham data from URL:\n", e$message, "\n")
    cat("Please check internet connection or download manually.\n")
    return(NULL)
  })
}


################################################################################
# Dataset 3: COVID-19 Outcomes
################################################################################

load_covid_sample <- function(nrows = 10000) {
  cat("Loading COVID-19 dataset (sample of", nrows, "rows)...\n")
  cat("Note: Full dataset is very large. Using subset for demonstration.\n")

  covid_url <- "https://data.cdc.gov/api/views/vbim-akqf/rows.csv?accessType=DOWNLOAD"

  tryCatch({
    # Read sample of data
    covid_data <- read.csv(covid_url, nrows = nrows)

    # Basic cleaning and recoding
    if ("hosp_yn" %in% names(covid_data)) {
      covid_data$hosp_yn <- factor(covid_data$hosp_yn)
    }
    if ("death_yn" %in% names(covid_data)) {
      covid_data$death_yn <- factor(covid_data$death_yn)
    }
    if ("icu_yn" %in% names(covid_data)) {
      covid_data$icu_yn <- factor(covid_data$icu_yn)
    }

    # Print summary
    cat("\n=== COVID-19 Dataset Summary ===\n")
    cat("Dimensions:", nrow(covid_data), "rows x", ncol(covid_data), "columns\n")
    cat("(Note: This is a", nrows, "row sample from full dataset)\n")
    cat("\nVariable names:\n")
    print(names(covid_data))
    cat("\nFirst few rows:\n")
    print(head(covid_data))

    return(covid_data)
  }, error = function(e) {
    cat("Error loading COVID-19 data:\n", e$message, "\n")
    cat("The CDC API may be temporarily unavailable.\n")
    return(NULL)
  })
}


################################################################################
# Dataset 4: Breast Cancer Wisconsin
################################################################################

load_breast_cancer <- function() {
  cat("Loading Breast Cancer Wisconsin dataset...\n")

  bc_url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data"

  tryCatch({
    bc_data <- read.csv(bc_url, header = FALSE)

    # Add column names
    colnames(bc_data) <- c("ID", "Diagnosis",
                            paste0(rep(c("radius", "texture", "perimeter", "area", "smoothness",
                                         "compactness", "concavity", "concave_pts", "symmetry",
                                         "fractal_dim"), each = 3),
                                   "_", rep(c("mean", "se", "worst"), 10)))

    # Convert diagnosis to factor
    bc_data$Diagnosis <- factor(bc_data$Diagnosis, levels = c("B", "M"),
                                  labels = c("Benign", "Malignant"))

    # Print summary
    cat("\n=== Breast Cancer Wisconsin Dataset Summary ===\n")
    cat("Dimensions:", nrow(bc_data), "rows x", ncol(bc_data), "columns\n")
    cat("\nDiagnosis distribution:\n")
    print(table(bc_data$Diagnosis))
    cat("\nFirst few rows (selected columns):\n")
    print(head(bc_data[, c("ID", "Diagnosis", "radius_mean", "texture_mean",
                            "area_mean", "smoothness_mean")]))
    cat("\nMissing data:\n")
    print(sum(is.na(bc_data)))

    # Create simplified version with just mean values
    bc_subset <- bc_data[, c("ID", "Diagnosis", grep("_mean", names(bc_data), value = TRUE))]

    cat("\nSimplified dataset (mean values only):\n")
    cat("Dimensions:", nrow(bc_subset), "rows x", ncol(bc_subset), "columns\n")

    return(list(full = bc_data, subset = bc_subset))
  }, error = function(e) {
    cat("Error loading Breast Cancer data:\n", e$message, "\n")
    cat("Please check internet connection or try alternative source.\n")
    return(NULL)
  })
}


################################################################################
# Dataset 5: Low Birth Weight Study
################################################################################

load_birthweight <- function() {
  cat("Loading Low Birth Weight dataset...\n")

  library(MASS)
  data(birthwt)

  # Create version with factor labels
  birthwt_labeled <- birthwt

  birthwt_labeled$race <- factor(birthwt$race,
                                  levels = c(1, 2, 3),
                                  labels = c("White", "Black", "Other"))

  birthwt_labeled$smoke <- factor(birthwt$smoke,
                                   levels = c(0, 1),
                                   labels = c("Non-smoker", "Smoker"))

  birthwt_labeled$low <- factor(birthwt$low,
                                 levels = c(0, 1),
                                 labels = c("Normal", "Low Birth Weight"))

  birthwt_labeled$ht <- factor(birthwt$ht,
                                levels = c(0, 1),
                                labels = c("No", "Yes"))

  birthwt_labeled$ui <- factor(birthwt$ui,
                                levels = c(0, 1),
                                labels = c("No", "Yes"))

  # Print summary
  cat("\n=== Low Birth Weight Dataset Summary ===\n")
  cat("Dimensions:", nrow(birthwt_labeled), "rows x", ncol(birthwt_labeled), "columns\n")
  cat("\nVariable descriptions:\n")
  cat("  low: Low birth weight indicator (<2500g)\n")
  cat("  age: Mother's age in years\n")
  cat("  lwt: Mother's weight in pounds at last menstrual period\n")
  cat("  race: Mother's race (White, Black, Other)\n")
  cat("  smoke: Smoking status during pregnancy\n")
  cat("  ptl: Number of previous premature labors\n")
  cat("  ht: History of hypertension\n")
  cat("  ui: Presence of uterine irritability\n")
  cat("  ftv: Number of physician visits during first trimester\n")
  cat("  bwt: Birth weight in grams\n")

  cat("\nOutcome distribution:\n")
  print(table(birthwt_labeled$low))

  cat("\nBirth weight by smoking status:\n")
  print(aggregate(bwt ~ smoke, data = birthwt_labeled, FUN = mean))

  cat("\nFirst few rows:\n")
  print(head(birthwt_labeled))

  return(birthwt_labeled)
}


################################################################################
# Dataset 6: Diabetes Health Indicators
################################################################################

load_diabetes <- function() {
  cat("Loading Diabetes Health Indicators dataset...\n")

  # Updated working URL
  diabetes_url <- "https://raw.githubusercontent.com/Helmy2/Diabetes-Health-Indicators/main/diabetes_binary_health_indicators_BRFSS2015.csv"

  tryCatch({
    diabetes <- read.csv(diabetes_url)

    # Convert to factors
    diabetes$Diabetes_binary <- factor(diabetes$Diabetes_binary,
                                        levels = c(0, 1),
                                        labels = c("No Diabetes", "Diabetes"))

    # Create BMI categories
    diabetes$BMI_category <- cut(diabetes$BMI,
                                  breaks = c(0, 18.5, 25, 30, Inf),
                                  labels = c("Underweight", "Normal", "Overweight", "Obese"),
                                  right = FALSE)

    # Print summary
    cat("\n=== Diabetes Health Indicators Dataset Summary ===\n")
    cat("Dimensions:", nrow(diabetes), "rows x", ncol(diabetes), "columns\n")
    cat("Note: This is a large dataset. Consider sampling for initial exploration.\n")

    cat("\nDiabetes prevalence:\n")
    print(table(diabetes$Diabetes_binary))
    print(prop.table(table(diabetes$Diabetes_binary)))

    cat("\nVariable names:\n")
    print(names(diabetes))

    cat("\nDiabetes by BMI category:\n")
    print(table(diabetes$Diabetes_binary, diabetes$BMI_category))

    # Create a smaller sample for easier handling
    diabetes_sample <- diabetes[sample(1:nrow(diabetes), min(5000, nrow(diabetes))), ]

    cat("\nCreated sample dataset with", nrow(diabetes_sample), "rows for easier exploration.\n")

    return(list(full = diabetes, sample = diabetes_sample))
  }, error = function(e) {
    cat("Error loading Diabetes data:\n", e$message, "\n")
    cat("Please check internet connection or download manually from Kaggle.\n")
    return(NULL)
  })
}


################################################################################
# Dataset 7: Lung Capacity Study
################################################################################

load_lungcap <- function() {
  cat("Loading Lung Capacity dataset...\n")

  # Updated working URL
  lungcap_url <- "https://raw.githubusercontent.com/tkseneee/Dataset/master/LungCapdata.csv"

  tryCatch({
    lungcap <- read.csv(lungcap_url)

    # Convert categorical variables to factors
    if ("Gender" %in% names(lungcap)) {
      lungcap$Gender <- factor(lungcap$Gender,
                               levels = c(0, 1),
                               labels = c("Female", "Male"))
    }
    if ("Smoke" %in% names(lungcap)) {
      lungcap$Smoke <- factor(lungcap$Smoke,
                              levels = c(0, 1),
                              labels = c("Non-smoker", "Smoker"))
    }
    if ("Caesarean" %in% names(lungcap)) {
      lungcap$Caesarean <- factor(lungcap$Caesarean,
                                   levels = c(0, 1),
                                   labels = c("No", "Yes"))
    }

    # Print summary
    cat("\n=== Lung Capacity Dataset Summary ===\n")
    cat("Dimensions:", nrow(lungcap), "rows x", ncol(lungcap), "columns\n")

    cat("\nVariable summary:\n")
    print(summary(lungcap))

    cat("\nMissing data:\n")
    print(colSums(is.na(lungcap)))

    # Only show aggregations if Smoke and FEV are properly coded
    if (!is.null(lungcap$Smoke) && !all(is.na(lungcap$Smoke)) && "FEV" %in% names(lungcap)) {
      cat("\nLung capacity (FEV) by smoking status:\n")
      print(aggregate(FEV ~ Smoke, data = lungcap, FUN = mean))
    }

    if ("FEV" %in% names(lungcap) && "Gender" %in% names(lungcap)) {
      cat("\nLung capacity (FEV) by gender:\n")
      print(aggregate(FEV ~ Gender, data = lungcap, FUN = mean))
    }

    cat("\nFirst few rows:\n")
    print(head(lungcap))

    return(lungcap)
  }, error = function(e) {
    cat("Error loading Lung Capacity data:\n", e$message, "\n")
    cat("Please check internet connection.\n")
    return(NULL)
  })
}


################################################################################
# Master function to load all datasets
################################################################################

load_all_datasets <- function() {
  cat(paste(rep("=", 80), collapse=""), "\n")
  cat("Loading all H524 project datasets...\n")
  cat(paste(rep("=", 80), collapse=""), "\n\n")

  datasets <- list()

  # Dataset 1: NHANES
  cat("\n", rep("=", 80), "\n")
  datasets$nhanes <- load_nhanes()

  # Dataset 2: Framingham
  cat("\n", rep("=", 80), "\n")
  datasets$framingham <- load_framingham()

  # Dataset 3: COVID-19 (sample)
  cat("\n", rep("=", 80), "\n")
  datasets$covid <- load_covid_sample(nrows = 5000)

  # Dataset 4: Breast Cancer
  cat("\n", rep("=", 80), "\n")
  datasets$breast_cancer <- load_breast_cancer()

  # Dataset 5: Birth Weight
  cat("\n", rep("=", 80), "\n")
  datasets$birthweight <- load_birthweight()

  # Dataset 6: Diabetes
  cat("\n", rep("=", 80), "\n")
  datasets$diabetes <- load_diabetes()

  # Dataset 7: Lung Capacity
  cat("\n", rep("=", 80), "\n")
  datasets$lungcap <- load_lungcap()

  cat("\n", rep("=", 80), "\n")
  cat("All datasets loaded successfully!\n")
  cat("Access datasets using: datasets$nhanes, datasets$framingham, etc.\n")
  cat(rep("=", 80), "\n\n")

  return(datasets)
}


################################################################################
# Utility function: Quick exploration of any dataset
################################################################################

explore_dataset <- function(data, dataset_name = "Dataset") {
  cat("\n=== Exploring:", dataset_name, "===\n\n")

  # Dimensions
  cat("Dimensions:", nrow(data), "rows x", ncol(data), "columns\n\n")

  # Structure
  cat("Structure:\n")
  str(data)

  # Summary statistics
  cat("\nSummary Statistics:\n")
  print(summary(data))

  # Missing data
  cat("\nMissing Data:\n")
  missing <- colSums(is.na(data))
  print(missing[missing > 0])
  if (sum(missing) == 0) {
    cat("No missing data!\n")
  }

  # First few rows
  cat("\nFirst 6 rows:\n")
  print(head(data))

  # Numeric variables
  numeric_vars <- names(data)[sapply(data, is.numeric)]
  if (length(numeric_vars) > 0) {
    cat("\nNumeric variables:", paste(numeric_vars, collapse = ", "), "\n")
  }

  # Categorical variables
  factor_vars <- names(data)[sapply(data, is.factor)]
  if (length(factor_vars) > 0) {
    cat("\nCategorical variables:", paste(factor_vars, collapse = ", "), "\n")
    cat("\nFrequency tables for categorical variables:\n")
    for (var in factor_vars) {
      cat("\n", var, ":\n")
      print(table(data[[var]]))
    }
  }
}


################################################################################
# Example usage
################################################################################

# To use this script:
#
# 1. Load a single dataset:
#    nhanes_data <- load_nhanes()
#    framingham_data <- load_framingham()
#    etc.
#
# 2. Load all datasets at once:
#    all_data <- load_all_datasets()
#
# 3. Explore a dataset:
#    explore_dataset(nhanes_data, "NHANES")
#
# 4. Access specific dataset from full collection:
#    all_data$nhanes
#    all_data$birthweight
#

cat("\n")
cat(paste(rep("=", 80), collapse=""), "\n")
cat("H524 Dataset Loaders - Ready!\n")
cat(paste(rep("=", 80), collapse=""), "\n")
cat("\nAvailable functions:\n")
cat("  - load_nhanes()          : NHANES 2015-2016\n")
cat("  - load_framingham()      : Framingham Heart Study\n")
cat("  - load_covid_sample()    : COVID-19 Outcomes (sample)\n")
cat("  - load_breast_cancer()   : Breast Cancer Wisconsin\n")
cat("  - load_birthweight()     : Low Birth Weight Study\n")
cat("  - load_diabetes()        : Diabetes Health Indicators\n")
cat("  - load_lungcap()         : Lung Capacity Study\n")
cat("  - load_all_datasets()    : Load all datasets at once\n")
cat("  - explore_dataset(data)  : Detailed exploration of any dataset\n")
cat("\nExample: my_data <- load_nhanes()\n")
cat(paste(rep("=", 80), collapse=""), "\n\n")
