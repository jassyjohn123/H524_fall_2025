# H524 Group Project - AI Comparison Analysis
## Fall 2025 - Dr. John Molitor

---

## 📋 Project Overview

This directory contains all materials for the H524 Introduction to Biostatistics Group Project. The project emphasizes **comparing AI tool outputs** (Claude, ChatGPT, Microsoft Copilot) while conducting statistical analysis on real medical datasets.

**Key Innovation:** Students don't just analyze data - they critically evaluate how different AI tools approach the same dataset, learning to identify strengths, weaknesses, and errors in AI-assisted statistical analysis.

---

## 📁 Directory Structure

```
Group_project_John/
│
├── docs/                                    # Project documentation
│   ├── final_project_guidelines.pdf        ✓ Complete project description
│   ├── checkin.pdf                         ✓ Week 4 data familiarization
│   ├── DATA_DICTIONARIES.md                ✓ All 5 datasets documented
│   └── [LaTeX source files]
│
├── group_1/                                 # Anorexia Treatment Study
│   ├── anorexia.csv                        ✓ Dataset (N=72)
│   └── README.md                           ✓ Quick reference guide
│
├── group_2/                                 # Tooth Growth Study
│   ├── toothgrowth.csv                     ✓ Dataset (N=60)
│   └── README.md                           ✓ Quick reference guide
│
├── group_3/                                 # Low Birth Weight Study
│   ├── birthwt.csv                         ✓ Dataset (N=189)
│   └── README.md                           ✓ Quick reference guide
│
├── group_4/                                 # Pima Diabetes Study
│   ├── pima_diabetes.csv                   ✓ Dataset (N=200)
│   └── README.md                           ✓ Quick reference guide
│
├── group_5/                                 # Diabetes Treatment Trial
│   ├── diabetes2.csv                       ✓ Dataset (N=699)
│   └── README.md                           ✓ Quick reference guide
│
└── README.md                                ← You are here!
```

---

## 🎯 Project Timeline

| Week | Milestone | Deliverable |
|------|-----------|-------------|
| **Week 3** | Team formation & dataset assignment | Teams formed |
| **Week 4** | **Check-in** (5% of grade) | Data familiarization report |
| **Week 5-6** | AI tool comparison & analysis | Working on project |
| **Week 7** | Optional draft for peer review | Draft (optional) |
| **Week 8** | **Final submission** (20% of grade) | Complete report & code |
| **Week 9** | **Group presentations** | 15 min + 5 min Q&A |

---

## 📊 The Five Datasets

### Quick Comparison Matrix

| Group | Dataset | N | Design | Outcome | AI Divergence | Difficulty |
|-------|---------|---|--------|---------|---------------|------------|
| **1** | Anorexia | 72 | Pre-post, 3 groups | Continuous | ⭐⭐⭐ High | Medium |
| **2** | ToothGrowth | 60 | 2×3 factorial | Continuous | ⭐⭐⭐ High | Medium-High |
| **3** | Birth Weight | 189 | Case-control | Binary | ⭐⭐ Medium-High | Medium |
| **4** | Pima Diabetes | 200 | Cross-sectional | Binary | ⭐⭐⭐ High | Medium (data cleaning!) |
| **5** | Diabetes Trial | 699 | RCT, 3 groups | Binary | ⭐ Medium | Low (cleanest) |

### What "AI Divergence" Means

- **High (⭐⭐⭐):** AI tools will suggest different statistical methods, requiring critical evaluation
- **Medium (⭐⭐):** Some differences in approach, but mostly agree
- **Low (⭐):** AI tools mostly agree (good for learning basics)

**Higher divergence = more learning about AI comparison!**

---

## 🤖 The AI Comparison Component (30% of grade!)

### Three AI Tools to Compare

1. **Claude** (claude.ai)
   - Upload CSV file
   - Ask for statistical analysis suggestions

2. **ChatGPT** (chat.openai.com)
   - Upload CSV file
   - Ask for statistical analysis suggestions

3. **Microsoft Copilot** (in RStudio)
   - Use for R code generation
   - Works inline as you type

### What to Compare

Students must document:
- ✓ Statistical methods suggested by each AI
- ✓ Assumption checks performed (or not!)
- ✓ Effect sizes reported (or not!)
- ✓ Code quality and clarity
- ✓ Interpretation style
- ✓ **Errors or omissions**
- ✓ Which approach is best for intro biostatistics

### Example Expected Differences

**For Anorexia Dataset:**
- **Claude:** ANOVA on change scores, no assumption checks, accessible language
- **ChatGPT:** ANCOVA adjusting for baseline, full assumptions, effect sizes
- **Copilot:** Paired t-tests, code-focused

**Students learn:** How to critically evaluate AI outputs, not just accept them!

---

## 📚 Key Documents

### For Students

1. **Start here:** `docs/final_project_guidelines.pdf`
   - Complete project description
   - Grading rubric
   - Timeline and deliverables

2. **Check-in:** `docs/checkin.pdf`
   - Data familiarization assignment
   - Team meeting requirements
   - Getting started guide (use AI for R help!)

3. **Dataset information:** `docs/DATA_DICTIONARIES.md`
   - Complete variable descriptions
   - Research context
   - Suggested methods

4. **Your group folder:** `group_X/README.md`
   - Quick reference for your dataset
   - Loading instructions
   - Expected AI differences

### For Instructor

All materials are ready to distribute:
- PDFs can be uploaded to Canvas
- CSV files in group folders ready to share
- READMEs provide quick reference for students
- LaTeX source available for future edits

---

## 🎓 What Makes This Project Different?

### Traditional Biostatistics Project:
1. Load data
2. Run statistical tests
3. Write report
4. Done

### This AI-Enhanced Project:
1. Load data
2. **Consult three different AI tools**
3. **Compare AI suggestions critically**
4. **Verify AI outputs** (check assumptions, calculations)
5. **Synthesize best approach** from multiple sources
6. Document AI comparison process
7. Write report explaining what you learned about AI

**Result:** Students learn to work WITH AI, not just blindly use it.

---

## 💡 Pedagogical Features

### Why These 5 Datasets?

Each dataset was chosen to elicit **different AI responses**:

1. **Anorexia** - Pre-post design creates method ambiguity
2. **ToothGrowth** - Factorial design, some AI suggest advanced methods
3. **Birth Weight** - Binary outcome, multiple predictors, method choices
4. **Pima Diabetes** - **Hidden data quality issues!** Tests AI data cleaning
5. **Diabetes Trial** - Cleanest dataset, "control" for comparison

### Learning Objectives

Students learn:
- ✓ Statistical methods (ANOVA, t-tests, chi-square)
- ✓ Assumption checking (normality, equal variances)
- ✓ Data cleaning and quality assessment
- ✓ **Critical AI evaluation**
- ✓ **AI verification strategies**
- ✓ **When AI is helpful vs. when it makes mistakes**

---

## 📖 Dataset Sources

All datasets from **MedDataSets R package** (Caceres Rossi, 2024):
- Anorexia: Hand et al. (1994)
- ToothGrowth: Crampton (1947)
- Birth Weight: Hosmer & Lemeshow (1989)
- Pima Diabetes: NIDDK study
- Diabetes Trial: Clinical trial data

**Advantage:** Real medical data, vetted for teaching, intro-appropriate complexity

---

## 🚀 Getting Started (For Students)

### Step 1: Read the Guidelines
Open `docs/final_project_guidelines.pdf`

### Step 2: Find Your Group Folder
Go to `group_X/` where X is your team number (1-5)

### Step 3: Read Your Dataset README
Open `group_X/README.md` for quick overview

### Step 4: Check-In
Follow `docs/checkin.pdf` instructions

### Step 5: Consult AI Tools
Upload your CSV to Claude, ChatGPT, and use Copilot in RStudio

### Step 6: Compare and Analyze
Document what each AI suggested and evaluate critically

---

## ⚙️ Technical Notes

### Data Loading Options

**Option 1: CSV files (provided in group folders)**
```r
data <- read.csv("your_dataset.csv")
```

**Option 2: MedDataSets package (optional)**
```r
library(MedDataSets)
data("dataset_name_df")
```

Both work! CSV files ensure everyone can start immediately.

### Required R Packages
```r
library(tidyverse)    # Data manipulation
library(ggplot2)      # Visualization
library(stats)        # Statistical tests
```

---

## 📧 Getting Help

- **Office Hours:** Wednesday 10:00-11:30 AM
- **Canvas Discussion Board:** Post questions about datasets or methods
- **Email:** For team scheduling or private concerns
- **Special Office Hours:** Weeks 5, 6, 7 (watch for announcements)

---

## ✅ Completion Checklist

All materials ready:
- [x] 5 datasets extracted and placed in group folders
- [x] Final project guidelines (PDF)
- [x] Check-in guidelines (PDF)
- [x] Comprehensive data dictionaries
- [x] Individual README files for each group
- [x] LaTeX source files for future edits
- [x] Main overview README (this file)

**Status:** ✅ Ready to distribute to students!

---

## 📝 Version History

- **November 2, 2025:** Initial creation
  - Complete project structure built
  - All 5 datasets extracted from MedDataSets
  - Documentation created (guidelines, dictionaries, READMEs)
  - LaTeX compiled to PDF
  - Tested with R to verify datasets load correctly

---

## 🎯 Summary

This project teaches students to:
1. Conduct proper statistical analysis
2. **Use AI tools effectively**
3. **Critically evaluate AI outputs**
4. **Verify and synthesize information**
5. Work in teams
6. Communicate findings professionally

**Bottom line:** Preparing students for the reality of modern statistical practice where AI is a powerful assistant, but human oversight is essential.

---

**Created by:** Claude Code
**Date:** November 2, 2025
**For:** H524 Introduction to Biostatistics, Fall 2025
**Instructor:** Dr. John Molitor
