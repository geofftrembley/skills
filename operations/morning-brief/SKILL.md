---
name: morning-brief
display_name: Morning Brief
icon: "🌅"
description: >
  A scheduled agent that runs at 8 AM and delivers a focused start-of-day
  briefing: what's on the calendar, overnight messages that need attention,
  and unresolved commitments carried forward from the previous evening.
  Pairs with account-pm-evening-briefing to create a daily bookend.
trigger: morning brief
inputs:
  - name: customer_name
    description: "The enterprise account or project name to focus on"
    type: string
    required: false
  - name: schedule_time
    description: "Time to run (24h format, e.g., 08:00)"
    type: string
    default: "08:00"
  - name: schedule_days
    description: "Days to run (e.g., mon,tue,wed,thu,fri)"
    type: string
    default: "mon,tue,wed,thu,fri"
tools: [slack_search, calendar_read, kg_read, memory_read, update_feed]
---

# Morning Brief

## Overview

This skill creates a scheduled agent that runs at 8 AM and answers one question: what do I actually need to focus on today? It scans overnight Slack activity, pulls today's calendar, surfaces any commitments that were flagged the previous evening, and produces a short, opinionated brief that tells you where to put your attention before you open anything else.

It is the morning half of a daily bookend pattern. The [account-pm-evening-briefing](../account-pm-evening-briefing/SKILL.md) captures what happened and what carried over. This skill picks that thread up and turns it into a day plan.

## Architecture

- **Schedule**: Runs at 8 AM on weekdays (configurable)
- **Model**: `smart`. Synthesizing overnight activity requires judgment
- **Integrations**: Slack (read), Calendar (read), Knowledge Graph (read)
- **Output**: Activity feed item with `importance="important"`
- **Memory**: Reads yesterday's evening briefing context when available

## Agent Prompt Template

```
You are the morning briefing agent. Your job is to tell me what to focus on 
today, not everything that happened, but what actually matters for the next 
8 hours.

## Step 1: Check Yesterday's Carryover

If memory contains an evening briefing from yesterday, extract:
- Commitments that were flagged as needing follow-up today
- Any dropped balls that were called out
- Competitive signals or escalations that were still unresolved

This is your baseline. Today either clears these items or they get louder.

## Step 2: Scan Overnight Slack

Search Slack for activity since yesterday at 5 PM:
- Any messages directed at me that haven't been addressed
- Any channel activity that changes the status of active workstreams
- Any escalations, urgent flags, or customer-initiated threads

Focus on signal, not volume. A quiet night is a valid finding.

## Step 3: Pull Today's Calendar

Check today's calendar for:
- Meetings in the next 8 hours with context on what they require
- Any prep that's needed and not yet done
- Back-to-back blocks that leave no room for follow-up

Flag meetings where I appear unprepared based on available context.

## Output Format

Write in 3 short sections. No bullets. Prose.

**Morning Brief, [Date]**

**Today's Priority**: One sentence. The single most important thing to move 
today, based on carryover and overnight activity.

**Overnight**: What happened while you were away that changes anything. If 
nothing changed, say so in one sentence and move on.

**Calendar**: What's on the schedule, whether you're ready for it, and what 
needs prep before it happens.

Call update_feed with importance="important".
Title: "Morning Brief, [Date]"
```

## Tool Policy

```json
[
  {"group": "slack_builtin"},
  {"group": "calendar_builtin"},
  {"group": "kg_tools"}
]
```

## Configuration

```json
{
  "agent_id": "morning-brief",
  "schedule_type": "cron_like",
  "schedule_time": "08:00",
  "schedule_days": ["mon", "tue", "wed", "thu", "fri"],
  "model": "smart",
  "enabled": true,
  "use_memory": true
}
```

### Why These Choices

**Three sections, not five**: The evening briefing is the full account. The morning brief should be fast. One priority, one overnight scan, one calendar read. If you're still reading at 8:15, it's too long.

**Prose, not bullets**: Bullets encourage listing everything. Paragraphs force the agent to decide what's actually important. The goal is a brief, not a digest.

**`use_memory: true`**: Without memory of yesterday's evening briefing, this skill is just a calendar summary. The carryover from the previous evening is where the real value lives.

## Example Output

> **Morning Brief, June 11**
>
> **Today's Priority**: The Acme Corp commercial terms review is due Friday and the account team hasn't aligned on the concessions floor. That conversation needs to happen before the 2pm call today.
>
> **Overnight**: Sarah sent a note in #acme-strategy at 7:42pm flagging that the CTO wants to revisit the architecture decision from last week's review. No details yet. That's the live hand grenade going into today's meeting.
>
> **Calendar**: Three meetings today. The 9am pipeline review is fine. You were prepped yesterday. The 2pm Acme call is where the risk is; the pre-read hasn't been circulated and you have 90 minutes to fix that. The 4pm 1:1 is a working session and needs no prep.

## Bookend Pattern

| Time | Skill | Purpose |
|------|-------|---------|
| 8:00 AM | Morning Brief | What to focus on today |
| 5:00 PM | Evening Briefing | What actually happened, what carries forward |

The two skills share memory. The evening brief's carryover flags become the morning brief's priority inputs. Together they replace the habit of scanning Slack for 20 minutes before you know what you're doing.

## Lessons Learned

### Do

- **Lead with the priority, not the summary.** The most common mistake is opening with "here's everything that happened." Open with what to do first.
- **Make silence explicit.** If nothing urgent happened overnight, say "quiet night, no change to active workstreams" rather than skipping the section. Absence of news is information.
- **Flag unpreparedness directly.** If there's a meeting in 2 hours and context suggests you're not ready, say so with specifics. Not "you may want to review", but "the pre-read hasn't been sent and the meeting is at 2pm."

### Don't

- **Don't recap the full evening briefing.** Memory includes it. Extract what's still relevant, leave the rest.
- **Don't flag low-signal activity.** A Slack emoji reaction isn't news. Apply a materiality threshold: only surface what requires a response or changes a plan.
- **Don't run on weekends.** Same logic as the evening briefing. Enterprise accounts go quiet on weekends and a brief that says "nothing happening" trains the user to ignore the feed.

### Common Failures

- **No evening briefing in memory**: When the evening briefing didn't run the previous day (weekend, holiday, or failure), the morning brief loses its carryover context. Detect this and note it: "No carryover available, yesterday's briefing wasn't found."
- **Calendar access lag**: Calendar integrations occasionally have sync delays. If today's events look incomplete, flag it rather than presenting partial data as complete.
