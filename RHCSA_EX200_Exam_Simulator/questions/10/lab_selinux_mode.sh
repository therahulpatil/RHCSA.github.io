#!/bin/bash
# Objective 10: Manage security
# LAB: Set Enforcing and Permissive Modes for SELinux

# This is a LAB exercise
IS_LAB=true
LAB_ID="selinux_mode"

QUESTION="Configure SELinux mode at runtime and persistently across reboots"

# Lab configuration
LAB_TASK_COUNT=2

# =============================================================================
# TASK DEFINITIONS - Each task has question, hint, and command(s)
# =============================================================================

# Task 1
TASK_1_QUESTION="Set the current runtime SELinux mode to Enforcing"
TASK_1_HINT="Use setenforce 1 or setenforce Enforcing"
TASK_1_COMMAND_1="setenforce 1"

# Task 2
TASK_2_QUESTION="Configure SELINUX=enforcing persistently in /etc/selinux/config"
TASK_2_HINT="Edit /etc/selinux/config so the SELINUX= directive is set to enforcing"
TASK_2_COMMAND_1="sed -i 's/^SELINUX=.*/SELINUX=enforcing/' /etc/selinux/config"


# Auto-generate HINT from commands
HINT=$(_build_hint)

# =============================================================================
# LAB IMPLEMENTATION
# =============================================================================

# Prepare the lab environment
prepare_lab() {
    echo -e "  ${DIM}• Setting initial permissive state for testing...${RESET}"
    setenforce 0 2>/dev/null
    if [[ -f /etc/selinux/config ]]; then
        sed -i 's/^SELINUX=.*/SELINUX=permissive/' /etc/selinux/config 2>/dev/null
    fi
    sleep 0.3
}

# Check task completion - sets TASK_STATUS array
check_tasks() {
    # Task 0: Check current runtime mode is Enforcing
    local current_mode
    current_mode=$(getenforce 2>/dev/null)
    if [[ "$current_mode" == "Enforcing" ]]; then
        TASK_STATUS[0]="true"
    else
        TASK_STATUS[0]="false"
    fi

    # Task 1: Check persistent configuration in /etc/selinux/config
    if [[ -f /etc/selinux/config ]] && grep -qE '^\s*SELINUX=enforcing' /etc/selinux/config 2>/dev/null; then
        TASK_STATUS[1]="true"
    else
        TASK_STATUS[1]="false"
    fi
}

# Cleanup the lab environment before exit
cleanup_lab() {
    echo -e "  ${DIM}• Cleaning up lab environment...${RESET}"
    setenforce 1 2>/dev/null
    if [[ -f /etc/selinux/config ]]; then
        sed -i 's/^SELINUX=.*/SELINUX=enforcing/' /etc/selinux/config 2>/dev/null
    fi
    echo -e "  ${GREEN}✓ Lab environment cleaned up${RESET}"
    sleep 1
}
