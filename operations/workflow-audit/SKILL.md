---
name: workflow-audit
display_name: Workflow Audit
icon: "🔍"
description: >
  Reviews all AI assistant conversations from the last 24 hours to identify
  failures, inefficiencies, and optimization opportunities. Publishes a structured
  report to the activity feed. Designed to run daily at 2 AM as a scheduled agent,
  but can also be triggered manually.
trigger: workflow audit
tools: [folder_list, run_python, query_conversations, load_conversation_context, file_search, file_read, update_feed]
inputs: []
---

# Workflow Audit

## Overview

This skill reviews all AI assistant conversations from the last 24 hours, analyzes them for problems, inefficiencies, and patterns, then publishes a structured report to the activity feed. It is designed to run daily at 2 AM as a scheduled agent, but can also be triggered manually.

The goal is continuous improvement of how the assistant serves the user.

> **Note on tool names**: The tools referenced in this skill (`query_conversations`, `load_conversation_context`, `update_feed`, etc.) are platform-specific. Adapt them to your environment's equivalent APIs.

## Workflow

### Step 1: Query Recent Conversations

- **Mode**: `deterministic`
- **Tool**: `query_conversations`
- **Input**: Sessions updated in last 24 hours, ordered by recency
- **Output**: List of session IDs, titles, message counts, and timestamps

Use this query (or the equivalent for your platform):

```sql
SELECT id, title, datetime(created_at, 'unixepoch') as created,
       datetime(updated_at, 'unixepoch') as updated, message_count
FROM sessions
WHERE updated_at > unixepoch('now', '-24 hours')
ORDER BY updated_at DESC LIMIT 30
```

Also query with `include_background_tasks=true` to capture scheduled agents, threads, and forked tasks. This gives visibility into background automation health.

If zero user conversations are found, skip to Step 6 and publish a brief "No activity to review" FYI item.

### Step 2: Load Conversation Context

- **Mode**: `agentic`
- **Tool**: `load_conversation_context`
- **Input**: Each session ID from Step 1 (user-facing conversations only; skip scheduled and background sessions)
- **Output**: Full message history for each conversation

For each user-facing conversation, load up to 20 messages. Focus attention on:
- Messages containing task failure/completion status — these indicate background task outcomes
- Assistant messages with tool calls — these show what tools were used
- User messages with decision responses — these show user choices and corrections
- User messages that suggest something went wrong ("that's off", "try again", "status")

### Step 3: Inspect Session Workspaces

- **Mode**: `agentic`
- **Tools**: `file_search`, `file_read`
- **Input**: Session workspace paths for active conversations
- **Output**: Artifact inventory, tool output files, failed task logs

For each active session, list files in:
- `workspace/artifacts/` — generated deliverables
- `workspace/tools/` — tool call outputs

Read key files like task inspection outputs and task start results to understand what background work was attempted and whether it succeeded.

### Step 4: Analyze for Issues

- **Mode**: `agentic`
- **Tool**: `run_python`
- **Input**: All conversation context and workspace data from Steps 2–3
- **Output**: Structured findings across 5 categories

Analyze across these dimensions:

**Problems & Errors**: Task failures, tool errors, incorrect assumptions, user corrections

**Inefficiencies**: Tasks delegated to background that should have run in-session. Redundant lookups. Excessive back-and-forth for simple requests.

**Anti-Patterns**: Known anti-patterns that were violated. Patterns of similar failures across sessions.

**Optimization Opportunities**: Workflows that could become skills. Information that should be in memory. Scheduled tasks that could automate repeated work.

**Cross-Project Insights**: Connections between conversations the user might not see. Strategic observations about time allocation and priorities.

### Step 5: Score and Rank

- **Mode**: `agentic`
- **Input**: Raw findings from Step 4
- **Output**: Efficiency score (1–10), ranked top 3 optimizations, memory suggestions

Scoring rubric:
- 9–10: No failures, minimal back-and-forth, all tasks completed first-try
- 7–8: Minor inefficiencies but no failures, good recovery
- 5–6: Failures occurred but recovered, some avoidable issues
- 3–4: Multiple failures, significant user frustration, repeated anti-patterns
- 1–2: Critical failures, data loss, or fundamentally broken workflows

Rank optimizations by: (impact on user time saved) × (likelihood of recurrence)

### Step 6: Publish Report

- **Mode**: `deterministic`
- **Tool**: `update_feed`
- **Input**: Analyzed findings, score, recommendations
- **Output**: Activity feed item with HTML report card

Publish with `importance="important"` for normal reports (issues found) or `importance="fyi"` for clean days or no-activity reports.

The feed item must include:
- `html_content`: A styled HTML report with sections for Executive Summary, Issues, Score, Top 3 Optimizations, Insights, and Memory Suggestions
- `choices`: Action buttons for the most impactful follow-ups (e.g., "Save X to memory", "View full report")
- `summary`: 1–2 sentence markdown summary with bold key metrics
- `title`: "Workflow Review: [date range]"
- `event_type`: "workflow_review"

## Output

A structured activity feed card containing:

1. **Executive Summary** — 2–3 sentence overview of the day's workflow health
2. **Issues Found** — Specific problems with context (which conversation, what went wrong)
3. **Efficiency Score** — 1–10 rating with justification
4. **Top 3 Optimizations** — Actionable recommendations ranked by impact
5. **Insights & Patterns** — Cross-cutting observations
6. **Suggested Memory Updates** — Facts or strategies to remember
7. **Action buttons** — Clickable CTAs for the highest-impact follow-ups

## Lessons Learned

### Do

- Query both user-facing sessions AND background tasks — the background task list reveals automation health and whether scheduled agents are running on cadence.
- Read tool output files in session workspaces — these contain the ground truth of what happened, not just the conversation narrative.
- Look for user correction language as signals: "that feels off", "try again", "status", explicit number corrections — these indicate the assistant made wrong assumptions.
- Check file sizes of generated artifacts to confirm they were actually created successfully (not empty/partial).
- Cite specific session IDs (shortened) and exact quotes when reporting issues — vague findings aren't actionable.

### Don't

- Don't report on scheduled or background sessions as if they're user conversations — they're automation infrastructure.
- Don't count "conversation opened but no messages" as an issue — users open and close sessions.
- Don't penalize for connector authentication flows requiring user action — that's expected UX.
- Don't recommend "save to memory" for things already in memory (check learned context first).
- Don't fabricate issues to fill the report — a clean day is a valid finding.

### Common Failures

- Some conversation tools require dependency skills to be loaded first — always check prerequisites.
- Some sessions have zero messages in the database despite having workspace artifacts (tool calls happened but messages weren't persisted) — check workspace files as fallback evidence.
- Filesystem timestamps may not be reliable in sandboxed environments — use query timestamps as the authoritative source of recency, not filesystem mtime.

### When to Ask the User

Never — this skill is designed to run autonomously (scheduled at 2 AM) and publish its findings. The user reviews the feed card at their convenience and can click action buttons to follow up.
