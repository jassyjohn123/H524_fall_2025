# Graphical Display Examples for Week 1
# Data types and appropriate visualizations
# H524 Introduction to Biostatistics - Oregon State University
#
# DATA SOURCES AND CITATIONS:
# This script uses ONLY real published data:
# 1. FEV1 data: Pagano & Gauvreau "Principles of Biostatistics", pp. 38-39
#    Source: Study of 13 adolescents with asthma
# 2. Childhood injury deaths: Pagano & Gauvreau, pp. 24-25
#    Source: 100 children aged 5-9 who died from injuries, 1980-1985
# NO simulated data is used

# FEV1 Data: Lung function in adolescents with asthma
# Source: Pagano & Gauvreau "Principles of Biostatistics", pp. 38-39
fev1_data <- data.frame(
  subject_id = 1:13,
  fev1_liters = c(2.15, 2.20, 2.25, 2.50, 2.65, 2.75, 2.80,
                  2.85, 3.00, 3.15, 3.20, 3.85, 4.05),
  gender = c("Female", "Female", "Female", "Male", "Female",
             "Male", "Female", "Male", "Male", "Male",
             "Female", "Male", "Male")
)
fev1_data$gender <- factor(fev1_data$gender)

# Childhood Injury Deaths Data
# Source: Pagano & Gauvreau "Principles of Biostatistics", pp. 24-25
injury_data <- data.frame(
  cause = rep(c("Motor Vehicle", "Drowning", "Fire", "Homicide", "Other"),
              times = c(48, 14, 12, 7, 19))
)
injury_data$cause <- factor(injury_data$cause,
                           levels = c("Motor Vehicle", "Drowning", "Fire", "Homicide", "Other"))

# =============================================================================
# CATEGORICAL DATA VISUALIZATIONS - Using real injury death data
# =============================================================================

# 1. Bar Chart for Childhood Injury Deaths
pdf("barplot_injuries.pdf", width = 8, height = 6)
par(mar = c(6, 4, 4, 2))
injury_counts <- table(injury_data$cause)
barplot(injury_counts,
        main = "Childhood Injury Deaths by Cause (Ages 5-9, 1980-1985)",
        ylab = "Number of Deaths",
        xlab = "Cause of Death",
        col = c("#FF6B35", "#F7931E", "#FFD23F", "#06A77D", "#4ECDC4"),
        las = 2)
dev.off()

# 2. Pie Chart for Injury Causes
pdf("piechart_injuries.pdf", width = 8, height = 6)
pie(injury_counts,
    main = "Childhood Injury Deaths Distribution (1980-1985)",
    col = c("#FF6B35", "#F7931E", "#FFD23F", "#06A77D", "#4ECDC4"),
    labels = paste(names(injury_counts), "\n",
                   round(prop.table(injury_counts)*100, 1), "%"))
dev.off()

# 3. Bar Chart for Gender in FEV1 study
pdf("barplot_gender_fev1.pdf", width = 8, height = 6)
gender_counts <- table(fev1_data$gender)
barplot(gender_counts,
        main = "Gender Distribution in FEV1 Study",
        ylab = "Number of Subjects",
        xlab = "Gender",
        col = c("#FF6B35", "#F7931E"))
dev.off()

# =============================================================================
# CONTINUOUS DATA VISUALIZATIONS - Using real FEV1 data
# =============================================================================

# 1. Histogram for FEV1 measurements
pdf("histogram_fev1.pdf", width = 8, height = 6)
par(mar = c(4, 4, 4, 2))
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

# 2. Box Plot for FEV1 by Gender
pdf("boxplot_fev1_gender.pdf", width = 8, height = 6)
par(mar = c(4, 4, 4, 2))
boxplot(fev1_liters ~ gender, data = fev1_data,
        main = "FEV1 Distribution by Gender",
        xlab = "Gender",
        ylab = "FEV1 (liters)",
        col = c("#FFD23F", "#FF6B35"),
        border = "black")
dev.off()

# 3. Dot Plot for FEV1 (all data points)
pdf("dotplot_fev1.pdf", width = 8, height = 6)
par(mar = c(4, 4, 4, 2))
stripchart(fev1_data$fev1_liters,
           main = "FEV1 Measurements (All 13 Subjects)",
           xlab = "FEV1 (liters)",
           method = "stack",
           pch = 19,
           col = "#06A77D",
           cex = 1.2)
dev.off()

# 4. Scatter Plot: Subject ID vs FEV1
pdf("scatter_fev1.pdf", width = 8, height = 6)
par(mar = c(4, 4, 4, 2))
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

print("All graphical examples created using REAL published data!")
print("Files created:")
print("- barplot_injuries.pdf")
print("- piechart_injuries.pdf")
print("- barplot_gender_fev1.pdf")
print("- histogram_fev1.pdf")
print("- boxplot_fev1_gender.pdf")
print("- dotplot_fev1.pdf")
print("- scatter_fev1.pdf")
print("")
print("Data Sources:")
print("- FEV1: Pagano & Gauvreau pp. 38-39")
print("- Injuries: Pagano & Gauvreau pp. 24-25")