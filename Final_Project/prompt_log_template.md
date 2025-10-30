# AI Prompt Log Template

**Team Name:** [Your Team Name]

**Project:** [Brief project title]

**Instructions:** Document all significant AI interactions throughout your project. This log demonstrates transparency and helps you reflect on the AI's usefulness.

---

## Log Entry Template

Copy this template for each major AI interaction:

### Entry [Number]

**Date:** [MM/DD/YYYY]

**AI Tool:** [ChatGPT / Claude / Gemini / Copilot / Other]

**Task/Goal:** [What were you trying to accomplish?]

**Prompt Used:**
```
[Paste the exact prompt you used]
```

**AI Response Summary:**
[Briefly summarize what the AI provided - you can paste key portions or screenshots]

**What You Trusted:**
[What parts of the AI's response did you use directly?]

**What You Changed/Corrected:**
[What did you modify and why?]

**Verification Method:**
[How did you verify the AI's output? Cross-checked with textbook? Tested code? Compared with other AI?]

**Usefulness Rating:** [1-5 stars] ⭐⭐⭐⭐⭐

**Notes:**
[Any other observations about this interaction]

---

## Example Entry

### Entry 1

**Date:** 10/15/2025

**AI Tool:** ChatGPT

**Task/Goal:** Understand assumptions for Pearson correlation

**Prompt Used:**
```
I'm analyzing the relationship between screen time (hours/day) and sleep quality (1-10 scale) 
using Pearson correlation. What assumptions do I need to check before running this analysis? 
Please explain each assumption and how to test it in R.
```

**AI Response Summary:**
ChatGPT listed four assumptions: (1) continuous variables, (2) linear relationship, (3) no outliers, (4) bivariate normality. It provided R code for checking linearity with scatterplots and testing normality with Shapiro-Wilk test.

**What You Trusted:**
The list of assumptions was accurate and matched our textbook. The scatterplot code worked perfectly.

**What You Changed/Corrected:**
The AI suggested Shapiro-Wilk for normality, but our textbook also mentioned Q-Q plots as more visual, so we added that. Also, the AI initially said "homoscedasticity" which isn't required for correlation (that's for regression), so we clarified this with Claude.

**Verification Method:**
Cross-checked assumptions against textbook Chapter 9 and course lecture slides. Ran the suggested R code on our data to confirm it worked.

**Usefulness Rating:** ⭐⭐⭐⭐ (4/5)

**Notes:**
ChatGPT was very helpful but sometimes mixes up regression and correlation assumptions. Good to verify with multiple sources.

---

## Tips for Effective Prompt Logging

1. **Log as you go** - Don't wait until the end to reconstruct your prompts
2. **Be specific in prompts** - Better prompts get better responses
3. **Compare AI tools** - Try the same prompt with different AIs to compare responses
4. **Document failures too** - Show what didn't work, not just successes
5. **Note your learning** - What did you learn from each interaction?
6. **Save screenshots** - For complex outputs (graphs, tables), screenshots are helpful
7. **Track time** - Note if an AI saved time or caused confusion

---

## Section-by-Section Log Organization

You may want to organize your log by project phase:

### Phase 1: Understanding the Method
[Log entries about learning the statistical concept]

### Phase 2: Data Preparation
[Log entries about data cleaning, exploration, assumption checking]

### Phase 3: Analysis Execution
[Log entries about running the analysis, interpreting output]

### Phase 4: Visualization and Presentation
[Log entries about creating figures and preparing presentation]

---

## Summary Comparison Table

At the end of your log, include a summary comparing the AI tools:

| Aspect | ChatGPT | Claude | Gemini | Copilot |
|--------|---------|--------|---------|---------|
| **Used for what?** | | | | |
| **Strengths** | | | | |
| **Weaknesses** | | | | |
| **Best at** | | | | |
| **Worst at** | | | | |
| **Overall rating** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |

---

## Reflection Questions

After completing your project, reflect on:

1. **Which AI was most helpful overall and why?**

2. **What task was AI best at helping with?**

3. **What task was AI worst at or caused confusion?**

4. **How did you develop better prompts over time?**

5. **What would you do differently next time?**

6. **What's one specific recommendation for using AI in statistics?**

---

## Submission Checklist

- [ ] All major prompts documented with dates
- [ ] At least 2 different AI tools compared
- [ ] Verification methods described
- [ ] Both successes and failures included
- [ ] Summary comparison table completed
- [ ] Reflection questions answered
- [ ] Screenshots attached (if applicable)

**Total Log Entries:** [Number]

**Primary AI Tools Used:** [List]

**Submission Date:** [Date]

