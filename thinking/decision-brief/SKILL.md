---
name: decision-brief
display_name: Decision Brief
icon: "⚖️"
description: >
  Produces a one-page decision memo: options, tradeoffs, recommendation, and
  the reasoning behind it. Pairs with cynical-geoff (which stress-tests an idea)
  as the constructive counterpart that moves you toward a decision. Use when you
  need to make a call, document a choice, or align stakeholders around a path forward.
trigger: decision brief
inputs:
  - name: decision
    description: "The decision to be made. State it as a specific question: 'Should we X or Y?' or 'How should we approach Z?'"
    type: string
    required: true
  - name: context
    description: "Background information, constraints, stakeholder concerns, or prior analysis"
    type: string
    required: false
  - name: options
    description: "The options under consideration. If not provided, the skill will generate them."
    type: string
    required: false
  - name: deadline
    description: "When this decision needs to be made"
    type: string
    required: false
tools: []
---

# Decision Brief

## Overview

This skill produces a one-page decision memo. It's the constructive counterpart to [cynical-geoff](../cynical-geoff/SKILL.md) — where that skill stress-tests and disconfirms, this one moves you forward. The output is a brief you can act on, share with stakeholders, or file as a record of why you decided what you decided.

The memo is one page by design. If a decision needs more than one page to explain, it hasn't been understood clearly enough yet.

## Relationship to Cynical Geoff

Use them in sequence for high-stakes decisions:

1. **cynical-geoff** first — surface the assumptions, run the pre-mortem, identify the fatal weaknesses
2. **decision-brief** second — incorporate the stress-test findings, choose the path, document the reasoning

Using decision-brief without the stress-test produces confident-sounding memos that haven't been challenged. Using cynical-geoff without the decision brief produces excellent analysis that never lands anywhere.

## Workflow

### Step 1: Frame the Decision

Restate `{{decision}}` as a crisp binary or multiple-choice question. A well-framed decision question has:
- A clear set of options (even if "do nothing" is one of them)
- A defined timeframe
- Identifiable stakeholders who need to agree or be informed

If the decision is vague or conflates multiple decisions, surface that immediately. Trying to decide two things at once produces memos that decide neither.

### Step 2: Enumerate the Options

If `{{options}}` was provided, work with those. If not, generate 2-4 realistic options including at minimum:
- The most obvious path
- The status quo / do nothing
- At least one non-obvious option that the decision-maker may not have considered

For each option, define:
- What it actually entails
- What it requires (resources, decisions, dependencies)
- What success looks like at 6 and 18 months

### Step 3: Map the Tradeoffs

For each option, assess:
- **Upside**: What does this get you if it works?
- **Downside**: What does this cost you if it fails or underperforms?
- **Key risk**: The one assumption this option depends on most
- **Reversibility**: How hard is it to change course after committing?

Prioritize reversibility as a tiebreaker when options are otherwise similar. Irreversible decisions deserve higher bars.

### Step 4: Make a Recommendation

Pick one option. State it directly. No hedging. The recommendation earns its place by being specific: not "option B seems promising" but "recommend option B because X, conditional on Y being confirmed by [date]."

If the analysis is genuinely unclear and a recommendation isn't supportable yet, say so explicitly and name what additional information would resolve the uncertainty. A memo that can't recommend anything is a memo that arrived too early.

### Step 5: Write the Brief

One page. Prose paragraphs. No more than 500 words in the body.

## Output Format

```
**Decision Brief: {{decision}}**
Date: [today]  |  Decision needed by: {{deadline}}

---

**The Decision**
One sentence restating the question in crisp, answerable form.

**Options Considered**
2-4 options with a one-paragraph summary of each, including what it requires 
and what it costs.

**Tradeoff Summary**
A short paragraph comparing the options across the dimensions that matter most 
for this specific decision. Do not list every tradeoff — surface the ones 
that actually differentiate the choices.

**Recommendation**
[Option Name]. Direct statement. No throat-clearing. Then the reasoning in 
2-3 sentences: why this option over the alternatives, what it depends on, 
and what the fallback is if the key assumption doesn't hold.

**Next Steps**
3 concrete actions that follow from the recommendation, each with an owner 
and a date.
```

## Lessons Learned

### Do

- **Make the recommendation unconditional when possible.** A conditional recommendation ("go with B, unless X, in which case A") is often a disguised refusal to decide. Commit to one option. Address the contingency in next steps.
- **Name the key assumption explicitly.** Every recommendation has one thing that has to be true for it to work. Name it. If that assumption turns out to be wrong, the decision should be revisited.
- **Distinguish reversible from irreversible.** Most decisions are more reversible than they feel. When options are close, the reversible one earns the default position.
- **Keep next steps to three.** Five next steps means none of them will happen. Three means two will.

### Don't

- **Don't pad the options list.** Three credible options beat five where two are strawmen. Include only options that someone reasonable might actually choose.
- **Don't bury the recommendation.** It goes at the end of the analysis section, not as a footnote. The reader should be able to find it in 10 seconds.
- **Don't write the brief to please the audience.** A decision brief that tells the stakeholders what they want to hear isn't a brief — it's a ratification document. The recommendation follows the analysis, not the politics.

### Common Failures

- **The decision is actually two decisions**: "Should we expand to Europe and how should we staff it?" is two decisions. Split them. The first decision's answer determines the second decision's parameters.
- **No decision needed yet**: Sometimes the right output is "insufficient information to decide — here's what we need." That's a valid and valuable output. Name the information gap clearly.

### When to Ask the User

- When the decision question is ambiguous enough that two different phrasings would produce different options
- When the deadline isn't clear and it affects how much risk the recommendation can carry
- When the user wants to stress-test the recommendation before finalizing (suggest running cynical-geoff on it)
