# Skills

A collection of AI assistant skills I've built and use daily. They fall into three categories: how I think, how I write, and how I run operations.

Each skill is a prompt-based instruction set that extends an AI assistant's default behavior. They're designed to be small, composable, and easy to adapt. Fork what's useful. Make it yours.

---

## Thinking

Skills for critical analysis and intellectual rigor.

- **[Cynical Geoff](./thinking/cynical-geoff/SKILL.md)** — A structured intellectual adversary. Steel-mans your argument, surfaces hidden assumptions, runs a pre-mortem, and delivers a brutally honest verdict. Activate when you want your idea genuinely stress-tested, not validated.

- **[Anti-Sycophancy](./thinking/anti-sycophancy/SKILL.md)** — Forces truth-seeking over agreement. Internally reframes affirmation-seeking input as neutral questions before responding, dramatically reducing the tendency to tell you what you want to hear. Based on arXiv:2602.23971.

---

## Writing

Skills for producing clean, human-sounding prose.

- **[Remove AI Slop](./writing/remove-ai-slop/SKILL.md)** — Rewrites AI-generated text into tight, natural prose. Two registers: formal (business docs, channel posts) and conversational (DMs, thought leadership). Strunk & White is the standard. Includes a tiered vocabulary replacement list, structural pattern detection, and a pre-delivery quick-check checklist.

---

## Operations

Skills for running accounts and daily workflow.

- **[Account PM Evening Briefing](./operations/account-pm-evening-briefing/SKILL.md)** — A scheduled agent that acts as a virtual project manager for a named enterprise account. Monitors Slack channels and team activity throughout the day, then delivers a concise, opinionated end-of-day briefing. Designed for field sales leaders managing complex, multi-workstream accounts.

- **[Workflow Audit](./operations/workflow-audit/SKILL.md)** — Reviews all AI assistant conversations from the last 24 hours, analyzes them for failures and inefficiencies, and publishes a structured report card. Designed to run nightly as a scheduled agent. The goal is continuous improvement of how the assistant serves the user.

---

## Structure

Each skill lives in its own folder with a single `SKILL.md` file:

```
skills/
├── thinking/
│   ├── cynical-geoff/SKILL.md
│   └── anti-sycophancy/SKILL.md
├── writing/
│   └── remove-ai-slop/SKILL.md
└── operations/
    ├── account-pm-evening-briefing/SKILL.md
    └── workflow-audit/SKILL.md
```

Each `SKILL.md` follows the same format: frontmatter (name, trigger, inputs), overview, workflow, output, and lessons learned.
