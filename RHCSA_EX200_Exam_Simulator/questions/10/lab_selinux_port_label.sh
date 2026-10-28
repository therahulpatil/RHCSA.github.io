#!/bin/bash
# Objective 10: Manage security
# LAB: Manage SELinux Port Labels

# This is a LAB exercise
IS_LAB=true
LAB_ID="selinux_port_label"

QUESTION="Add a custom network port to the SELinux HTTP port label"

# Lab configuration
LAB_TASK_COUNT=1

# =============================================================================
# TASK DEFINITIONS - Each task has question, hint, and command(s)
# =============================================================================

# Task 1
TASK_1_QUESTION="Assign TCP port 8088 to the SELinux type http_port_t"
TASK_1_HINT="Use semanage port -a -t http_port_t -p tcp 8088"
TASK_1_COMMAND_1="semanage port -a -t http_port_t -p tcp 8088"


# Auto-generate HINT from commands
HINT=$(_build_hint)

# =============================================================================
# LAB IMPLEMENTATION
# =============================================================================

# Prepare the lab environment
prepare_lab() {
    echo -e "  ${DIM}• Resetting port label if previously added...${RESET}"
    semanage port -d -t http_port_t -p tcp 8088 2>/dev/null
    sleep 0.3
}

# Check task completion - sets TASK_STATUS array
check_tasks() {
    # Task 0: Check if port 8088 is labeled as http_port_t
    if semanage port -l 2>/dev/null | grep -E '^http_port_t\b' | grep -qE '\b8088\b'; then
        TASK_STATUS[0]="true"
    else
        TASK_STATUS[0]="false"
    fi
}

# Cleanup the lab environment before exit
cleanup_lab() {
    echo -e "  ${DIM}• Cleaning up lab environment...${RESET}"
    semanage port -d -t http_port_t -p tcp 8088 2>/dev/null
    echo -e "  ${GREEN}✓ Lab environment cleaned up${RESET}"
    sleep 1
}
