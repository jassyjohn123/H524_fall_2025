#!/usr/bin/env Rscript
# Generate all graphics for Week 1 slides with 3D effects
# Dr. John Molitor, Oregon State University
# Fall 2025

# Install/load required packages
if (!require(plotrix)) install.packages("plotrix", repos = "http://cran.r-project.org")
library(plotrix)

# Set working directory to code folder
setwd("/Users/molitorj/ms/OSU/classes/AI_H524/H524_fall_2025/Week_1/slides/code")

# ============================================================================
# PREPARE DATA
# ============================================================================

# FEV1 Data: Lung function in adolescents with asthma
# Source: Pagano & Gauvreau "Principles of Biostatistics", pp. 38-39
fev1_data <- data.frame(
  subject_id = 1:13,
  fev1_liters = c(2.15, 2.20, 2.25, 2.50, 2.65, 2.75, 2.80,
                  2.85, 3.00, 3.15, 3.20, 3.85, 4.05),
  gender = factor(c("Female", "Female", "Female", "Male", "Female",
                    "Male", "Female", "Male", "Male", "Male",
                    "Female", "Male", "Male"))
)

# Childhood Injury Deaths Data
# Source: Pagano & Gauvreau "Principles of Biostatistics", pp. 24-25
injury_data <- data.frame(
  cause = rep(c("Motor Vehicle", "Drowning", "Fire", "Homicide", "Other"),
              times = c(48, 14, 12, 7, 19))
)
injury_data$cause <- factor(injury_data$cause,
                            levels = c("Motor Vehicle", "Drowning", "Fire", "Homicide", "Other"))

# ============================================================================
# GENERATE GRAPHICS FOR SLIDES
# ============================================================================
# NOTE: Only generating graphics that appear in current version of slides
# The slides now focus on detailed examples with explanations rather than
# standalone examples without context

# 1. Histogram - FEV1 Distribution (USED IN SLIDES)
pdf("histogram_fev1.pdf", width = 8, height = 6)
hist(fev1_data$fev1_liters,
     main = "Distribution of FEV1 (Lung Function)",
     xlab = "FEV1 (liters)",
     ylab = "Frequency",
     col = "#FF6B35",
     border = "white",
     breaks = 8)
abline(v = mean(fev1_data$fev1_liters), col = "red", lwd = 2, lty = 2)
text(mean(fev1_data$fev1_liters) + 0.2, 2.5,
     paste("Mean =", round(mean(fev1_data$fev1_liters), 2)), col = "red")
dev.off()

# 2. Box Plot - FEV1 by Gender (USED IN SLIDES)
pdf("boxplot_fev1_gender.pdf", width = 8, height = 6)
boxplot(fev1_liters ~ gender, data = fev1_data,
        main = "FEV1 Distribution by Gender",
        xlab = "Gender",
        ylab = "FEV1 (liters)",
        col = c("#FFD23F", "#FF6B35"),
        border = "black")
dev.off()

# 3. Scatter Plot - Subject ID vs FEV1 (USED IN SLIDES)
pdf("scatter_fev1.pdf", width = 8, height = 6)
plot(fev1_data$subject_id, fev1_data$fev1_liters,
     main = "FEV1 by Subject ID",
     xlab = "Subject ID",
     ylab = "FEV1 (liters)",
     pch = 19,
     col = ifelse(fev1_data$gender == "Male", "#4ECDC4", "#FF6B35"),
     cex = 1.2)
legend("topleft", legend = c("Female", "Male"),
       col = c("#FF6B35", "#4ECDC4"), pch = 19)
dev.off()

# 4. Bar Chart - Gender Distribution in FEV1 Study (USED IN SLIDES)
gender_counts <- table(fev1_data$gender)
pdf("barplot_gender_fev1.pdf", width = 8, height = 6)
barplot(gender_counts,
        main = "Gender Distribution in FEV1 Study",
        ylab = "Number of Subjects",
        xlab = "Gender",
        col = c("#FF6B35", "#F7931E"),
        border = "black")
dev.off()

# 5. Age-Specific Rates (USED IN SLIDES)
age_groups <- c("0-19", "20-39", "40-59", "60+")
population_by_age <- c(12000, 15000, 18000, 5000)
cases_by_age <- c(5, 25, 65, 30)
age_specific_rates <- (cases_by_age / population_by_age) * 100000

pdf("age_specific_rates.pdf", width = 8, height = 6)
barplot(age_specific_rates,
        names.arg = age_groups,
        main = "Age-Specific Disease Incidence Rates",
        xlab = "Age Group",
        ylab = "Rate per 100,000",
        col = "steelblue",
        border = "black")
dev.off()

cat("\n=== All graphics generated successfully ===\n")
cat("Files created in:", getwd(), "\n")
cat("\nGraphics used in current slides:\n")
cat("- histogram_fev1.pdf (Data Visualization: Histogram)\n")
cat("- boxplot_fev1_gender.pdf (Data Visualization: Box Plots)\n")
cat("- barplot_gender_fev1.pdf (Data Visualization: Bar Charts)\n")
cat("- scatter_fev1.pdf (Data Visualization: Scatter Plots)\n")
cat("- age_specific_rates.pdf (Rates and Standardization)\n")
cat("\nNote: Slides now focus on detailed examples with explanations\n")
cat("rather than standalone plots without context.\n")
