# Skills

A collection of AI assistant skills I've built and use daily. They fall into three categories: how I think, how I write, and how I run operations.

Each skill is a prompt-based instruction set that extends an AI assistant's default behavior. They're designed to be small, composable, and easy to adapt. Fork what's useful. Make it yours.

---

## Thinking

Skills for critical analysis, intellectual rigor, and structured decision-making.

- **[Cynical Geoff](./thinking/cynical-geoff/SKILL.md)** — A structured intellectual adversary. Steel-mans your argument, surfaces hidden assumptions, runs a pre-mortem, and delivers a brutally honest verdict. Activate when you want your idea genuinely stress-tested, not validated.

- **[Anti-Sycophancy](./thinking/anti-sycophancy/SKILL.md)** — Forces truth-seeking over agreement. Internally reframes affirmation-seeking input as neutral questions before responding, dramatically reducing the tendency to tell you what you want to hear. Based on arXiv:2602.23971.

- **[Decision Brief](./thinking/decision-brief/SKILL.md)** — Produces a one-page decision memo: options, tradeoffs, recommendation, and the reasoning behind it. The constructive counterpart to Cynical Geoff — where that skill stress-tests, this one moves you forward.

- **[Executive Review Board](./thinking/executive-review-board/SKILL.md)** — Submits a document or idea to a panel of six iconic business leaders (Bezos, Jobs, Buffett, Jassy, Nadella, Musk) for structured critical feedback. Each reviews through their known intellectual framework. Use before committing to anything consequential.

---

## Writing

Skills for producing clean, human-sounding prose.

- **[Remove AI Slop](./writing/remove-ai-slop/SKILL.md)** — Rewrites AI-generated text into tight, natural prose. Two registers: formal (business docs, channel posts) and conversational (DMs, thought leadership). Strunk & White is the standard. Includes a tiered vocabulary replacement list, structural pattern detection, and a pre-delivery quick-check checklist.

---

## Operations

Skills for running accounts and daily workflow.

- **[Morning Brief](./operations/morning-brief/SKILL.md)** — Runs at 8 AM and delivers a focused start-of-day briefing: today's priority, overnight Slack activity that changes anything, and calendar readiness. The morning half of a daily bookend pattern.

- **[Account PM Evening Briefing](./operations/account-pm-evening-briefing/SKILL.md)** — A scheduled agent that acts as a virtual project manager for a named enterprise account. Monitors Slack channels and team activity throughout the day, then delivers a concise, opinionated end-of-day briefing. The evening half of the daily bookend pattern.

- **[Pre-Meeting Prep](./operations/pre-meeting-prep/SKILL.md)** — Builds a one-page meeting brief in under 5 minutes: who's in the room and what they care about, relevant history, a sharpened objective, and the landmines to avoid. Runs in the 30 minutes before any meeting.

- **[Workflow Audit](./operations/workflow-audit/SKILL.md)** — Reviews all AI assistant conversations from the last 24 hours, analyzes them for failures and inefficiencies, and publishes a structured report card. Designed to run nightly as a scheduled agent.

---

## Structure

Each skill lives in its own folder with a single `SKILL.md` file:

```
skills/
├── thinking/
│   ├── cynical-geoff/SKILL.md
│   ├── anti-sycophancy/SKILL.md
│   ├── decision-brief/SKILL.md
│   └── executive-review-board/SKILL.md
├── writing/
│   └── remove-ai-slop/SKILL.md
└── operations/
    ├── morning-brief/SKILL.md
    ├── account-pm-evening-briefing/SKILL.md
    ├── pre-meeting-prep/SKILL.md
    └── workflow-audit/SKILL.md
```

Each `SKILL.md` follows the same format: frontmatter (name, trigger, inputs), overview, workflow, output, and lessons learned.
