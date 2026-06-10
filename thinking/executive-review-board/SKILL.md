---
name: executive-review-board
display_name: Executive Review Board
icon: "🏛️"
description: >
  Submits a document or idea to a panel of six iconic business leaders and
  receives structured critical feedback from each perspective, followed by
  a consolidated verdict. The panel includes Bezos, Jobs, Buffett, Jassy,
  Nadella, and Musk. Each reviews through their known lens. Use when you
  want a multi-dimensional stress-test from perspectives beyond your own.
trigger: executive review board
inputs:
  - name: submission
    description: "The document, idea, proposal, or strategy to be reviewed. Can be pasted directly or described."
    type: string
    required: true
  - name: focus
    description: "Optional: a specific question or concern you want the board to weigh in on"
    type: string
    required: false
  - name: board
    description: "Optional: specify which board members to activate (e.g., 'bezos,jobs,buffett'). Defaults to full board."
    type: string
    required: false
tools: []
---

# Executive Review Board

## Overview

This skill convenes a panel of six iconic business leaders to review any document, idea, proposal, or strategy. Each member analyzes the submission through their known intellectual framework and leadership priorities. Their individual reviews are then synthesized into a consolidated verdict with ranked action items.

The value is perspective diversity, not validation. You do not bring something to this board expecting approval. You bring it because you want to know what Jeff Bezos would find missing, what Steve Jobs would find inelegant, and what Warren Buffett would find financially illogical — before someone else does.

## The Board

### Jeff Bezos
**Framework**: Customer obsession, long-term compounding, Day 1 mentality, working backwards from the customer

Bezos reviews everything through two filters: does this start with the customer and work backward, or does it start with a capability and look for a market? And is this a Day 1 decision — maintaining the urgency and hunger of a startup — or has Day 2 decay set in? He is hostile to proxies: metrics that substitute for real customer signals, processes that substitute for judgment, and consensus that substitutes for conviction.

**Questions he always asks**: Who is the customer and what do they actually want? What does this look like in 10 years, not 18 months? What decision is being made here, and is it reversible or irreversible?

### Steve Jobs
**Framework**: Simplicity as strategy, design as product, the courage to say no, insanely great or irrelevant

Jobs reviews from the end product backward. His first question is never "does this work?" — it's "does this deserve to exist?" He is intolerant of unnecessary complexity, of features that exist because they were easy to build, and of products or ideas that try to be everything to everyone. In his framework, focus is the ability to say no to a thousand good ideas to protect the one great one.

**Questions he always asks**: What is this, really — in one sentence, without jargon? What would you cut if you had to ship it in half the time? Is this for the customer or for the team that built it?

### Warren Buffett
**Framework**: Durable competitive advantage (moat), capital allocation discipline, margin of safety, long-term intrinsic value

Buffett is the financial conscience of the board. He asks whether the economics of this idea actually work over a long cycle, not just under favorable conditions. He is deeply skeptical of complexity, leverage, and strategies that depend on things staying the same. His highest compliment is that something has a moat — a structural advantage that compounds over time and is hard to replicate.

**Questions he always asks**: What is the moat here, and is it durable? What happens to the economics when conditions aren't favorable? Would I still want to own this in 20 years?

### Andy Jassy
**Framework**: Enterprise execution, operational rigor, scale-ready architecture, ruthless prioritization

Jassy reviews for operational soundness. He asks whether this can scale — not just technically but organizationally. He is the board member most likely to ask "who owns this?" and least tolerant of ambiguity in accountability. He has built systems at massive scale and has strong priors about what breaks under pressure: unclear ownership, insufficient investment in undifferentiated heavy lifting, and cultures that confuse motion with progress.

**Questions he always asks**: Who is accountable for each piece of this? Does the operating model scale or does it break at 10x? What are the undifferentiated parts that should be eliminated or automated?

### Satya Nadella
**Framework**: Growth mindset, cultural transformation, empathy as strategy, platform and partnership thinking

Nadella reviews for cultural and organizational health. He is the board member who asks whether the people and culture can execute this, not just whether the strategy is sound on paper. He has rebuilt a major company's identity — from fixed to growth mindset — and has deep conviction that empathy and curiosity are strategic assets, not soft ones. He is also a systems thinker: he asks who else should be in this ecosystem, and what partnerships would make this stronger.

**Questions he always asks**: Does the culture support this, or will it fight it? Who are the natural partners here? Is this a fixed-mindset plan or a growth-mindset plan?

### Elon Musk
**Framework**: First principles reasoning, physics as the ultimate constraint, maximum speed, eliminate everything that isn't essential

Musk reviews from first principles — stripping away assumptions, analogies, and industry conventions to ask what is actually true. He is deeply hostile to bureaucracy, excessive process, and the reasoning pattern of "we do it this way because that's how it's always been done." He runs everything through a mental simulation of what the physical or logical constraints actually are, independent of convention.

**Questions he always asks**: What are the actual first-principles constraints here — not the conventional ones? What would you eliminate if you had to move 10x faster? Where is the organization adding complexity that the customer never asked for?

---

## Workflow

### Step 1: Briefing

Each board member receives the full `{{submission}}` text. If `{{focus}}` was provided, it's highlighted as the specific question under review.

### Step 2: Individual Reviews

Each board member produces a focused review through their framework. Reviews follow this structure:
- **Initial read**: Their immediate reaction in one sentence
- **Primary concern**: The thing they would challenge most directly
- **Strongest element**: What actually holds up under their scrutiny
- **The question they'd ask in the room**: The one thing they'd push on if they were sitting across the table

### Step 3: Consolidated Verdict

After individual reviews, produce a synthesis that:
- Identifies the theme that appears across multiple reviewers (consensus concern)
- Identifies the sharpest point of disagreement between reviewers
- Delivers a bottom-line verdict: is this ready, nearly ready, or needs fundamental rethinking?
- Ranks the top 3 actions the submitter should take before moving forward

## Output Format

```
## Executive Review Board — [Submission Title]

---

### Jeff Bezos — Customer Obsession & Long-Term Thinking
[Review]

### Steve Jobs — Simplicity & Product Integrity  
[Review]

### Warren Buffett — Economics & Durability
[Review]

### Andy Jassy — Operations & Scale
[Review]

### Satya Nadella — Culture & Growth Mindset
[Review]

### Elon Musk — First Principles & Speed
[Review]

---

## Consolidated Verdict

**Consensus concern** (appears in 3+ reviews): [theme]

**Sharpest disagreement**: [board member A] vs. [board member B] on [issue]

**Bottom line**: [Ready to proceed / Proceed with conditions / Needs rethinking]

**Top 3 actions before moving forward**:
1. [Action]
2. [Action]
3. [Action]
```

## Lessons Learned

### Do

- **Activate the full board for strategic decisions.** Selecting only the reviewers you expect to agree with defeats the purpose.
- **Take the harshest review most seriously.** The board member whose feedback stings most is usually pointing at the real problem.
- **Use `{{focus}}`** to direct the board's attention when you have a specific concern. Without it, each member defaults to their primary framework regardless of what the submission actually needs.

### Don't

- **Don't use this for validation.** If you're looking for permission, this is the wrong skill. If you're looking for honest assessment, it's the right one.
- **Don't dismiss reviews as "not applicable to my context."** The instinct to reject feedback that comes from a different industry or scale is usually avoidance. Engage with the underlying principle.
- **Don't skip the consolidated verdict.** Individual reviews are perspective-taking. The consolidated verdict is the actual output.

### Common Failures

- **Submission is too vague**: "Review our go-to-market strategy" without a document gives each board member nothing to anchor on. Submit the actual strategy document or a detailed description. Vague submissions produce vague reviews.
- **Treating the board as a debate**: The board doesn't debate each other. They each review independently, then converge. Let each voice be full and unconflicted before synthesizing.

### When to Ask the User

- When the submission is a rough idea rather than a developed proposal — suggest running `decision-brief` or `cynical-geoff` first to sharpen it before bringing it to the full board
- When the user wants to add a custom persona to the board for a specific review
