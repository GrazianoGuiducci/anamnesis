# Anamnesis

## Your AI coder forgets why. We fix that.

Every time your AI coding assistant hits the token limit, it compresses the conversation. Facts survive. **Reasoning doesn't.**

Your AI remembers *what* file it edited. It forgets *why* it chose that approach over three alternatives it explored and rejected. It forgets the architectural decision you made together 40 minutes ago. It forgets the insight that was about to connect two problems.

**Anamnesis** is a context persistence system that captures the reasoning trajectory — not just the position — so your AI coder can resume where it left off, not where the summary thinks it was.

---

## The Problem

| What native systems save | What gets lost |
|--------------------------|----------------|
| File changes, git state | Why those changes were made |
| Summary of conversation | Causal chains (A→B→C becomes just A) |
| Current task description | Alternatives explored and rejected |
| Facts and decisions | The reasoning behind decisions |

**Cost**: 10-30 minutes of re-alignment every time context compacts. On complex projects, this happens multiple times per session.

---

## How It Works

### 1. Crystallization (during session)

Your AI coder writes structured reasoning snapshots to a file — not a brain dump, but a precise format:

- **Intent**: what's the goal right now
- **Causal Chain**: the sequence of reasoning steps
- **Bifurcations**: alternatives explored and why they were rejected
- **Decisions**: what was decided and why
- **Insights**: atomic knowledge that emerged
- **Vault**: items deferred for later

### 2. Lagrangian Capture (before compaction)

A hook automatically captures the dynamic state — not just where you are, but your trajectory and momentum:

- Git state across all repos
- Which file has the most gravitational pull (attractor)
- How long since last commit (momentum: active-flow / warm / cold)
- Direction of recent work (trajectory: last 3 commits)

### 3. Re-injection (after compaction)

When context is restored, the system automatically injects both the mechanical state and the reasoning chain. Your AI coder reads it and resumes — with the "why", not just the "what".

### 4. Feedback Loop

After recovery, evaluate: did it work? What was missing? What was noise? This closes the loop and improves the next crystallization.

---

## What You Get

- **Hook templates** for Claude Code (adaptable to any AI coding tool)
- **Crystallization format** — the CCCA-lite spec for structured reasoning capture
- **Navigation map** — topological index for rapid post-recovery orientation
- **Real-world example** — tested implementation with validation results
- **The pattern specification** — principles that govern any adaptation

---

## Results

Tested on a multi-repo Node.js AI project with Claude Code:

- **9-step causal chain** survived compaction intact
- **3 rejected alternatives** preserved with full reasoning
- **5 session insights** recovered and reusable
- **Recovery time**: ~2 minutes vs ~10 minutes without Anamnesis

---

## Quick Start

```bash
git clone https://github.com/GrazianoGuiducci/anamnesis.git
```

Read `spec/CRYSTALLIZATION.md`. Copy the templates. Adapt the paths. Tell your AI coder to crystallize.

Or: **let us set it up for you.**

---

## Services

### Setup
We configure Anamnesis for your project, your team, your tools. Hooks adapted, memory structured, safety guards installed.

### Training
Half-day workshop: how to use AI coders effectively on complex projects. Hooks, memory, safety, multi-developer coordination.

### Enterprise
Multi-environment orchestration, custom integrations (CI/CD, issue trackers, communication tools), ongoing support.

**Contact**: [info@d-nd.com](mailto:info@d-nd.com)

---

## Built on D-ND

Anamnesis is not a hack — it's the application of a coherent cognitive framework.

The [D-ND model](https://d-nd.com) provides the theoretical foundation: three irreducible axioms that govern how information survives transformation. Anyone can write shell scripts. The framework that explains *why* they work — and systematically generates new tools from the same principles — is what makes this different.

[Learn more about D-ND →](https://d-nd.com)

---

## Open Source

Anamnesis is AGPL-3.0 licensed. The patterns are free. The implementation is yours to adapt.

What we sell is not the code — it's the expertise to make it work for your specific context, and the ongoing evolution of the system.

[GitHub →](https://github.com/GrazianoGuiducci/anamnesis)
