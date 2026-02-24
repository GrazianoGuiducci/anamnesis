#!/bin/bash
# ============================================================================
# ANAMNESIS — Lagrangian Context Capture (PreCompact Hook)
# ============================================================================
# Fires BEFORE compaction. Captures the dynamic state of your project.
# Writes to active_context.md, which post_compact.sh will re-inject.
#
# ADAPT: Change PROJECT_DIR and REPOS to match your setup.
# ============================================================================

# Consume stdin (some tools send JSON on hook trigger)
read -t 1 INPUT_LINE 2>/dev/null || INPUT_LINE=""

# ====== ADAPT THESE ======
PROJECT_DIR="/path/to/your/project"
REPOS=("repo1" "repo2")  # Git repos to monitor
# ==========================

CONTEXT_FILE="$PROJECT_DIR/.claude/hooks/active_context.md"
NOW=$(date '+%Y-%m-%d %H:%M' 2>/dev/null || echo "unknown")

# --- Gather git state for a repo ---
repo_state() {
    local REPO_NAME=$1
    local REPO_PATH=$2

    if [ ! -d "$REPO_PATH/.git" ]; then
        return
    fi

    local BRANCH=$(git -C "$REPO_PATH" branch --show-current 2>/dev/null || echo "unknown")
    local LAST_COMMIT=$(git -C "$REPO_PATH" log --oneline -1 2>/dev/null || echo "none")
    local DIRTY=$(git -C "$REPO_PATH" diff --name-only 2>/dev/null)
    local UNTRACKED=$(git -C "$REPO_PATH" ls-files --others --exclude-standard 2>/dev/null)

    echo "### $REPO_NAME ($BRANCH)" >> "$CONTEXT_FILE"
    echo "- Last commit: \`$LAST_COMMIT\`" >> "$CONTEXT_FILE"

    if [ -n "$DIRTY" ]; then
        echo "- **Uncommitted:**" >> "$CONTEXT_FILE"
        echo "$DIRTY" | head -10 | while IFS= read -r f; do echo "  - \`$f\`" >> "$CONTEXT_FILE"; done
    fi
    if [ -n "$UNTRACKED" ]; then
        echo "- **Untracked:**" >> "$CONTEXT_FILE"
        echo "$UNTRACKED" | head -10 | while IFS= read -r f; do echo "  - \`$f\`" >> "$CONTEXT_FILE"; done
    fi
    echo "" >> "$CONTEXT_FILE"
}

# --- Detect mode ---
HAS_DIRTY=""
for R in "${REPOS[@]}"; do
    RPATH="$PROJECT_DIR/$R"
    if [ -d "$RPATH/.git" ]; then
        D=$(git -C "$RPATH" diff --name-only 2>/dev/null)
        [ -n "$D" ] && HAS_DIRTY="yes"
    fi
done
MODE="${HAS_DIRTY:+FILE_EDIT}"
MODE="${MODE:-GENERAL}"

# --- Field state: attractor + trajectory + momentum ---
# Adapt PRIMARY_REPO to your main development repo
PRIMARY_REPO="$PROJECT_DIR/${REPOS[0]}"
ATTRACTOR=""
TRAJECTORY=""
MOMENTUM=""

if [ -d "$PRIMARY_REPO/.git" ]; then
    ATTRACTOR=$(git -C "$PRIMARY_REPO" diff --name-only 2>/dev/null | head -1)
    [ -z "$ATTRACTOR" ] && ATTRACTOR=$(git -C "$PRIMARY_REPO" diff --name-only HEAD~1 2>/dev/null | head -1)

    TRAJECTORY=$(git -C "$PRIMARY_REPO" log --oneline -3 2>/dev/null)

    LAST_TS=$(git -C "$PRIMARY_REPO" log -1 --format=%ct 2>/dev/null)
    if [ -n "$LAST_TS" ]; then
        NOW_TS=$(date +%s 2>/dev/null)
        ELAPSED=$(( (NOW_TS - LAST_TS) / 60 ))
        if [ "$ELAPSED" -lt 30 ] 2>/dev/null; then
            MOMENTUM="active-flow (${ELAPSED}min)"
        elif [ "$ELAPSED" -lt 120 ] 2>/dev/null; then
            MOMENTUM="warm (${ELAPSED}min)"
        else
            MOMENTUM="cold (${ELAPSED}min)"
        fi
    fi
fi

# --- Write context file ---
cat > "$CONTEXT_FILE" << EOF
# Active Context — Lagrangian Snapshot
> Pre-compact capture at $NOW | Mode: $MODE

## Field State
- **Attractor**: \`${ATTRACTOR:-none}\`
- **Momentum**: ${MOMENTUM:-unknown}
- **Trajectory** (last 3 commits):
EOF

echo "$TRAJECTORY" | while IFS= read -r line; do
    echo "  - \`$line\`" >> "$CONTEXT_FILE"
done
echo "" >> "$CONTEXT_FILE"

echo "## Repository State" >> "$CONTEXT_FILE"
for R in "${REPOS[@]}"; do
    repo_state "$R" "$PROJECT_DIR/$R"
done

cat >> "$CONTEXT_FILE" << 'EOF'
## Recovery Instructions
- Read your persistent memory file for project context
- Check active_reasoning.md for reasoning chains and KLI
- Check the todo list for in-progress tasks
- If files have uncommitted changes, run `git diff` before proceeding
EOF

echo "[ANAMNESIS:PRE_COMPACT] Context saved (mode=$MODE)" >&2
