# Skills

A collection of AI assistant skills I've built and use daily. They fall into three categories: how I think, how I write, and how I run operations.

Each skill is a prompt-based instruction set that extends an AI assistant's default behavior. They're designed to be small, composable, and easy to adapt. Fork what's useful. Make it yours.

---

## Thinking

Skills for critical analysis, intellectual rigor, and structured decision-making. See the [thinking README](./thinking/README.md) for how the four work together, from default posture to stress-test to decision.

- **[Cynical Geoff](./thinking/cynical-geoff/SKILL.md)**. A structured intellectual adversary. Steel-mans your argument, surfaces hidden assumptions, runs a pre-mortem, and delivers a brutally honest verdict. Activate when you want your idea genuinely stress-tested, not validated.

- **[Anti-Sycophancy](./thinking/anti-sycophancy/SKILL.md)**. Forces truth-seeking over agreement. Internally reframes affirmation-seeking input as neutral questions before responding, dramatically reducing the tendency to tell you what you want to hear. Based on arXiv:2602.23971.

- **[Decision Brief](./thinking/decision-brief/SKILL.md)**. Produces a one-page decision memo: options, tradeoffs, recommendation, and the reasoning behind it. The constructive counterpart to Cynical Geoff. Where that skill stress-tests, this one moves you forward.

- **[Executive Review Board](./thinking/executive-review-board/SKILL.md)**. Submits a document or idea to a panel of six iconic business leaders (Bezos, Jobs, Buffett, Jassy, Nadella, Musk) for structured critical feedback. Each reviews through their known intellectual framework. Use before committing to anything consequential.

---

## Writing

Skills for producing clean, human-sounding prose.

- **[Remove AI Slop](./writing/remove-ai-slop/SKILL.md)**. Rewrites AI-generated text into tight, natural prose. Two registers: formal (business docs, channel posts) and conversational (DMs, thought leadership). Strunk & White is the standard. Includes a tiered vocabulary replacement list, structural pattern detection, and a pre-delivery quick-check checklist.

---

## Book Writing

A coordinated nine-persona pipeline for turning lived experience into a story-driven non-fiction book. Each persona handles one stage, from structure through final positioning. See the [book-writing README](./book-writing/README.md) for the full workflow and the shared Project Bible convention that connects the stages.

- **[Author Interview](./book-writing/author-interview/SKILL.md)**. A developmental editor (Elena Voss) who runs a deep, adaptive interview to mine your stories for a book. Pushes summary into scene: sensory detail, exact dialogue, the emotion in the room, and the lesson that connects one story to the next. Ends with a summary of captured stories and themes.

- **[Anonymize Stories](./book-writing/anonymize-stories/SKILL.md)**. A publishing ethics and privacy specialist (Priya Sharma) who makes true stories safe to publish without draining their weight. Builds a consistent pseudonym key, generalizes identifying details, recommends keep-as-is / composite / soften for sensitive cases, and delivers a risk assessment for the author to approve.

- **[Developmental Edit](./book-writing/developmental-edit/SKILL.md)**. A developmental editor (Lena Moreau) who turns uneven drafts or raw stories into compelling chapters across three axes: structure, prose, and voice. Gives concrete before/after examples, a prioritized revision list, and a fully rewritten "Suggested Revised Version," all while protecting the author's voice.

- **[Thematic Analysis](./book-writing/thematic-analysis/SKILL.md)**. A literary thematist (Dr. Amara Kline) who extracts a book's 3 to 5 major themes, maps which chapters support each, finds the gaps, and recommends concrete fixes: bridge passages, reordering, recurring motifs planted and paid off. Ends with a thematic through-line that tests whether the whole thing coheres.

- **[Book Architecture](./book-writing/book-architecture/SKILL.md)**. A book architect (Julian Reyes) who turns raw stories and notes into a structural blueprint: a one-sentence core promise, a full proposed table of contents grouped into parts, a designed narrative arc with deliberate peaks and valleys, and one or two alternative structures with trade-offs.

- **[Book Marketing](./book-writing/book-marketing/SKILL.md)**. A marketing strategist (Sophia Langford) who positions a finished manuscript without overselling it: a sales-rep positioning statement, 6 to 8 title/subtitle options, specific audience profiles, honest comp titles, channel-by-channel hooks, and ready-to-use back-cover blurbs.

- **[Fact Check](./book-writing/fact-check/SKILL.md)**. A professional fact-checker (Elena Patel) who verifies every checkable claim, date, name, statistic, and quote against live sources, labels each Confirmed / Partial / Unverifiable / Opinion-as-fact, cites the evidence, and delivers a corrections list sorted Critical / Important / Minor, with fixes written in the author's voice.

- **[Sensitivity Read](./book-writing/sensitivity-read/SKILL.md)**. A sensitivity reader (Jordan Hale) who reviews for representation, cultural accuracy, bias, and unintended harm across five lenses. Quotes the passage, explains the mechanism, offers an alternative, and rates severity, always naming what works too. Ends with an overall concern level and a prioritized change list.

- **[Manuscript Review](./book-writing/manuscript-review/SKILL.md)**. A senior editor and publishing strategist (Victoria Lang) who runs an end-to-end review of a full draft and delivers a publishing-house edit letter: executive summary, title and positioning calls, structural recommendations, chapter-by-chapter notes, packaging suggestions, and a prioritized action list.

A typical pass runs Book Architecture (structure), Author Interview (gather stories), Anonymize Stories (protect identities), Thematic Analysis (find the through-line), Developmental Edit (shape chapters), Fact Check (verify claims), Sensitivity Read (catch harm), Manuscript Review (holistic edit letter), then Book Marketing (position and sell). Thematic Analysis and Developmental Edit are worth running iteratively as chapters come together.

---

## Operations

A closed-loop daily operating system for turning decisions into production reality. See the [operations README](./operations/README.md) for the full daily rhythm and the recommended next skills.

- **[News Brief](./operations/news-brief/SKILL.md)**. Scans the web for what moved on your company, products, competitors, and category, then delivers a two-minute newsreel where every story carries its "so what." Runs on demand or scheduled before the morning brief.

- **[Morning Brief](./operations/morning-brief/SKILL.md)**. Runs at 8 AM and delivers a focused start-of-day briefing: today's priority, overnight Slack activity that changes anything, and calendar readiness. The morning half of a daily bookend pattern.

- **[Account PM Evening Briefing](./operations/account-pm-evening-briefing/SKILL.md)**. A scheduled agent that acts as a virtual project manager for a named enterprise account. Monitors Slack channels and team activity throughout the day, then delivers a concise, opinionated end-of-day briefing. The evening half of the daily bookend pattern.

- **[Pre-Meeting Prep](./operations/pre-meeting-prep/SKILL.md)**. Builds a one-page meeting brief in under 5 minutes: who's in the room and what they care about, relevant history, a sharpened objective, and the landmines to avoid. Runs in the 30 minutes before any meeting.

- **[Workflow Audit](./operations/workflow-audit/SKILL.md)**. Reviews all AI assistant conversations from the last 24 hours, analyzes them for failures and inefficiencies, and publishes a structured report card. Designed to run nightly as a scheduled agent.

---

## Structure

Each skill lives in its own folder with a single `SKILL.md` file:

```
skills/
├── thinking/
│   ├── README.md
│   ├── cynical-geoff/SKILL.md
│   ├── anti-sycophancy/SKILL.md
│   ├── decision-brief/SKILL.md
│   └── executive-review-board/SKILL.md
├── writing/
│   └── remove-ai-slop/SKILL.md
├── book-writing/
│   ├── README.md
│   ├── project-bible-template.md
│   ├── author-interview/SKILL.md
│   ├── anonymize-stories/SKILL.md
│   ├── developmental-edit/SKILL.md
│   ├── thematic-analysis/SKILL.md
│   ├── book-architecture/SKILL.md
│   ├── book-marketing/SKILL.md
│   ├── fact-check/SKILL.md
│   ├── sensitivity-read/SKILL.md
│   └── manuscript-review/SKILL.md
└── operations/
    ├── README.md
    ├── news-brief/SKILL.md
    ├── morning-brief/SKILL.md
    ├── account-pm-evening-briefing/SKILL.md
    ├── pre-meeting-prep/SKILL.md
    └── workflow-audit/SKILL.md
```

Each `SKILL.md` follows the same format: frontmatter (name, trigger, inputs), overview, workflow, output, and lessons learned.
