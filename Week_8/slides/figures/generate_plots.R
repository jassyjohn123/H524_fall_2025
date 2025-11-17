#!/usr/bin/env Rscript
# Generate visualization plots for Week 8 slides

# Create data
data <- matrix(c(85, 55, 15, 45), nrow=2)
rownames(data) <- c("Smoker", "Non-smoker")
colnames(data) <- c("Cancer", "No Cancer")

# Set output directory
setwd("/Users/molitorj/ms/OSU/classes/AI_H524/H524_fall_2025/Week_8/slides/figures")

# 1. Mosaic plot
pdf("mosaic_plot.pdf", width=6, height=5)
mosaicplot(data,
           main="Smoking and Lung Cancer",
           color=c("darkred", "lightblue"),
           xlab="Smoking Status",
           ylab="Cancer Status",
           cex.axis=1.2)
dev.off()

# 2. Grouped barplot (counts)
pdf("barplot_counts.pdf", width=6, height=5)
barplot(data, beside=TRUE, legend=TRUE,
        col=c("darkred", "darkgreen"),
        main="Smoking and Lung Cancer",
        xlab="Cancer Status", ylab="Count",
        args.legend=list(title="Smoking Status", x="topright"),
        cex.axis=1.2, cex.names=1.2)
dev.off()

# 3. Proportions plot
pdf("barplot_proportions.pdf", width=6, height=5)
prop_data <- prop.table(data, margin=1)  # Row proportions
barplot(prop_data, beside=TRUE, legend=TRUE,
        col=c("darkred", "darkgreen"),
        main="Cancer Rates by Smoking Status",
        ylab="Proportion",
        args.legend=list(title="Smoking Status", x="topright"),
        cex.axis=1.2, cex.names=1.2,
        ylim=c(0, 1))
dev.off()

cat("All plots generated successfully!\n")
