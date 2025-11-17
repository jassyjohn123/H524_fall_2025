# Group Project Implementation Summary
## Complete Materials Package - Ready to Deploy

**Date:** November 8, 2025
**Status:** ✅ All materials complete and tested

---

## 📋 What Was Created

### 1. **Group Project Overview PDF** (2 pages) ✅

**File:** `docs/group_project_overview.pdf`

**Purpose:** Main reference document posted on Canvas

**Contents:**
- Project overview (AI comparison focus)
- Group assignments (4 groups, datasets assigned)
- Complete timeline (Weeks 7-10 + Finals Week)
- Grading breakdown (Report 15% + Presentation 10% = 25%)
- Deliverable requirements
- Resources & tips

**Page count:** Exactly 2 pages ✓

**Distribution:** Post to Canvas Sunday, students reference throughout Weeks 7-10

---

### 2. **Week 7 Assignment** ✅

**File:** `docs/week7_assignment.md`

**Structure:**
- **Part A:** 5 MC questions (5 pts) - Easy questions on nonparametric methods
- **Part B:** Team Plan check-in (5 pts) - Group leader submits

**Team Plan Requirements:**
1. Team roster with contact info
2. Communication plan
3. Meeting schedule
4. Division of responsibilities
5. Preliminary timeline

**Grading:** Completion-based (5 pts for reasonable plan)

**Due:** Sunday Week 7, 11:59pm

---

### 3. **Week 8 Assignment** ✅

**File:** `docs/week8_assignment.md`

**Structure:**
- **Part A:** 9 MC questions (9 pts) - Easy questions on contingency tables
- **Part B:** Progress Update (1 pt) - Group leader submits

**Progress Update:**
- 3 yes/no questions (met? loaded data? consulted AI?)
- Optional text box for blockers

**Special Feature:** Office Hours Day reminder (Wed 12-1:20pm)

**Grading:** 1 pt for completion

**Due:** Sunday Week 8, 11:59pm

---

### 4. **Week 9 Assignment** ✅

**File:** `docs/week9_assignment.md`

**Structure:**
- **Part A:** 7 MC questions (7 pts) - Easy questions on correlation/regression
- **Part B:** Presentation Readiness (3 pts) - Group leader submits

**Presentation Readiness Options:**
- Option A: Presentation outline
- Option B: Draft slides
- Option C: Presentation plan

**Grading:** 3 pts for demonstrating preparation

**Due:** Sunday Week 9, 11:59pm

---

## 📊 Final Dataset Lineup (Optimized for Divergence)

| Group | Dataset | N | Divergence | Students | Key Feature |
|-------|---------|---|------------|----------|-------------|
| **1** | Anorexia Treatment | 72 | **8/10** ⭐⭐⭐ | 1,4,10,12,13 | Pre-post design |
| **2** | ToothGrowth | 60 | **8/10** ⭐⭐⭐ | 7,11,14,15,16 | Factorial 2×3 |
| **3** | **Bacteria** | 220 | **9/10** ⭐⭐⭐ | 3,5,8,18 | **Repeated measures!** |
| **4** | Pima Diabetes | 200 | **7/10** ⭐⭐ | 2,6,9,17 | Binary outcome |

**Average Divergence:** 8.0/10
**Very High Divergence (8+):** 75% of groups

---

## 🎯 Grading Structure (Final)

### Course Grading Breakdown

| Component | Weight | Details |
|-----------|--------|---------|
| **Weekly Assignments** | **60%** | Includes Week 7,8,9 check-ins |
| **Group Project** | **25%** | Report (15%) + Presentation (10%) |
| **Class Participation** | **15%** | |
| **TOTAL** | **100%** | |

### Weekly Assignments (Weeks 7,8,9)

- **Week 7:** MC (5 pts) + Team Plan (5 pts) = 10 pts total
- **Week 8:** MC (9 pts) + Progress Update (1 pt) = 10 pts total
- **Week 9:** MC (7 pts) + Presentation Readiness (3 pts) = 10 pts total

**Check-ins count toward 60% weekly assignment grade, NOT the 25% project grade.**

### Group Project (25%)

**Final Report (15% of course grade):**
- 5-8 pages + R code appendix
- Due: Finals Week Wednesday 11:59pm
- Sections: Intro, Methods, Results, **AI Comparison** (1.5-2 pages), Discussion, Appendix

**Presentation (10% of course grade):**
- 15 minutes + 5 min Q&A
- Monday Week 10: Groups 1 & 2
- Wednesday Week 10: Groups 3 & 4
- All members must participate

---

## 📅 Complete Timeline

| Week | Monday | Wednesday | Assignment Due Sunday |
|------|--------|-----------|----------------------|
| **Week 7** | Regular lecture | Regular lecture | **MC (5) + Team Plan (5)** |
| **Week 8** | Regular lecture | Regular lecture | **MC (9) + Progress (1)** |
| **Week 9** | Regular lecture | **OFFICE HOURS DAY** | **MC (7) + Presentation (3)** |
| **Week 10** | **Presentations: Groups 1,2** | **Presentations: Groups 3,4** | - |
| **Finals Week** | - | **Final Report Due 11:59pm** | - |

---

## 📁 File Structure

```
Group_project_John/
├── docs/
│   ├── group_project_overview.tex     # 2-page LaTeX source
│   ├── group_project_overview.pdf     # ← POST TO CANVAS
│   ├── week7_assignment.md            # Week 7 Canvas assignment text
│   ├── week8_assignment.md            # Week 8 Canvas assignment text
│   └── week9_assignment.md            # Week 9 Canvas assignment text
│
├── group_1/
│   ├── anorexia.csv
│   ├── divergence_test_anorexia.R (instructor reference)
│   └── group_1_roster.csv
│
├── group_2/
│   ├── toothgrowth.csv
│   ├── divergence_test_toothgrowth.R (instructor reference)
│   └── group_2_roster.csv
│
├── group_3/
│   ├── bacteria.csv ⭐ NEW - 9/10 divergence!
│   ├── divergence_test_bacteria.R (instructor reference)
│   └── group_3_roster.csv
│
├── group_4/
│   ├── pima_diabetes.csv
│   ├── divergence_test_pima.R (instructor reference)
│   └── group_4_roster.csv
│
├── group_assignments.csv              # Student → group mapping
├── random_group_assignment.R          # Script used for randomization
├── DIVERGENCE_SUMMARY.md              # Complete divergence analysis
└── IMPLEMENTATION_SUMMARY.md          # This file
```

---

## 🚀 Deployment Instructions

### Sunday (This Week) - Project Launch

1. **Upload to Canvas Files:**
   - `group_project_overview.pdf` → Post prominently
   - Create folder: `Group_Project_Data/`
     - Upload `group_1/anorexia.csv`
     - Upload `group_2/toothgrowth.csv`
     - Upload `group_3/bacteria.csv`
     - Upload `group_4/pima_diabetes.csv`
   - Upload data dictionary (if separate file)

2. **Create Canvas Announcement:**
   ```
   📊 GROUP PROJECT BEGINS - READ NOW!

   The H524 Group Project starts this week! You'll analyze medical data
   while comparing how Claude, ChatGPT, and Microsoft Copilot approach
   the same statistical questions.

   📄 READ FIRST: Group_Project_Overview.pdf [link]

   Your Groups (randomly assigned):
   - Group 1: Students 1, 4, 10, 12, 13 - Anorexia Treatment
   - Group 2: Students 7, 11, 14, 15, 16 - ToothGrowth
   - Group 3: Students 3, 5, 8, 18 - Bacteria Treatment
   - Group 4: Students 2, 6, 9, 17 - Pima Diabetes

   Week 7 Assignment (due Sunday) includes your first check-in:
   Group leader submits a team plan.

   Questions? Post to Canvas Discussions.
   ```

3. **Assign Students to Canvas Groups:**
   - Use Canvas Groups feature
   - Create 4 groups
   - Assign students per `group_assignments.csv`
   - Designate one student in each group as "leader" (alphabetically first?)

### Week 7 - Create Canvas Assignment

**Title:** Week 7 Assignment

**Instructions:** Copy text from `week7_assignment.md`

**Points:** 10 (5 MC + 5 Check-in)

**Submission Type:**
- Part A: Quiz (MC questions)
- Part B: Text entry OR file upload

**Due:** Sunday 11:59pm

### Week 8 - Create Canvas Assignment

**Title:** Week 8 Assignment

**Instructions:** Copy text from `week8_assignment.md`

**Points:** 10 (9 MC + 1 Check-in)

**Submission Type:**
- Part A: Quiz (MC questions)
- Part B: Text entry (brief)

**Due:** Sunday 11:59pm

**Also:** Create Canvas announcement for Office Hours Day (Wed 12-1:20pm)

### Week 9 - Create Canvas Assignment

**Title:** Week 9 Assignment

**Instructions:** Copy text from `week9_assignment.md`

**Points:** 10 (7 MC + 3 Check-in)

**Submission Type:**
- Part A: Quiz (MC questions)
- Part B: File upload OR text entry

**Due:** Sunday 11:59pm

### Week 10 - Presentations

**Monday:** Groups 1 & 2 present (during class 12-1:20pm)

**Wednesday:** Groups 3 & 4 present (during class 12-1:20pm)

**Grading:** Use presentation rubric (create separate or embedded in gradebook)

### Finals Week

**Final Report Due:** Wednesday 11:59pm

**Submission:** Canvas assignment (file upload, PDF)

**Grading:** Use report rubric (separate document recommended)

---

## ✅ Quality Assurance Completed

**Datasets:**
- ✅ All 4 datasets exported to CSV
- ✅ Divergence testing completed (actual R results documented)
- ✅ Multiple valid approaches verified for each
- ✅ Average divergence 8.0/10 (target: 8+/10)

**Materials:**
- ✅ Project overview is exactly 2 pages
- ✅ Week 7,8,9 assignments include ONLY MC + check-ins
- ✅ Grading structure sums to 100%
- ✅ Timeline is complete and realistic
- ✅ Check-ins are part of weekly assignments (60%), not project (25%)

**Student Experience:**
- ✅ Clear instructions at each stage
- ✅ Scaffolded support (3 check-ins)
- ✅ Office Hours Day Week 8
- ✅ Emphasis on AI comparison (not just analysis)

---

## 📊 Expected Student Workload

**Week 7:**
- Weekly assignment: 30 min (easy MC + team formation)
- Initial project work: 1-2 hours (meet, download data, plan)
- **Total: 1.5-2.5 hours**

**Week 8:**
- Weekly assignment: 20 min (easy MC + quick check-in)
- Project work: 4-6 hours (data analysis, AI consultation)
- **Total: 4.5-6.5 hours**

**Week 9:**
- Weekly assignment: 30 min (easy MC + outline submission)
- Project work: 4-6 hours (AI comparison, presentation prep)
- **Total: 4.5-6.5 hours**

**Week 10:**
- Presentation: 1-2 hours (final prep + delivery)
- **Total: 1-2 hours**

**Finals Week:**
- Final report: 3-5 hours (writing, formatting, polishing)
- **Total: 3-5 hours**

**Grand Total: 14-22 hours** (appropriate for 25% of course grade over 5 weeks)

---

## 🎓 Key Pedagogical Features

1. **AI Comparison is Central** (not peripheral)
   - 30-40% of presentation time
   - 1.5-2 pages of report (out of 5-8)
   - Explicit grading weight

2. **Scaffolded Support**
   - Week 7: Team formation
   - Week 8: Progress check
   - Week 9: Presentation readiness + Office Hours Day
   - Not high-stakes until Week 10

3. **Realistic Timeline**
   - 5 weeks start to finish
   - Check-ins keep groups accountable
   - Finals Week for final report (after presentations)

4. **High Divergence Datasets**
   - 75% of groups have Very High divergence (8+/10)
   - Bacteria dataset (9/10) tests critical independence assumption
   - All datasets validated with actual R testing

5. **Flexible Grading**
   - Check-ins completion-based (low stakes)
   - Report and presentation are main deliverables (25% course grade)
   - Clear rubric potential for objective grading

---

## 📝 Instructor Notes

**Grading Load:**
- Week 7: 4 team plans to review (~20 min total)
- Week 8: 4 brief updates to scan (~5 min total)
- Week 9: 4 outlines to review (~15 min total)
- Week 10: 4 presentations to attend/grade (~90 min total)
- Finals Week: 4 reports to grade (~4-6 hours total)

**Total instructor time:** ~6-7 hours over 5 weeks

**Office Hours Day (Week 8 Wed):**
- Be available 12:00-1:20pm
- Classroom first, then office
- Expect 1-3 groups to attend (not all)

**Common Questions to Prepare For:**
- "Which AI tool is best?" → There's no single answer, that's the point!
- "My AI suggested method X, is that right?" → Check assumptions, verify with R
- "What if all three AI tools disagree?" → Perfect! Document differences, evaluate critically

---

## 🎯 Project Success Metrics

**For Students:**
- Complete all 3 check-ins (demonstrated progress)
- Submit final report on time
- Deliver presentation with all members participating
- Document meaningful AI comparison

**For Instructor:**
- 100% of groups submit final deliverables
- Presentations show evidence of AI comparison (not just analysis)
- Reports demonstrate critical evaluation (not blind acceptance of AI)
- Students learn AI verification strategies

---

## ✅ STATUS: READY FOR DEPLOYMENT

All materials complete and validated. Ready to post Sunday!

