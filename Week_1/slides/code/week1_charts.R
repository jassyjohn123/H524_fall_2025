# Week 1 Chart Examples - Professional Data Visualization in R
# H524 Biostatistics Course
#
# This script demonstrates how to create professional 3D charts in R
# including bar charts, pie charts, and dot plots for biostatistics

# ============================================================================
# DATA SETUP
# ============================================================================

# Install required package if not available
if (!require(plotrix, quietly = TRUE)) {
  install.packages("plotrix")
  library(plotrix)
}

# Load required data for examples
# Dataset 1: Childhood injury deaths by cause (1980-1985, Ages 5-9)
injury_data <- data.frame(
  cause = rep(c("Motor Vehicle", "Drowning", "Fire", "Homicide", "Other"),
              times = c(48, 14, 12, 7, 19))
)
injury_data$cause <- factor(injury_data$cause,
                           levels = c("Motor Vehicle", "Drowning", "Fire", "Homicide", "Other"))

# Dataset 2: FEV1 measurements by gender
fev1_data <- data.frame(
  subject_id = 1:13,
  fev1_liters = c(2.46, 2.65, 2.69, 2.76, 2.85, 3.15, 2.47, 2.77, 2.78,
                  2.81, 3.09, 3.18, 3.46),
  gender = c("F", "F", "F", "F", "F", "F", "M", "M", "M", "M", "M", "M", "M")
)
fev1_data$gender <- factor(fev1_data$gender, levels = c("F", "M"), labels = c("Female", "Male"))

# ============================================================================
# EXAMPLE 1: PROFESSIONAL 3D BAR CHART
# ============================================================================

# Create professional 3D bar chart with custom depth effects
injury_counts <- table(injury_data$cause)
pdf("barplot_injuries.pdf", width = 8, height = 6)

# Create enhanced 3D-style bar chart
par(mar = c(9, 4, 4, 2))  # Increase bottom margin for x-axis label

# Create gradient colors for 3D effect (lighter to darker)
bar_colors <- c("#FF6B35", "#F7931E", "#FFD23F", "#06A77D", "#4ECDC4")

# Create the bar chart with enhanced styling
bar_pos <- barplot(injury_counts,
                   main = "Childhood Injury Deaths by Cause (Ages 5-9, 1980-1985)",
                   ylab = "Number of Deaths",
                   xlab = "",  # Remove xlab here
                   col = bar_colors,
                   border = "black",
                   las = 2,
                   cex.main = 1.2,
                   cex.lab = 1.1,
                   lwd = 2,
                   space = 0.3)

# Add depth effect by drawing darker rectangles behind each bar
for(i in 1:length(injury_counts)) {
  # Calculate bar dimensions
  bar_height <- injury_counts[i]
  bar_left <- bar_pos[i] - 0.4
  bar_right <- bar_pos[i] + 0.4

  # Draw 3D depth effect (top and right side)
  depth_offset <- 0.15

  # Right side of bar (darker color)
  darker_color <- adjustcolor(bar_colors[i], red.f = 0.7, green.f = 0.7, blue.f = 0.7)
  polygon(c(bar_right, bar_right + depth_offset, bar_right + depth_offset, bar_right),
          c(0, depth_offset, bar_height + depth_offset, bar_height),
          col = darker_color, border = "black", lwd = 1)

  # Top of bar (lighter color)
  lighter_color <- adjustcolor(bar_colors[i], red.f = 1.2, green.f = 1.2, blue.f = 1.2)
  polygon(c(bar_left, bar_left + depth_offset, bar_right + depth_offset, bar_right),
          c(bar_height, bar_height + depth_offset, bar_height + depth_offset, bar_height),
          col = lighter_color, border = "black", lwd = 1)
}

# Add horizontal line at y=0 (x-axis baseline)
abline(h = 0, lwd = 2, col = "black")

# Add x-axis label below the category labels
mtext("Cause of Death", side = 1, line = 7, cex = 1.1)

dev.off()

# ============================================================================
# EXAMPLE 2: PROFESSIONAL 3D PIE CHART WITH EXTERNAL LEGEND
# ============================================================================

# Define professional color palette for pie chart
pie_colors <- c("#2E86AB", "#A23B72", "#F18F01", "#C73E1D", "#6A994E")

# Calculate percentages for display
injury_counts <- table(injury_data$cause)
injury_percentages <- round(prop.table(injury_counts) * 100, 1)

pdf("piechart_injuries.pdf", width = 12, height = 8)
# Set up layout with pie chart on left and legend on right - closer spacing
layout(matrix(c(1, 2), nrow = 1), widths = c(2.2, 0.8))

# Left panel: Pie chart
par(mar = c(4, 2, 5, 0))  # Remove right margin
pie3D(injury_counts,
      labels = "",     # No labels on the chart itself
      main = "Childhood Injury Deaths Distribution (1980-1985)",
      col = pie_colors,
      explode = 0.05,  # Minimal separation between slices
      theta = pi/6,    # 3D angle
      radius = 0.9,    # Fill the available space
      height = 0.15,   # 3D depth
      start = pi/2,    # Start angle
      cex.main = 1.4)  # Title size

# Right panel: Legend - positioned closer and centered
par(mar = c(4, 0, 5, 1))  # Remove left margin
plot.new()
legend("center",
       legend = paste(names(injury_counts), injury_percentages, "%"),
       fill = pie_colors,
       cex = 1.2,
       bty = "n",
       title = "Causes of Death",
       title.cex = 1.3,
       y.intersp = 1.1)  # Spacing between legend items

dev.off()

# ============================================================================
# EXAMPLE 3: ENHANCED DOT PLOT WITH GENDER COMPARISON
# ============================================================================

pdf("dotplot_fev1.pdf", width = 10, height = 6)
par(mar = c(5, 4, 4, 8))

# Create stripchart with gender separation
stripchart(
    fev1_liters ~ gender,
    data = fev1_data,
    main = "FEV1 Measurements by Gender",
    xlab = "FEV1 (liters)",
    ylab = "",
    method = "jitter",
    jitter = 0.15,
    pch = 19,
    col = c("#E63946", "#457B9D"),  # Red for Female, Blue for Male
    cex = 1.4,
    vertical = FALSE,
    group.names = c("Female (n=6)", "Male (n=7)"),
    cex.main = 1.2,
    cex.lab = 1.1
)

# Add vertical lines for group means
female_mean <- mean(fev1_data$fev1_liters[fev1_data$gender == "Female"])
male_mean <- mean(fev1_data$fev1_liters[fev1_data$gender == "Male"])

abline(v = female_mean, col = "#E63946", lty = 2, lwd = 2)
abline(v = male_mean, col = "#457B9D", lty = 2, lwd = 2)

# Add legend
legend("topright",
       legend = c(paste("Female mean:", round(female_mean, 2), "L"),
                  paste("Male mean:", round(male_mean, 2), "L")),
       col = c("#E63946", "#457B9D"),
       lty = 2,
       lwd = 2,
       bty = "n")

# Add grid for better readability
grid(nx = NULL, ny = NA, col = "gray90", lty = 1)

dev.off()

# ============================================================================
# SUMMARY
# ============================================================================

cat("Professional biostatistics charts generated successfully!\n")
cat("Files created:\n")
cat("  - barplot_injuries.pdf (3D bar chart with custom depth effects)\n")
cat("  - piechart_injuries.pdf (3D pie chart with external legend)\n")
cat("  - dotplot_fev1.pdf (Enhanced dot plot with gender comparison)\n")
cat("\nThese examples demonstrate professional data visualization techniques\n")
cat("suitable for biostatistics presentations and publications.\n")