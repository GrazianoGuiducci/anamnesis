#!/bin/bash
# ============================================================================
# ANAMNESIS — Context Re-injection (PostCompact Hook)
# ============================================================================
# Fires on SessionStart AFTER compaction.
# Everything printed to stdout gets injected into the AI's context.
#
# ADAPT: Change PROJECT_DIR to match your setup.
# ============================================================================

# ====== ADAPT THIS ======
PROJECT_DIR="/path/to/your/project"
# ==========================

CONTEXT_FILE="$PROJECT_DIR/.claude/hooks/active_context.md"
REASONING_FILE="$PROJECT_DIR/.claude/hooks/active_reasoning.md"

if [ -f "$CONTEXT_FILE" ]; then
    echo "=== LAGRANGIAN CONTEXT RESTORED ==="
    echo ""
    while IFS= read -r line; do
        echo "$line"
    done < "$CONTEXT_FILE"
    echo ""
    echo "=== END LAGRANGIAN CONTEXT ==="
    echo ""

    # --- Reasoning Chain Re-injection ---
    if [ -f "$REASONING_FILE" ]; then
        echo "=== REASONING CHAIN (Anamnesis Crystallization) ==="
        echo ""
        while IFS= read -r line; do
            echo "$line"
        done < "$REASONING_FILE"
        echo ""
        echo "=== END REASONING CHAIN ==="
        echo ""
    fi

    echo "IMPORTANT: Context was compacted. The snapshot above was captured"
    echo "BEFORE compaction. Resume by checking:"
    echo "  1. Uncommitted changes (git diff)"
    echo "  2. Todo list for in-progress tasks"
    echo "  3. active_reasoning.md for reasoning chains and insights"
    echo "  4. After recovery, evaluate: was this crystallization sufficient? (Hephaestus feedback)"
else
    echo "=== POST-COMPACTION: No pre-compact snapshot found ==="
    echo "Read your persistent memory files for context."
fi

exit 0
