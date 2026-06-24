---
name: news-brief
display_name: News Brief
icon: "📰"
description: >
  A scheduled or on-demand agent that scans the web for news about your company,
  products, services, competitors, and category, then delivers a fast newsreel:
  the headlines that moved, what changed, and what it means for you. Reads like a
  wire feed, not a research report. Pairs with morning-brief for start-of-day context.
trigger: news brief
inputs:
  - name: company
    description: "Your company or the primary subject to track"
    type: string
    required: true
  - name: products
    description: "Products or services to watch for coverage, launches, reviews, outages"
    type: string
    required: false
  - name: competitors
    description: "Named competitors to track for moves, launches, funding, and exits"
    type: string
    required: false
  - name: category
    description: "The market or category to scan for trends, regulation, and shifts (e.g., enterprise AI, fintech)"
    type: string
    required: false
  - name: lookback
    description: "How far back to scan (e.g., 24h, 7d). Default 24h for daily, 7d for weekly."
    type: string
    default: "24h"
  - name: schedule_time
    description: "Time to run if scheduled (24h format, e.g., 07:00)"
    type: string
    default: "07:00"
  - name: schedule_days
    description: "Days to run (e.g., mon,tue,wed,thu,fri)"
    type: string
    default: "mon,tue,wed,thu,fri"
tools: [web_search, web_fetch, memory_read, update_feed]
---

# News Brief

## Overview

This skill scans the web for what happened to your company, your products, your competitors, and your category, then delivers a newsreel. The format is a wire feed: short, ranked, every item tied to why it matters to you. It is built to be read in two minutes and to leave you knowing the one or two stories you cannot walk into the day without.

It is not a clipping service and not a research report. A clipping service hands you twenty links and makes you do the work. A research report buries the signal in context. This skill does the opposite: it reads everything, throws out the noise, and reports only what changed and what it means.

It pairs naturally with the [morning-brief](../morning-brief/SKILL.md), which covers your internal day. News Brief covers the outside world. Run News Brief first and the morning brief can fold its top story into the day's priority.

## Architecture

- **Schedule**: Runs on demand, or daily at 7 AM before the morning brief (configurable). Weekly works for slower categories.
- **Model**: `smart` because ranking and "so what" reasoning need judgment, not just retrieval.
- **Integrations**: Web search and fetch (read), Memory (read), feed (write).
- **Output**: Activity feed item with `importance="important"`, or inline when run on demand.
- **Memory**: Reads the prior brief so it can mark what is genuinely new versus a running story.

## Workflow

### Step 1: Build the Watchlist

Assemble the search set from the inputs:

- `company` queries: the name plus "news", "announcement", "earnings", "outage", "lawsuit", "leadership".
- `products` queries: each product name plus "launch", "review", "pricing", "bug", "recall".
- `competitors` queries: each competitor plus "launch", "funding", "acquisition", "layoffs", "partnership".
- `category` queries: the category plus "trend", "regulation", "report", "shift".

If memory holds the prior brief, load its running stories so you can tell a fresh development from a repeat.

### Step 2: Scan

Search across the `lookback` window. Cast wide, then cut. Prefer primary sources and established outlets over aggregators. Capture the source, the date, and one verifiable fact per item. Discard anything you cannot date or attribute.

A quiet window is a valid result. Do not pad the brief to make it look busy.

### Step 3: Rank by Materiality

Score each candidate story by how much it changes a decision you would make:

- **Lead**: directly affects your company, a deal, or a product you own. A competitor launching into your exact use case. A regulation that hits your roadmap.
- **Notable**: relevant to the category or a competitor, worth knowing, not worth acting on today.
- **Background**: context that matters over weeks, not today.

Cut anything below background. Three sharp stories beat ten soft ones.

### Step 4: Write the "So What"

For each story that makes the cut, write one line of plain fact and one line of consequence. The fact is what happened. The consequence is what it means for you: a threat, an opening, a talking point for a meeting, a reason to move faster. A story with no consequence does not belong in the brief.

### Step 5: Deliver the Newsreel

Write it as a wire feed, prose, no link dumps. Lead with the single most important story. Group the rest under the company, competitors, and category. Close with one line on what to watch next.

## Output

Newsreel format. Prose, ranked, every item carrying its "so what".

```
**News Brief, [Date] · [lookback window]**

**Top Story**: The one story that matters most today, in two or three sentences.
What happened, and what it means for you.

**[Company]**: Coverage, announcements, and signals about you and your products.
If it was quiet, say so in one line.

**Competitors**: What the named competitors did. Moves, launches, funding, exits.
Each with a one-line read on the threat or opening it creates.

**Category**: Trends, regulation, and shifts in the market you operate in.

**Watch Next**: One or two running stories that are not resolved yet and could
move this week.
```

Call update_feed with importance="important" when scheduled. Title: "News Brief, [Date]".

## Example Output

> **News Brief, June 23 · last 24h**
>
> **Top Story**: A competitor you track, Northwind, announced a managed deployment tier aimed at the same regulated-enterprise buyers you sell to, priced below your floor. This is a direct shot at your Contact Center workstream. Expect the Acme CTO to raise it in Thursday's review, so get ahead of it with a side-by-side before then.
>
> **Your Company**: Quiet news cycle. One trade outlet cited your platform as a reference customer in a piece on production AI, which is a usable proof point for the pipeline review.
>
> **Competitors**: Beyond Northwind, Vega closed a Series C and signaled a move upmarket, which means more competition for mid-market deals in two or three quarters, not now. No other tracked competitor made news.
>
> **Category**: A draft EU rule on model transparency advanced a stage. Nothing binding yet, but it points the same direction your roadmap already assumes.
>
> **Watch Next**: Northwind's pricing page has not gone live. Confirm the actual numbers before you build the comparison, and do not quote their figure until you can see it.

## Lessons Learned

### Do

- **Lead with the one story that changes a decision.** The whole value is ranking. If the reader has to find the important item themselves, the brief failed.
- **Attach a "so what" to every item.** A fact with no consequence is a clipping, not a brief. Name the threat, the opening, or the talking point.
- **Prefer primary sources and date everything.** A dated, attributed fact is worth ten breathless aggregator posts.
- **Make a quiet window explicit.** "Quiet news cycle, nothing material" is a finding. It tells the reader they are current.
- **Mark running versus new.** Use memory to separate a fresh development from a story you already reported, so day three of a saga does not read like day one.

### Don't

- **Don't dump links.** A list of headlines makes the reader do the work the skill exists to do.
- **Don't pad.** If only two stories matter, deliver two. Length is not value.
- **Don't repeat yesterday as if it broke today.** Check the prior brief before leading with a story already covered.
- **Don't state rumor as fact.** Label unconfirmed reports as unconfirmed and say what would confirm them.
- **Don't editorialize past the evidence.** The read should follow from the fact, not from a hunch.

### Common Failures

- **Source thin or paywalled**: When coverage is light or locked, say what is known and what could not be verified rather than presenting a fragment as the full story.
- **Name collisions**: Common company or product names pull unrelated results. Add a disambiguating term (the category, a city, a ticker) to the query and discard mismatches.
- **No prior brief in memory**: On a first run there is no running-story baseline, so everything reads as new. Note it: "first run, no baseline for comparison."
- **Stale watchlist**: Competitors and products change. Review the input lists monthly so you are not tracking a competitor that already exited or missing one that just entered.

### When to Ask the User

- When a competitor or product name is ambiguous and the search returns two plausible subjects.
- When a story is material but unconfirmed and acting on it early carries real risk.
- When the category is broad enough that the scan needs a tighter boundary to be useful.
