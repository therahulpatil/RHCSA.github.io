#!/bin/bash
# Objective 3: Create simple shell scripts
# LAB: Use Looping Constructs to Process Arguments

# This is a LAB exercise
IS_LAB=true
LAB_ID="script_loops"

QUESTION="Create a shell script that uses a for loop to process command-line arguments"

# Lab configuration
LAB_TASK_COUNT=2

# =============================================================================
# TASK DEFINITIONS - Each task has question, hint, and command(s)
# =============================================================================

# Task 1
TASK_1_QUESTION="Create /usr/local/bin/create_dirs.sh: iterates over \"\$@\" and creates each directory under /tmp/rhcsa_batch/ using a for loop"
TASK_1_HINT="Use for item in \"\$@\"; do mkdir -p \"/tmp/rhcsa_batch/\$item\"; done"
TASK_1_COMMAND_1="cat << 'EOF' > /usr/local/bin/create_dirs.sh
#!/bin/bash
mkdir -p /tmp/rhcsa_batch
for item in \"\$@\"; do
    mkdir -p \"/tmp/rhcsa_batch/\$item\"
done
EOF"

# Task 2
TASK_2_QUESTION="Make /usr/local/bin/create_dirs.sh executable"
TASK_2_HINT="Use chmod +x to give execute permissions"
TASK_2_COMMAND_1="chmod +x /usr/local/bin/create_dirs.sh"


# Auto-generate HINT from commands
HINT=$(_build_hint)

# =============================================================================
# LAB IMPLEMENTATION
# =============================================================================

# Prepare the lab environment
prepare_lab() {
    echo -e "  ${DIM}• Resetting test directories and script...${RESET}"
    rm -f /usr/local/bin/create_dirs.sh 2>/dev/null
    rm -rf /tmp/rhcsa_batch 2>/dev/null
    sleep 0.3
}

# Check task completion - sets TASK_STATUS array
check_tasks() {
    local script="/usr/local/bin/create_dirs.sh"

    # Task 0: Check if script processes arguments and creates directories
    if [[ -f "$script" ]]; then
        rm -rf /tmp/rhcsa_batch/alpha /tmp/rhcsa_batch/beta 2>/dev/null
        bash "$script" alpha beta 2>/dev/null
        if [[ -d "/tmp/rhcsa_batch/alpha" ]] && [[ -d "/tmp/rhcsa_batch/beta" ]]; then
            TASK_STATUS[0]="true"
        else
            TASK_STATUS[0]="false"
        fi
    else
        TASK_STATUS[0]="false"
    fi

    # Task 1: Check if script is executable
    if [[ -x "$script" ]]; then
        TASK_STATUS[1]="true"
    else
        TASK_STATUS[1]="false"
    fi
}

# Cleanup the lab environment before exit
cleanup_lab() {
    echo -e "  ${DIM}• Cleaning up lab environment...${RESET}"
    rm -f /usr/local/bin/create_dirs.sh 2>/dev/null
    rm -rf /tmp/rhcsa_batch 2>/dev/null
    echo -e "  ${GREEN}✓ Lab environment cleaned up${RESET}"
    sleep 1
}
