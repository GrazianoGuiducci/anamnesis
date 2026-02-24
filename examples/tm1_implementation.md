# Example: TM1 Implementation

> Real-world implementation on a Windows workstation running Claude Code (VSCode extension)
> with a multi-repo Node.js AI project.

## Environment

- **OS**: Windows 11
- **AI Coder**: Claude Code (VSCode extension)
- **Shell**: Git Bash
- **Project**: Multi-repo (THIA kernel + EXAMINA tests + d-nd.com website)
- **Project root**: `C:\Users\metam\ANTI_G_Project`

## Hook Configuration

File: `.claude/settings.json` (in project root)

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash|Edit|Write",
        "command": "bash C:/Users/metam/ANTI_G_Project/.claude/hooks/safety_guard.sh"
      }
    ],
    "PreCompact": [
      {
        "command": "bash C:/Users/metam/ANTI_G_Project/.claude/hooks/pre_compact.sh"
      }
    ],
    "SessionStart": [
      {
        "command": "bash C:/Users/metam/ANTI_G_Project/.claude/hooks/system_awareness.sh"
      },
      {
        "command": "bash C:/Users/metam/ANTI_G_Project/.claude/hooks/post_compact.sh",
        "event": "compact"
      }
    ]
  }
}
```

## File Layout

```
ANTI_G_Project/
├── .claude/
│   ├── settings.json          # Hook configuration
│   └── hooks/
│       ├── pre_compact.sh     # Lagrangian capture (adapted from template)
│       ├── post_compact.sh    # Re-injection (adapted from template)
│       ├── system_awareness.sh # Session start: poll external systems
│       ├── safety_guard.sh    # Pre-tool safety checks
│       ├── active_context.md  # Output of pre_compact (mechanical state)
│       └── active_reasoning.md # Crystallization (written by AI during session)
├── memory/                     # Claude Code auto-memory directory
│   ├── MEMORY.md              # Persistent facts (auto-loaded)
│   ├── context_map.md         # Navigation map
│   ├── session_log.md         # Session narrative history
│   └── ...                    # Other topic-specific memory files
├── THIA/                      # Main repo (git)
├── EXAMINA/                   # Test system repo (git)
└── ...
```

## Adaptations from Template

1. **PROJECT_DIR** set to `C:/Users/metam/ANTI_G_Project` (forward slashes for bash on Windows)
2. **REPOS** expanded to monitor 3 repos: THIA, EXAMINA, d-nd_com
3. **System awareness hook** added: polls external systems (VPS health, inter-node messages) at session start — this is project-specific, not part of the anamnesis pattern
4. **Safety guard** added: checks for dangerous patterns before tool execution — also project-specific
5. **Context map** customized with 14 project-specific question→path mappings

## Validation Results (v0.1)

After manual compaction:

- **Causal chain**: 9-step chain survived intact
- **Bifurcations**: 3 rejected alternatives preserved with reasons
- **Architectural decisions**: all recovered
- **KLI**: 5 session insights readable and useful
- **Vault**: 4 dormant items reactivatable
- **Recovery time**: ~2 minutes to full operational alignment (vs ~10 min without)

### What Worked

The semantic channel (`active_reasoning.md`) provided the "why" that the native compaction summary didn't capture. The Lagrangian snapshot provided the "where" (git state, momentum). Together: enough to resume without re-exploring.

### What Needed Improvement

- `active_reasoning.md` was written once, not updated incrementally
- No energetic trigger (crystallization was manual)
- No formal recovery quality metric
