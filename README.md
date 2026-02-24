# Anamnesis

[![License: AGPL-3.0](https://img.shields.io/badge/License-AGPL--3.0-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)
[![Status: v0.1 Validated](https://img.shields.io/badge/Status-v0.1%20Validated-green.svg)](spec/CRYSTALLIZATION.md)
[![Built on D-ND](https://img.shields.io/badge/Built%20on-D--ND-purple.svg)](https://github.com/GrazianoGuiducci/MM_D-ND)

> Context persistence system for AI coders — surviving token window compaction and context variance.

## The Problem

AI coding assistants (Claude Code, OpenCode, Cursor, etc.) lose reasoning context when:

- **Token window compaction** — the conversation gets summarized, dropping causal chains
- **Session boundaries** — new sessions start with facts but not reasoning trajectories
- **Topic switching** — context variance within a session degrades coherence

Native systems capture **what** was happening (git state, file changes, facts). They don't capture **why** you were reasoning that way — the causal chains, explored-and-rejected alternatives, architectural decisions, and open forks.

## What Anamnesis Does

Anamnesis is a set of **patterns and templates** (not a library, not a framework) that any AI coder can read and adapt to its environment. It provides:

1. **Lagrangian Context Capture** — snapshot the dynamic state (not just position, but trajectory and momentum) before context loss events
2. **Reasoning Crystallization** — structured format for preserving causal chains, bifurcations, decisions, and insights during the session
3. **Re-injection** — automatic restoration of crystallized reasoning after compaction or session restart
4. **Navigation Map** — topological index ("for this question, look there") for rapid post-recovery orientation
5. **Feedback Loop** (Hephaestus) — evaluate post-recovery: did the crystallization actually work?

## How It Works

```
Session active
    │
    ├─ AI coder writes reasoning to active_reasoning.md (incremental)
    │   Format: Intent → Causal Chain → Bifurcations → Decisions → KLI → Vault
    │
    ├─ Pre-compaction hook captures mechanical state
    │   (git state, trajectory, momentum, attractor)
    │
    ╰─ COMPACTION / SESSION END
         │
         ╰─ Post-compaction hook re-injects:
              ├─ Lagrangian snapshot (mechanical)
              ├─ Reasoning chain (semantic)
              ╰─ Recovery instructions
```

## Quick Start

### 1. Read the spec

Start with [spec/CRYSTALLIZATION.md](spec/CRYSTALLIZATION.md) — it defines the pattern, the format, and the principles. Your AI coder reads this and understands what to build.

### 2. Copy the templates

```
templates/
├── hooks/
│   ├── pre_compact.sh      # Lagrangian capture (adapt paths)
│   ├── post_compact.sh     # Re-injection after compaction
│   └── safety_guard.sh     # Optional: pre-tool safety checks
├── active_reasoning.md      # Crystallization format (empty template)
└── context_map.md           # Navigation map structure
```

### 3. Configure your environment

Point your AI coding tool's hooks to the adapted scripts:

**Claude Code** (`.claude/settings.json`):
```json
{
  "hooks": {
    "PreCompact": [{ "command": "bash /path/to/hooks/pre_compact.sh" }],
    "SessionStart": [{ "command": "bash /path/to/hooks/post_compact.sh", "event": "compact" }]
  }
}
```

**Other tools**: adapt the hook mechanism to your tool's event system. The pattern is the same: capture before context loss, re-inject after.

### 4. Let your AI coder crystallize

Tell your AI coder: "Read the anamnesis spec and crystallize your reasoning during this session." It will write to `active_reasoning.md` incrementally.

## Repo Structure

```
anamnesis/
├── README.md                 # This file
├── spec/
│   └── CRYSTALLIZATION.md    # The pattern specification
├── templates/
│   ├── hooks/
│   │   ├── pre_compact.sh    # Lagrangian capture template
│   │   └── post_compact.sh   # Re-injection template
│   ├── active_reasoning.md   # Empty crystallization format
│   └── context_map.md        # Navigation map structure
└── examples/
    └── tm1_implementation.md # Real-world implementation reference
```

## Design Principles

These principles govern the system and should govern any adaptation:

- **Crystallize relationships, not isolated facts** — a decision without its alternatives is noise
- **Output becomes input** — what survives compaction must feed the next session (metabolic cycle)
- **Maximum coherence, minimum complexity** — the crystallization that survives is the one that carries the most meaning in the fewest tokens
- **During, not after** — crystallize while reasoning is active, not post-hoc
- **The pattern transfers, not the implementation** — bash scripts are one incarnation; the format and principles work in any runtime

## Tested With

- **Claude Code** (VSCode extension + CLI) — hooks system with `PreCompact` and `SessionStart:compact` events
- Token window compaction (manual and automatic)
- Multi-topic sessions with high context variance

## Origin

Anamnesis was developed as part of the [D-ND project](https://github.com/GrazianoGuiducci/MM_D-ND) — a framework for modeling dual/non-dual cognitive systems. The crystallization pattern was derived from the D-ND model's core axioms (Relational Invariance, Metabolic Cycle, Selective Integrity) and first implemented as a "precursor movement" for the THIA AI kernel.

The name comes from the Greek ἀνάμνησις — the recollection of knowledge that the soul already possesses. In this context: the recovery of reasoning patterns that existed before context loss.

## License

AGPL-3.0 — see [LICENSE](LICENSE) for details.
