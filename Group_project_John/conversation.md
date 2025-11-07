# Group Project Development Conversation
## AI-Enhanced Biostatistics Group Project - Fall 2025

**Date:** November 2-3, 2025
**Instructor:** Dr. John Molitor
**Assistant:** Claude Code

---

## Executive Summary

This document chronicles the complete development of the H524 Group Project materials, emphasizing **AI tool comparison** as a core learning objective. The project evolved through multiple iterations based on instructor feedback, ultimately creating a flexible, AI-first approach to teaching statistical analysis.

**Key Innovation:** Students don't just use AI tools—they critically compare Claude, ChatGPT, and Microsoft Copilot outputs, learning to identify strengths, weaknesses, and errors in AI-assisted statistical analysis.

---

## Conversation Timeline

### Phase 1: Initial Exploration (Pondering)

**User Request 1:** "Ponder: See examples subdirectory for 2025 course, group project"

**Analysis:**
- Examined existing `Group_project/examples/` directory
- Found only anorexia.csv with two AI-generated analysis documents
- Discovered substantial differences between Claude and ChatGPT analyses:
  - **Claude:** ANOVA on change scores, accessible narrative, no assumption checking
  - **ChatGPT:** ANCOVA adjusting for baseline, rigorous assumptions, effect sizes
  - **Key insight:** Same dataset, very different analytical approaches!

**Pedagogical Realization:** This divergence is the learning opportunity!

---

### Phase 2: AI Divergence Concept

**User Request 2:** "Ponder: I'm hoping that the med datasets would provide the necessary diversity in AI output. If things get too simple, the results will all be the same."

**Critical Insight:**
- If datasets are too simple (e.g., perfect normal distributions, obvious t-test), all AI tools give identical answers
- **Defeats the pedagogical purpose** of comparing AI tools
- Need datasets that create **ambiguity and divergence**

**Design Criteria Established:**
1. Multiple valid analytical approaches (e.g., ANOVA vs ANCOVA)
2. Assumption violations (tests whether AI checks rigor)
3. Data quality issues (tests AI data cleaning awareness)
4. Complex designs (factorial, pre-post, multiple groups)
5. Intro-appropriate complexity (not too advanced)

---

### Phase 3: Dataset Selection from MedDataSets

**User Request 3:** "Yes!" (confirmed to proceed with dataset identification)

**Process:**
- Analyzed all 48 datasets in MedDataSets R package
- Created "AI Divergence Score" (0-10) based on:
  - Design complexity
  - Method ambiguity
  - Assumption violations
  - Sample size appropriateness
  - Data quality issues

**Top 5 Datasets Selected:**

| Group | Dataset | Score | AI Divergence |
|-------|---------|-------|---------------|
| 1 | Anorexia Treatment | 9/10 | ⭐⭐⭐ High - Pre-post design ambiguity |
| 2 | ToothGrowth | 8/10 | ⭐⭐⭐ High - Factorial design complexity |
| 3 | Birth Weight | 7/10 | ⭐⭐ Med-High - Binary outcome, multiple predictors |
| 4 | Pima Diabetes | 9/10 | ⭐⭐⭐ High - **Hidden data quality issues!** |
| 5 | Diabetes Trial | 7/10 | ⭐ Medium - Clean data, "control" dataset |

**Why Pima Diabetes Scores High:**
- Contains missing values **incorrectly coded as 0**
- Blood pressure = 0 (impossible!)
- BMI = 0 (impossible!)
- Glucose = 0 (impossible!)
- **Tests whether AI tools detect data quality problems**

---

### Phase 4: CSV vs Package Debate

**User Request 4:** "Ponder: Should we give them csv files when the med data package already has all the datasets built in?"

**Initial Analysis:**
- MedDataSets package already has all datasets
- Students could use `library(MedDataSets)` and `data()`
- Maybe CSV files are redundant?

**User Insight:**
- AI chatbots (Claude, ChatGPT) require **file uploads**
- Can't just describe a dataset from a package
- **CSV files are necessary for the AI comparison workflow**

**Decision:** Provide CSV files in group folders (hybrid approach)

---

### Phase 5: Main Implementation

**User Request 5:**
```
A) Make a new subfolder called Group_project_John. Make 1) final project based on
   5 datasets you chose with work to do including comparison to three AI's (Claude,
   ChatGPT, Microsoft CoPilot). 2) Make a mid-term project where students are required
   to meet with their group and familiarize themselves with the data (e.g. read it in.)

B) For these projects, base it loosely on the previous template (Group_project)

C) Make five subfolders for the group_project_john (group_1, group_2, ...) with
   the csv file for each project.
```

**Implementation:**

1. **Created Directory Structure:**
```
Group_project_John/
├── docs/
│   ├── midterm_checkpoint.tex          # Data familiarization (5%)
│   ├── final_project_guidelines.tex    # Main project (20%)
│   └── DATA_DICTIONARIES.md            # All 5 datasets documented
├── group_1/anorexia.csv
├── group_2/toothgrowth.csv
├── group_3/birthwt.csv
├── group_4/pima_diabetes.csv
├── group_5/diabetes2.csv
└── README.md
```

2. **Extracted Datasets from MedDataSets:**
```r
library(MedDataSets)
data('anorexia_df')
write.csv(anorexia_df, 'group_1/anorexia.csv', row.names=FALSE)
# ... etc for all 5 datasets
```

3. **Created LaTeX Documents:**
- Final project guidelines (12 pages)
- Midterm checkpoint (6 pages)
- Both with OSU orange/AI blue color scheme

4. **Compiled PDFs:**
- `final_project_guidelines.pdf` (138 KB)
- `midterm_checkpoint.pdf` (initial version)

---

### Phase 6: First Revision - "Check-In" Simplification

**User Request 6:** "Rename mid-term project as check in (change everywhere - filenames titles, etc). Make this shorter - leave out R code as AI will likely do this. Just help them get started."

**Changes Made:**

1. **Renamed Files:**
   - `midterm_checkpoint.tex` → `checkin.tex`
   - `midterm_checkpoint.pdf` → `checkin.pdf`

2. **Removed All R Code Examples:**
   - Before:
   ```r
   data <- read.csv("anorexia.csv")
   summary(data)
   head(data)
   ```
   - After:
   ```
   Ask AI tools:
   • "How do I load a CSV file in R?"
   • "How do I check the structure of my dataset?"
   • "How do I create summary statistics?"
   ```

3. **Shortened Document:**
   - Original: 6 pages with detailed R instructions
   - Revised: 4 pages focused on getting started
   - Emphasis: Let AI help with coding!

4. **Updated References:**
   - Changed "midterm" → "check-in" in 6 locations across documents
   - Updated timeline in final_project_guidelines.tex

**Rationale:** Students will use AI for R help anyway—teach them to ask good questions!

---

### Phase 7: Second Revision - Remove "Week 4"

**User Request 7:** "Actually, make it all check in (leave out week 4 as this is passed)"

**Changes Made:**

1. **Title Update in checkin.tex:**
   - Before: `\title{H524 Introduction to Biostatistics\\ Week 4 Check-In\\ ...}`
   - After: `\title{H524 Introduction to Biostatistics\\ Group Project Check-In\\ ...}`

2. **References Throughout Document:**
   - "Week 4 Check-In" → "Check-In" (4 instances)
   - "Week 4 check-in" → "Check-in" (2 instances)
   - "Week 4, Friday" → "See Canvas for deadline"

3. **Timeline in Final Guidelines:**
   - Kept "Week 4" in timeline context for reference
   - But removed from assignment names themselves

**Rationale:** Course timing may vary—assignment name shouldn't lock in specific week

---

### Phase 8: Third Revision - Remove Due Dates

**User Request 8:** "Wait did you give a due date? We want this to be flexible"

**Problem Identified:**
- checkin.tex had hardcoded: `\date{Due: Week 4 (Friday by 11:59 PM)}`
- Also: `\textbf{Due Date:} Week 4, Friday by 11:59 PM`
- And: `\textbf{Start early:} Don't wait until Friday!`

**Changes Made:**

1. **LaTeX Header:**
   ```latex
   % Before:
   \date{Due: Week 4 (Friday by 11:59 PM)}

   % After:
   \date{See Canvas for Due Date}
   ```

2. **Assignment Overview:**
   ```latex
   % Before:
   \textbf{Due Date:} Week 4, Friday by 11:59 PM

   % After:
   \textbf{Due Date:} See Canvas for deadline
   ```

3. **Tips Section:**
   ```latex
   % Before:
   \item \textbf{Start early:} Don't wait until Friday!

   % After:
   \item \textbf{Start early:} Don't wait until the last minute!
   ```

4. **Recompiled PDFs:**
   - checkin.pdf (98 KB)
   - final_project_guidelines.pdf (138 KB)

**Rationale:** Maximum flexibility for course scheduling

---

## Final Deliverables

### 1. Check-In Assignment (5% of grade)

**File:** `docs/checkin.pdf`

**Purpose:** Low-stakes data familiarization

**Requirements:**
- Hold team meeting (30 min)
- Load dataset in R (all members)
- Explore data (summary stats, variable types)
- Create 2-3 basic visualizations
- Propose preliminary research questions
- Document AI tool usage

**Deliverable:** 3-4 page PDF with team photo, dataset summary, plots, AI notes

**Key Feature:** AI-first approach—students encouraged to ask AI for R help

---

### 2. Final Project (20% of grade)

**File:** `docs/final_project_guidelines.pdf`

**Grading Breakdown:**
- Descriptive Analysis: 20%
- Inferential Analysis: 25%
- **AI Tool Comparison: 30%** ← Core learning objective!
- Report & Presentation: 25%

**AI Comparison Requirements:**

Students must:
1. Upload dataset to **Claude** (claude.ai)
2. Upload dataset to **ChatGPT** (chat.openai.com)
3. Use **Microsoft Copilot** (in RStudio)
4. Ask each AI for analytical suggestions
5. Document differences in a comparison table
6. Critically evaluate which approach is best
7. Verify AI outputs for correctness
8. Write 1.5-page AI comparison section in report

**Comparison Table Format:**

| Aspect | Claude | ChatGPT | Copilot |
|--------|--------|---------|---------|
| Method Suggested | | | |
| Assumptions Checked | | | |
| Effect Sizes Reported | | | |
| Code Quality | | | |
| Interpretation Style | | | |

**Critical Evaluation Questions:**
- Did all three AI tools agree on method?
- Which was most rigorous in assumption checking?
- Did any AI make mistakes?
- How did you verify correctness?
- Which approach did you follow and why?

---

### 3. Five Datasets with Individual Documentation

Each group folder contains:
- **CSV file** for the dataset
- **README.md** with quick reference guide

**Group 1: Anorexia Treatment Study**
- N=72, pre-post design, 3 treatment groups
- Expected AI divergence: ANOVA vs ANCOVA vs paired t-tests
- Why: Multiple valid approaches for pre-post analysis

**Group 2: ToothGrowth Study**
- N=60, 2×3 factorial design (supplement × dose)
- Expected AI divergence: One-way vs two-way ANOVA, interaction effects
- Why: Factorial design complexity, interpretation challenges

**Group 3: Low Birth Weight Study**
- N=189, case-control, binary outcome
- Expected AI divergence: Chi-square vs t-tests, risk ratios
- Why: Multiple predictors, various analytical approaches

**Group 4: Pima Indian Diabetes Study**
- N=200, cross-sectional, **hidden data quality issues**
- Expected AI divergence: Will AI detect impossible 0 values?
- Why: Tests AI data cleaning and quality assessment abilities
- **Critical:** Missing data coded as 0 (BP=0, BMI=0, impossible!)

**Group 5: Diabetes Treatment Trial**
- N=699, RCT, cleanest dataset
- Expected AI divergence: Moderate (mostly agree on chi-square)
- Why: "Control" dataset—when data is clean, AI tools mostly agree
- Differences mainly in pairwise comparisons and adjustment methods

---

### 4. Comprehensive Data Dictionary

**File:** `docs/DATA_DICTIONARIES.md`

**Contents:**
- Complete variable descriptions for all 5 datasets
- Research context and background
- Suggested statistical methods
- AI divergence notes
- Data quality warnings (especially Pima diabetes!)

**Example Entry:**

```markdown
## Dataset 4: Pima Indian Diabetes Study

### ⚠️ CRITICAL DATA QUALITY ISSUE ⚠️

**Missing data coded as 0:** Several physiological variables have
0 values which are **biologically impossible**:
- Blood pressure = 0 (person would be dead!)
- BMI = 0 (impossible!)
- Glucose = 0 (impossible for living person)

**These are actually MISSING values** incorrectly coded as 0.

**This is a TEST of AI data cleaning abilities!**
Will AI tools catch this? Let's see!
```

---

## Technical Decisions Made

### 1. Dataset Source: MedDataSets R Package
- **Rationale:** Vetted medical data, teaching-appropriate complexity
- **Citation:** Caceres Rossi (2024)
- All datasets from real medical studies
- Sample sizes 60-699 (intro-appropriate)

### 2. File Format: CSV + LaTeX + Markdown
- **CSV:** Required for AI chatbot uploads (Claude, ChatGPT)
- **LaTeX:** Professional course materials (PDFs)
- **Markdown:** Quick reference guides (READMEs, data dictionaries)

### 3. AI Tools Selected
- **Claude (claude.ai):** Natural language, accessible narrative
- **ChatGPT (chat.openai.com):** Rigorous, technical, detailed
- **Microsoft Copilot:** Code-focused, inline in RStudio
- **Why these three:** Free/accessible, different strengths, popular

### 4. Grading Emphasis: 30% on AI Comparison
- **Traditional project:** 100% on statistical analysis
- **This project:** 70% analysis + **30% AI comparison**
- **Rationale:** Core learning objective is critical AI evaluation

### 5. Flexible Timing
- No hardcoded week numbers in assignment names
- "See Canvas for Due Date" instead of specific dates
- Timeline shows context but doesn't lock in schedule

---

## Pedagogical Philosophy

### Traditional Biostatistics Project:
1. Load data
2. Run tests
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

**Result:** Students learn to work **WITH** AI, not just blindly use it.

---

## Key Learning Objectives

Students will learn:

### Statistical Methods
- ANOVA and t-tests (continuous outcomes)
- Chi-square tests (categorical outcomes)
- Confidence intervals and effect sizes
- Assumption checking (normality, equal variances)
- Data cleaning and quality assessment

### AI Literacy
- **Critical evaluation** of AI outputs
- **Verification strategies** for AI-generated results
- **Strengths and weaknesses** of different AI tools
- **When AI is helpful** vs. when it makes mistakes
- **How to ask good questions** to AI tools

### Professional Skills
- Team collaboration and communication
- Research question formulation
- Data visualization and presentation
- Technical writing and reporting

---

## What Makes This Project Unique

### 1. AI Comparison as Core Objective (Not Just Tool Use)
- Most courses: "You can use AI if you want"
- This course: "You MUST compare three AI tools and evaluate them critically"
- 30% of grade explicitly on comparison quality

### 2. High-Divergence Dataset Selection
- Deliberately chose datasets that create AI disagreement
- Forces students to think critically about method choice
- Can't just "accept whatever AI says"

### 3. Hidden Data Quality Issues
- Pima diabetes dataset tests whether students/AI catch data problems
- Missing values coded as 0 (biologically impossible)
- Teaches: Always check your data!

### 4. Flexible, AI-First Approach
- No R code examples in assignment
- Students ask AI for help with syntax
- Teaches: How to get good help from AI

### 5. Real Medical Datasets
- Anorexia treatment outcomes
- Tooth growth experiments
- Birth weight risk factors
- Diabetes prediction and treatment
- Students analyze actual health research questions

---

## Expected AI Behavior Patterns

### Anorexia Dataset (Group 1):
- **Claude:** ANOVA on change scores, narrative interpretation, accessible language
- **ChatGPT:** ANCOVA with baseline adjustment, assumption checking, effect sizes
- **Copilot:** Paired t-tests by group, code-focused
- **Student learns:** Pre-post analysis has multiple valid approaches

### ToothGrowth Dataset (Group 2):
- **Claude:** One-way ANOVA with post-hoc tests
- **ChatGPT:** Two-way ANOVA with interaction, effect sizes
- **Copilot:** Multiple t-tests or linear model approach
- **Student learns:** Factorial designs can be analyzed different ways

### Birth Weight Dataset (Group 3):
- **Claude:** Chi-square tests for categorical predictors
- **ChatGPT:** Multiple comparisons with risk ratios
- **Copilot:** T-tests for continuous predictors
- **Student learns:** Binary outcomes have multiple analytical paths

### Pima Diabetes Dataset (Group 4):
- **Claude:** May miss data quality issues, proceed with analysis
- **ChatGPT:** MIGHT detect impossible 0 values (glucose=0?)
- **Copilot:** Depends on code context
- **Student learns:** AI doesn't always catch data problems! (Critical lesson!)

### Diabetes Trial Dataset (Group 5):
- **Claude:** Chi-square, general interpretation
- **ChatGPT:** Chi-square with Bonferroni correction, detailed
- **Copilot:** Similar chi-square approach
- **Student learns:** When data is clean, AI tools mostly agree (control condition)

---

## Implementation Timeline

### Completed (November 2-3, 2025):
- [x] Analyzed 48 MedDataSets for AI divergence potential
- [x] Selected top 5 datasets with high divergence scores
- [x] Created Group_project_John directory structure
- [x] Extracted CSV files for all 5 datasets
- [x] Wrote final project guidelines (12 pages, LaTeX)
- [x] Wrote check-in assignment (4 pages, LaTeX)
- [x] Created comprehensive data dictionary (Markdown)
- [x] Wrote individual README files for each group
- [x] Compiled all PDFs
- [x] Revised for "check-in" terminology
- [x] Removed R code examples (AI-first approach)
- [x] Removed "Week 4" prefix for flexibility
- [x] Removed hardcoded due dates

### Ready for Distribution:
- All materials finalized
- PDFs compiled and verified
- CSV files in group folders
- Documentation complete
- No hardcoded dates or week numbers

---

## Files Created

### Main Documents (docs/)
1. `checkin.tex` + `checkin.pdf` (98 KB) - Check-in assignment
2. `final_project_guidelines.tex` + `final_project_guidelines.pdf` (138 KB) - Main project
3. `DATA_DICTIONARIES.md` - Complete variable descriptions

### Group Folders (group_1/ through group_5/)
- `anorexia.csv` (72 rows) - Anorexia treatment study
- `toothgrowth.csv` (60 rows) - Tooth growth experiment
- `birthwt.csv` (189 rows) - Birth weight risk factors
- `pima_diabetes.csv` (200 rows) - Diabetes prediction (data quality issues!)
- `diabetes2.csv` (699 rows) - Diabetes treatment trial
- Individual `README.md` files for each dataset

### Documentation
- Main `README.md` - Complete project overview
- `conversation.md` (this file) - Development history

---

## Lessons Learned During Development

### 1. Dataset Complexity is Critical
- Too simple → All AI tools agree → No learning opportunity
- Too complex → Beyond intro level → Frustrating
- Sweet spot: Multiple valid approaches at intro level

### 2. Data Quality Issues are Teaching Moments
- Pima diabetes "0 = missing" is brilliant for testing AI
- Real-world data is messy—students need to learn this
- AI doesn't always catch problems—humans must verify

### 3. Flexibility Matters
- Hardcoded week numbers become outdated
- "See Canvas" allows scheduling flexibility
- Generic "check-in" vs "Week 4 check-in"

### 4. AI-First Approach is Liberating
- Don't teach R syntax in assignments
- Teach students to ask good questions to AI
- Focus on statistical thinking, not coding mechanics

### 5. Comparison Forces Critical Thinking
- Can't just accept first AI answer
- Must evaluate multiple sources
- Develops verification strategies
- Prepares for real-world AI use

---

## Instructor Notes

### Distributing Materials
1. Upload PDFs to Canvas:
   - `final_project_guidelines.pdf` - Main assignment
   - `checkin.pdf` - Check-in due dates (set in Canvas)

2. Share datasets via Canvas or GitHub:
   - Option A: Upload all group folders to Canvas Files
   - Option B: Share GitHub link to Group_project_John directory

3. Assign teams to groups:
   - 5 groups total
   - Each gets one dataset folder
   - Teams of 3-4 students

### Expected Workload
- **Check-in:** 2-3 hours (team meeting + data exploration)
- **Final project:** 15-20 hours total (over 3-4 weeks)
  - AI consultation: 3-4 hours
  - Analysis: 6-8 hours
  - AI comparison: 4-5 hours
  - Report writing: 3-4 hours
  - Presentation prep: 2-3 hours

### Grading Tips
- **Check-in:** Completion-based (did they meet? load data? explore?)
- **Final project:** See detailed rubric in guidelines
- **AI comparison:** This is 30%! Don't let students skimp on this section
- Look for:
  - Specific examples of AI differences (not vague)
  - Evidence of verification (how did they check?)
  - Critical evaluation (which approach is best and why?)

### Common Student Questions (Anticipated)

**Q: Do we all need to submit individually?**
A: No—one submission per team.

**Q: What if our dataset has missing data?**
A: That's fine! Document it. (Pima group: this is part of the assignment!)

**Q: Can we change research questions later?**
A: Yes! Check-in questions are preliminary.

**Q: Should we use AI tools?**
A: YES! This is the core of the assignment.

**Q: Can we consult all three AI tools now?**
A: Yes, but full comparison is for final project, not check-in.

**Q: What if AI tools disagree?**
A: PERFECT! That's the learning opportunity. Evaluate critically.

### Office Hours Support
- Week 4: Help with data loading issues
- Weeks 5-6: Help with AI comparison and method selection
- Week 7: Draft review (optional)
- Week 8: Final questions before submission

---

## Future Improvements (Potential)

### If Running Again:
1. **Add Example AI Comparison:** Include sample comparison from anorexia dataset
2. **AI Grading Rubric:** More specific criteria for the 30% AI section
3. **Peer Review Process:** Have teams review each other's AI comparisons
4. **AI Tool Tutorials:** Brief videos on using Claude/ChatGPT/Copilot
5. **Data Quality Checklist:** Help students catch Pima-style issues

### Advanced Variations:
1. **Add GPT-4 Code Interpreter:** Fourth AI tool comparison
2. **Include RStudio AI:** Compare to Copilot
3. **Prompt Engineering Exercise:** Test different prompts on same dataset
4. **AI Accuracy Leaderboard:** Track which AI makes most errors

---

## Conclusion

This Group Project represents a **paradigm shift** in teaching biostatistics:

**From:** "Here's the method, run the test, write the report"
**To:** "Here are three AI suggestions—evaluate them critically and choose the best approach"

**Key Success Factors:**
1. ✅ Datasets chosen for AI divergence (not just convenience)
2. ✅ 30% of grade on AI comparison (not afterthought)
3. ✅ Hidden data quality issues test AI awareness
4. ✅ Flexible timing and AI-first pedagogy
5. ✅ Real medical datasets with meaningful questions

**Student Outcomes:**
- Learn statistical methods (ANOVA, t-tests, chi-square)
- Learn AI literacy (verification, evaluation, synthesis)
- Learn critical thinking (multiple sources, best approach)
- Prepared for real-world statistical practice with AI

**Bottom Line:** Students will leave this course knowing how to work WITH AI effectively, not just blindly use it.

---

## Contact & Credits

**Instructor:** Dr. John Molitor
**Course:** H524 Introduction to Biostatistics
**Term:** Fall 2025
**Institution:** Oregon State University

**Development Assistant:** Claude Code (Anthropic)
**Dates:** November 2-3, 2025

**Dataset Source:** MedDataSets R Package (Caceres Rossi, 2024)

---

**Status:** ✅ All materials complete and ready for distribution

**Last Updated:** November 3, 2025
