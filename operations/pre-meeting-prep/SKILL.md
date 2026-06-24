---
name: pre-meeting-prep
display_name: Pre-Meeting Prep
icon: "📅"
description: >
  Prepares you for any meeting by pulling context on attendees, surfacing
  relevant history, clarifying what you need to walk out with, and flagging
  what not to say. Runs in the 30 minutes before a meeting and produces a
  one-page brief you can read in under 5 minutes.
trigger: pre-meeting prep
inputs:
  - name: meeting_title
    description: "The meeting name or calendar event title"
    type: string
    required: true
  - name: attendees
    description: "Names or aliases of key attendees to research"
    type: string
    required: false
  - name: objective
    description: "What you want to walk out of this meeting with"
    type: string
    required: false
  - name: context
    description: "Any additional background: deal stage, prior friction, open issues"
    type: string
    required: false
tools: [slack_search, calendar_read, kg_read, memory_read]
---

# Pre-Meeting Prep

## Overview

This skill builds a one-page brief for any meeting, in under 5 minutes. It pulls context on who's in the room, surfaces relevant history from Slack and memory, sharpens your objective, and flags the landmines: things that could derail the meeting if you walk in without knowing about them.

The output is not a summary of everything that's happened. It's a tight prep document that answers four questions: who are these people, what do they care about, what do I need from this meeting, and what could blow it up.

## Workflow

### Step 1: Pull Attendee Context

For each attendee listed in `{{attendees}}`:
- Search the knowledge graph and memory for their role, priorities, and communication style
- Search Slack for recent messages from them related to this topic
- Note any pending commitments between you and them

Identify the decision-maker, the skeptic, and any silent stakeholders whose buy-in matters.

### Step 2: Surface Relevant History

Search Slack and memory for prior context on this meeting's topic:
- Last time this topic came up: what was decided, what was deferred
- Any commitments made in prior meetings that are still open
- Recent friction points or unresolved disagreements
- Competitive signals relevant to this conversation

The goal is to walk in knowing what they remember from last time, not just what you remember.

### Step 3: Sharpen the Objective

If `{{objective}}` was provided, pressure-test it:
- Is it realistic given the room and the context?
- Is it specific enough to know whether you achieved it?
- Is there a fallback objective if the primary isn't achievable today?

If no objective was provided, infer one from the meeting title and context. A meeting without a clear objective is a meeting you'll need to have again.

### Step 4: Identify Landmines

Based on history and attendee context, surface:
- Topics that are politically sensitive in this room
- Prior commitments you made that you may be asked about
- Known objections or skepticism that's likely to surface
- Anything that happened recently that changes the dynamic

These are the things that catch people off guard. Name them explicitly so you're not surprised.

### Step 5: Write the Brief

Produce a one-page prep document in the following structure. Prose paragraphs, not bullets.

## Output Format

```
**Pre-Meeting Brief: {{meeting_title}}, [Date/Time]**

**The Room**: Who's attending and what each person cares about. Flag the 
decision-maker and note any attendee whose posture is unclear or likely 
adversarial.

**Context**: What's happened before that's relevant. One paragraph. If this 
is a first meeting, say so and note what they likely know about you.

**Objective**: What you need to walk out with. Primary objective. Fallback 
objective if primary isn't achievable. How you'll know you got it.

**Landmines**: What could blow this up. Specific, not generic. If there's 
nothing that could derail this meeting, note that. It means the meeting is 
low-stakes.

**The One Thing**: If you only have 30 seconds to remember one thing going 
into this room, it's this.
```

## Lessons Learned

### Do

- **Lead with the room, not the agenda.** Meetings don't fail because the agenda was wrong. They fail because someone misread who was in the room and what they needed.
- **Make the objective specific enough to be falsifiable.** "Have a productive conversation" is not an objective. "Get alignment on the concessions floor before the Friday deadline" is.
- **Name the landmines explicitly.** The instinct is to leave them vague ("there may be some sensitivity around..."). Name the actual issue. Vague warnings don't protect you.
- **Keep the brief under one page.** If you're still reading when the meeting starts, it failed.

### Don't

- **Don't summarize the full relationship history.** One paragraph on prior context. The brief is prep, not a case file.
- **Don't list every attendee equally.** Identify who matters most in this specific meeting and give them proportionally more attention.
- **Don't skip the fallback objective.** Meetings rarely go exactly as planned. Knowing your fallback before you walk in keeps you from leaving empty-handed.

### Common Failures

- **No history available**: For first meetings or new topics, Slack and memory may have nothing. In that case, focus entirely on the objective and attendee context. Note explicitly that this is a cold start.
- **Meeting purpose is unclear from the title**: Calendar invites often have meaningless titles ("Sync", "Check-in", "Follow-up"). Use attendee context and `{{context}}` input to infer purpose. If it's still unclear, flag it. Walking into a meeting without knowing why it's happening is a preparation failure you can avoid.

### When to Ask the User

- When the meeting objective is missing and can't be inferred from context
- When attendees are listed by first name only and identity is ambiguous
- When the user provides conflicting signals about meeting purpose
