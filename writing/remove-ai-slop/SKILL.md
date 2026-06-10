---
name: remove-ai-slop
display_name: Remove AI Slop
icon: "🧹"
description: >
  Rewrite AI-generated text into tight, natural prose. Two registers:
  formal (business docs, channel posts) and conversational (DMs, thought
  leadership). Strips AI vocabulary, structural clichés, and filler.
  Replaces them with active voice, specific detail, and real personality.
  Strunk & White is the standard.
trigger: remove ai slop
inputs:
  - name: text
    description: "The text to humanize and clean of AI patterns"
    type: string
    required: true
---

# Remove AI Slop

## Overview

Rewrite AI-generated text into tight, natural prose using two registers (formal and conversational), Strunk & White principles, tiered vocabulary replacement, structural pattern detection, and voice targeting. The goal is writing that sounds like a specific person with an opinion, not a language model.

Make writing sound like a specific person wrote it, not like it was extruded from a language model. The test is simple: read it aloud. Does it sound like someone with an opinion and experience? Good. Does it sound like a press release or a textbook? Rewrite it.

This skill is not about passing AI detection tools. It is about writing tight, clear, natural prose that respects the reader's time.

## Standard

Strunk & White's *The Elements of Style* is the prose standard:
- Active voice
- Omit needless words
- One idea per sentence
- Concrete nouns
- Strong verbs
- No nominalizations
- Keep sentences short
- Remove redundancy

Always prefer paragraphs to bullets unless the content is genuinely a list (steps, specs, enumerated items).

## Two Registers

Detect from context, or ask.

### Register B: Formal (business docs, channel posts, strategy writing)

Target voice: a senior leader who earned authority in the field and doesn't pad. Sentences are short and declarative. Structure is aggressive (numbered items, bold labels, clear sections), but the prose within each section is tight and opinionated.

Characteristics:
- BLUF (bottom line up front). The conclusion comes first.
- Numbered items use `1/` `2/` `3/` format in body text.
- Every section earns its space. If a paragraph doesn't advance the argument, cut it.
- One editorial comment per section is allowed. It earns its place by being specific.
- Tables are crisp: metric, value, notes. No decorative formatting.
- Asks are labeled `[ASK]` in bold. Never buried.

### Register C: Conversational (DMs, thought leadership, LinkedIn, peer replies)

Target voice: a person talking to you after a conference. First person, direct address, authority from experience. Warm but never soft. Humor is dry. Anecdotes are specific and brief.

Characteristics:
- Jump straight in. No preamble. No "Hi, hope you're doing well."
- One to three sentences is fine for quick replies. Not everything needs a paragraph.
- First person ("I keep seeing," "In my experience") when it earns its place.
- Self-deprecating humor is allowed sparingly.
- Ends with action or stops when the thought is done. No warm-fuzzy closings.

## Core Rules

### 1. Em Dashes: Zero Tolerance

Not one. The fix is always a period, a comma, or two sentences. This applies to both the Unicode em dash (—) and the double-hyphen substitute (--).

Wrong: "The results were clear — customers wanted faster delivery."
Right: "The results were clear. Customers wanted faster delivery."

Wrong: "SAP announced new agents — five in total — across procurement and finance."
Right: "SAP announced five new agents across procurement and finance."

### 2. Cut Filler Phrases

Remove throat-clearing openers. State the content directly.

Kill these on sight:
- "Here's the thing:" / "Here's why [X]"
- "The uncomfortable truth is"
- "It turns out" / "The real [X] is"
- "Let me be clear" / "I'll be honest"
- "This matters because"
- "Make no mistake"
- "Let that sink in." / "Full stop." / "Period."

Kill emphasis crutches: "really," "just," "literally," "genuinely," "honestly," "simply," "actually," "deeply," "truly," "fundamentally," "inherently," "inevitably," "interestingly," "importantly," "crucially."

Kill time-wasting phrases:
- "At its core" → cut, state the thing
- "In today's [X]" → cut or state specific context
- "It's worth noting" → state the fact
- "At the end of the day" → cut
- "When it comes to" → talk about the thing
- "In a world where" → cut
- "In order to" → "to"
- "Due to the fact that" → "because"
- "Has the ability to" → "can"

### 3. Break Formulaic Structures

**Binary contrasts.** These create false drama. State the point directly.

- "Not because X. Because Y." → State Y.
- "[X] isn't the problem. [Y] is." → "The problem is Y."
- "It's not about X. It's about Y." → State Y.
- "not just X but also Y" → State both directly.

**Dramatic fragmentation.** "[Noun]. That's it. That's the [thing]." → Complete sentences.

**Rhetorical setups.** "What if [reframe]?" "Here's what I mean:" "Think about it:" → Make the point.

**Rule of three.** Vary groupings. Two items, four items, or a full sentence instead of triads. Max one "adjective, adjective, and adjective" pattern per piece.

### 4. Active Voice. Name the Actor.

Every sentence needs a human subject doing something. No passive constructions. No inanimate objects performing human actions.

Wrong: "The decision was made to restructure." → "Stephanie restructured the team."
Wrong: "The complaint becomes a fix." → "The team fixed it that week."
Wrong: "The data tells us" → "We looked at the data and found"

If no specific person fits, use "you" or "we" to put the reader in the seat.

### 5. Be Specific

No vague declaratives. If a sentence says something is important/significant/structural without naming the specific thing, cut it or replace it with the specific thing.

Wrong: "The implications are significant."
Right: "Win rates dropped from 31% to 25% in one year."

Wrong: "The reasons are structural."
Right: "Three teams own the same customer with no shared backlog."

### 6. Vary Rhythm

Mix sentence lengths. Short sentences carry weight. Longer ones explain. Two items beat three. End paragraphs differently each time.

### 7. Trust the Reader

State facts directly. Skip softening, justification, and hand-holding. No "Perhaps," no "It's important to note that," no "To be clear." The reader is an adult.

### 8. No Quotables

If a sentence sounds like it belongs on a motivational poster or a LinkedIn carousel, rewrite it. Good writing earns attention through specificity, not through performative punchiness.

### 9. Context-Sensitive Flagging

Framing phrases, rhetorical questions, "I keep seeing" — these are acceptable when followed within two sentences by a specific example, data point, or concrete observation. If followed by vague abstraction, kill them.

Acceptable: "I keep seeing the same thing across accounts that adopted this early. Their teams stopped fighting over territory and started co-selling."

Not acceptable: "I keep seeing the same thing. The implications are significant and the opportunities are vast."

## Vocabulary: Tier 1 (Always Replace)

These words appear 5–20x more often in AI text than human text. Replace on sight.

| Kill | Use instead |
|------|-------------|
| delve / delve into | look at, dig into |
| landscape (metaphor) | field, space, industry |
| tapestry | describe the actual complexity |
| realm | area, field |
| paradigm | model, approach |
| embark | start, begin |
| beacon | rewrite entirely |
| testament to | shows, proves |
| robust | strong, reliable |
| comprehensive | thorough, complete |
| cutting-edge | latest, newest |
| leverage (verb) | use |
| pivotal | important, key |
| underscores | shows, highlights |
| meticulous | careful, detailed |
| seamless | smooth, easy |
| game-changer | describe what changed |
| utilize | use |
| vibrant | describe what makes it active |
| thriving | growing, active (cite a number) |
| showcasing | showing (or cut the clause) |
| deep dive | look at, examine |
| unpack | explain, break down |
| holistic | complete, full |
| actionable | practical, useful |
| impactful | effective (or describe the impact) |
| learnings | lessons, findings |
| thought leader | expert (describe their contribution) |
| best practices | what works, proven methods |
| synergy | describe the actual combined effect |
| interplay | relationship, connection |
| nestled | is located, sits |
| bustling | busy, active |
| ever-evolving | changing (describe how) |
| daunting | hard, difficult |
| endeavor | effort, try |
| commence | start |
| ascertain | find out, learn |
| serves as | is |
| boasts | has |
| features (verb) | has, includes |

## Vocabulary: Tier 2 (Flag When 2+ in Same Paragraph)

These words are legitimate alone. Two or more in one paragraph signals AI. Rewrite the paragraph.

harness, navigate, foster, elevate, unleash, streamline, empower, bolster, spearhead, resonate, revolutionize, facilitate, underpin, nuanced, crucial, multifaceted, ecosystem (metaphor), myriad, plethora, catalyze, reimagine, galvanize, augment, cultivate, illuminate, elucidate, paradigm-shifting, transformative, cornerstone, paramount, poised, burgeoning, nascent, quintessential, overarching

## Vocabulary: Tier 3 (Flag at High Density Only)

Normal words that AI overuses. Flag only when the text is saturated with them.

significant, innovative, effective, dynamic, scalable, compelling, unprecedented, exceptional, remarkable, sophisticated, instrumental, world-class, state-of-the-art

When flagged: replace some instances with specifics (numbers, comparisons, examples).

## Structural Patterns to Fix

**Significance Inflation**: "Marking a pivotal moment in the evolution of..." State what happened. Let the reader judge significance.

**Copula Avoidance**: AI substitutes fancy verbs for "is" and "has": "serves as," "features," "boasts," "represents." Default to "is" or "has" unless a more specific verb genuinely adds meaning.

**Synonym Cycling**: AI rotates synonyms to avoid repetition: "developers... engineers... practitioners... builders" in one paragraph. Repeat the clearest word.

**Promotional Language**: Tourism-brochure prose: "a vibrant hub of innovation," "a thriving ecosystem." Replace with plain description. If you wouldn't say it in conversation, cut it.

**Generic Conclusions**: "The future looks bright." "Only time will tell." Cut them. If the piece needs a closing thought, make it specific to the argument.

**Chatbot Artifacts**: "I hope this helps!" "Certainly!" "Great question!" "Feel free to reach out." Remove entirely.

**"Let's" Constructions**: "Let's explore," "Let's dive in." Filler that delays the point. Start with the point.

**Sycophantic Openings**: Never open with praise for the question or the person. Jump to the content.

**False Concession**: "While X is impressive, Y remains a challenge." Both halves are vague. Name the specific impressive thing and the specific challenge, or pick a side.

## Quick Checks (Run Before Delivering)

Before delivering prose, verify:

- Any em dashes? Kill them. Period or comma.
- Any adverbs (-ly words)? Kill them.
- Any passive voice? Find the actor, make them the subject.
- Inanimate thing doing a human verb? Name the person.
- Any "not X, it's Y" contrast? State Y directly.
- Any sentence announcing importance without naming the specific thing? Cut or replace.
- Three consecutive sentences matching length? Break one.
- Any sycophantic opening ("Great question!" "Thanks for sharing!")? Cut to content.
- Any Tier 1 vocabulary? Replace.
- Two or more Tier 2 words in one paragraph? Rewrite.
- Read it aloud. Does it sound like a person with a point? Good. Does it sound like a press release? Rewrite.

## Workflow

1. **Detect register.** Is this formal (Register B) or conversational (Register C)? Ask if unclear.
2. **Strip.** Remove all AI vocabulary, filler phrases, structural clichés, and formatting artifacts.
3. **Rebuild.** Rewrite stripped sections using the target register's voice characteristics.
4. **Verify.** Run quick checks. Read aloud.
5. **Deliver.** Return the rewritten text with a brief note on what changed and why (3–5 points, not a full audit).
