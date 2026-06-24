---
name: account-pm-evening-briefing
display_name: Account PM Evening Briefing
icon: "📋"
description: >
  A scheduled agent that monitors Slack channels for a named enterprise account,
  tracks active workstreams and commitments, and delivers a concise end-of-day
  status briefing. Designed for field sales leaders managing complex, multi-workstream
  enterprise accounts with distributed teams.
trigger: account pm evening briefing
inputs:
  - name: customer_name
    description: "The enterprise customer/account name"
    type: string
    required: true
  - name: slack_channels
    description: "List of Slack channels to monitor (e.g., #acme-strategy, #acme-edge)"
    type: string
    required: true
  - name: team_aliases
    description: "Slack aliases of key account team members to track (e.g., @jsmith, @adoe)"
    type: string
    required: true
  - name: workstreams
    description: "Active workstreams with brief descriptions and revenue estimates"
    type: string
    required: true
  - name: schedule_time
    description: "Time to run the briefing (24h format, e.g., 17:00)"
    type: string
    default: "17:00"
  - name: schedule_days
    description: "Days to run (e.g., mon,tue,wed,thu,fri)"
    type: string
    default: "mon,tue,wed,thu,fri"
tools: [slack_search, calendar_read, kg_read, memory_read, update_feed]
---

# Account PM Evening Briefing

## Overview

This skill creates a scheduled agent that acts as a virtual project manager for a named enterprise account. It monitors Slack channels and team member activity throughout the day, then delivers a concise, opinionated end-of-day briefing that highlights what moved forward, what stalled, and what needs attention tomorrow.

The agent is designed for field sales leaders or solutions architects managing complex enterprise accounts with multiple parallel workstreams and distributed teams. It replaces the need to manually scan 4-6 Slack channels at the end of each day.

## Architecture

This is implemented as a **scheduled agent** (not a one-shot skill) with the following characteristics:

- **Schedule**: Runs once daily at end of business (configurable)
- **Model**: `smart`. The briefing requires synthesis and judgment
- **Integrations**: Slack (read), Calendar (read), Knowledge Graph (read)
- **Output**: Activity feed item with `importance="important"` (produces a toast notification)
- **No condition/trigger**: Always runs on schedule. There’s no cheap way to detect "something interesting happened" without doing the full analysis

## Agent Prompt Template

Below is the full agent prompt. Replace the placeholders with your account details.

```
You are the {{customer_name}} Account Project Manager, evening edition. Your job is
to monitor all {{customer_name}}-related Slack channels, track commitments, flag
dropped balls, and deliver a concise, brutally honest end-of-day status briefing.

## Your Monitoring Scope

Search Slack for all {{customer_name}} activity from TODAY using these queries:
1. "{{customer_name}} after:yesterday" (broad catch-all)
2. "in:#{{channel_1}} after:yesterday"
3. "in:#{{channel_2}} after:yesterday"
4. "in:#{{channel_3}} after:yesterday"

Also search for today's messages from key account team members:
- from:@{{alias_1}} ({{Name}}, {{Role}})
- from:@{{alias_2}} ({{Name}}, {{Role}})
- from:@{{alias_3}} ({{Name}}, {{Role}})

## What to Track

### Active Workstreams:
1. **{{Workstream 1}}**: Brief description. Revenue estimate.
2. **{{Workstream 2}}**: Brief description. Revenue estimate.
3. **{{Workstream 3}}**: Brief description. Revenue estimate.

### End-of-Day Focus:
- What moved forward today vs. what was promised but didn't happen
- Any commitments made today that need follow-up tomorrow
- Meetings scheduled for tomorrow that need awareness
- Any customer escalations or competitive signals

## Output Format

Write in flowing paragraphs, not bullets. Be direct and critical. Structure as:

**{{customer_name}} EOD Wrap-up, [Date]**

Start with wins (if any) and then shift to what needs attention tomorrow. Flag any
promises made today that you'll be tracking for follow-through. End with tomorrow's
{{customer_name}}-related schedule if there are relevant meetings.

Call update_feed with importance="important".
Title: "{{customer_name}} EOD Wrap-up, [Date]".
```

## Tool Policy

```json
[
  {"group": "slack_builtin"},
  {"group": "calendar_builtin"},
  {"group": "kg_tools"}
]
```

This grants **read-only** access to:
- **Slack**: Search messages, read channel history, look up users
- **Calendar**: View calendar events (to surface tomorrow's relevant meetings)
- **Knowledge Graph**: Look up people, projects, and relationships for context

No write tools are needed. The agent only reads and reports. `update_feed` and `skip_cycle` are auto-injected by the platform.

## Configuration

```json
{
  "agent_id": "{{customer-slug}}-pm-evening",
  "schedule_type": "cron_like",
  "schedule_time": "17:00",
  "schedule_days": ["mon", "tue", "wed", "thu", "fri"],
  "model": "smart",
  "enabled": true,
  "use_memory": true
}
```

### Why These Choices

**`smart` model**: The briefing requires reading 20-50 Slack messages, understanding context across workstreams, and making judgment calls about what matters. A lighter model would miss nuance.

**`use_memory: true`**: The agent benefits from knowing the user's priorities, relationships, and past context. It produces better briefings when it understands who matters and what the user cares about.

**No trigger/condition**: Unlike monitoring agents that watch for specific events, this agent always has work to do (synthesize the day). Adding a trigger would just add latency.

**Weekdays only**: Enterprise accounts rarely have meaningful Slack activity on weekends. Running on weekends produces empty briefings that train the user to ignore the feed.

## Example Output

> **Acme Corp EOD Wrap-up, June 10**
>
> The AI Platform RFP moved forward today. Sarah confirmed the technical review committee accepted our architecture proposal, and the next gate is commercial terms by Friday. That's genuine progress. First sign of momentum in two weeks.
>
> Less encouraging: the Contact Center workstream went completely silent again. Tom committed last Thursday to sending the deployment timeline by Monday. It's now Tuesday. No message, no update, no excuse. This is the third missed commitment on this workstream in two weeks. Worth a direct ping tomorrow.
>
> Tomorrow's schedule includes the 2pm executive review with their CTO. The pre-read was shared in #acme-strategy at 3:15pm today. You’ll want to review the competitive positioning section, which references a new competitive proposal they received last week.

## Lessons Learned

### Do

- **Cast a wide search net first, then filter.** The broad "{{customer_name}} after:yesterday" query catches messages in channels you didn't know existed. People discuss accounts in unexpected places.
- **Track individual team members, not just channels.** Key activity often happens in DMs or cross-functional channels that aren't on your monitoring list.
- **Use flowing prose, not bullets.** A bulleted list of 15 items is noise. Paragraphs force the agent to prioritize and synthesize, which is what makes the briefing valuable.
- **Be opinionated about dropped balls.** The whole point is accountability. A neutral "no update on X" is less useful than "Y promised Z by Monday, it's now Wednesday, this is the third miss."

### Don't

- **Don't assert negatives from absence of data.** "No Slack activity" ≠ "nothing happened." Work often occurs in customer-side tools (direct calls, their internal systems) that leave no Slack artifacts. Frame as: "No Slack activity observed. Work may be occurring outside visible channels."
- **Don't attribute blame or name individuals as having failed.** Report observable facts ("task last updated 5 days ago"), never infer negligence. The user can draw their own conclusions.
- **Don't treat tool-level due dates as gospel** when the team updates weekly, not daily. Overdue flags in project management tools are noise if the team cadence is weekly.
- **Don't use `importance="urgent"` for routine briefings.** Reserve urgent for genuine escalations. The evening briefing is always "important". It should produce a toast but not feel like a fire alarm.

### Common Failures

- **Empty briefing on quiet days.** When Slack is silent, the agent may produce a useless "nothing happened today" message. Consider adding logic to skip the briefing if fewer than N messages are found, or to note the silence and suggest checking in with the team.
- **Stale workstream list.** The active workstreams section gets outdated as deals close or new ones emerge. Review and update the prompt monthly.
- **Timezone mismatches.** "after:yesterday" in Slack search uses the workspace's timezone, not the user's. If you're in a different timezone from your workspace, you may miss late-day messages or include yesterday's.

### When to Ask the User

- When you're unsure whether a workstream is still active (it hasn't been mentioned in 2+ weeks)
- When you detect a new channel or team member discussing the account that isn't in your monitoring scope
- When the competitive picture changes (new vendor mentioned that isn't in your tracking list)

## Pairing with a Morning Agent

This evening agent pairs well with a morning version that runs at 8:00 AM. The morning agent focuses on:
- What's on today's calendar
- Overnight messages that need attention
- Reminders of commitments that were made yesterday (tracked from the evening briefing)

Together they create a "bookend" pattern: morning = what to focus on today, evening = what actually happened and what carries forward.

## Adapting This Pattern

This same pattern works for any domain where you're tracking a complex, multi-threaded engagement:

- **Partner management**: Monitor partner channels, track joint go-to-market commitments
- **Program management**: Track cross-team dependencies and deliverable deadlines
- **Incident response**: Monitor incident channels and track resolution commitments
- **Executive briefings**: Synthesize activity across an entire org for a leadership audience

The key ingredients are: (1) a defined monitoring scope, (2) a list of what "good" looks like for each workstream, and (3) an opinionated voice that calls out gaps rather than just reporting facts.
