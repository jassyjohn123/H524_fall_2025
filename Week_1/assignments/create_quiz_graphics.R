# Create Graphics for QTI Quiz
# Simple, clear charts for Canvas compatibility

# Create FEV1 histogram data
fev1_data <- c(2.46, 2.65, 2.69, 2.76, 2.85, 3.15, 2.47, 2.77, 2.78, 2.81, 3.09, 3.18, 3.46)

# Create injury data
injury_data <- data.frame(
  cause = c("Motor Vehicle", "Drowning", "Fire", "Other"),
  deaths = c(48, 20, 12, 20),
  percentage = c(48, 20, 12, 20)
)

# Create FEV1 histogram as PNG
png("fev1_histogram.png", width = 600, height = 400, res = 150)
par(mar = c(5, 4, 4, 2))
hist(fev1_data,
     breaks = 5,
     main = "FEV1 Distribution (n=13)",
     xlab = "FEV1 (liters)",
     ylab = "Frequency",
     col = "#69b7ff",
     border = "black",
     cex.main = 1.2,
     cex.lab = 1.1)
dev.off()

# Create injury bar chart as PNG
png("injury_barchart.png", width = 600, height = 400, res = 150)
par(mar = c(7, 4, 4, 2))
barplot(injury_data$percentage,
        names.arg = injury_data$cause,
        main = "Childhood Injury Deaths by Cause",
        ylab = "Percentage (%)",
        xlab = "",
        col = c("#ff6b6b", "#4ecdc4", "#ffcd56", "#ff9f40"),
        border = "black",
        las = 2,
        cex.main = 1.2,
        cex.lab = 1.1)
mtext("Cause of Death", side = 1, line = 5.5, cex = 1.1)
dev.off()

cat("Quiz graphics created successfully!\n")
cat("Files: fev1_histogram.png, injury_barchart.png\n")