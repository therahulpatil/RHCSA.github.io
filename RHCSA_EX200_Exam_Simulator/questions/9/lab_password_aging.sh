#!/bin/bash
# Objective 9: Manage users and groups
# LAB: Configure Password Aging Policies

# This is a LAB exercise
IS_LAB=true
LAB_ID="password_aging"

QUESTION="Configure password aging and expiration policies for a user account"

# Lab configuration
LAB_TASK_COUNT=1

# =============================================================================
# TASK DEFINITIONS - Each task has question, hint, and command(s)
# =============================================================================

# Task 1
TASK_1_QUESTION="Configure password aging for user bob: maximum 90 days, minimum 7 days, warning 14 days"
TASK_1_HINT="Use chage with -M 90 -m 7 -W 14 bob"
TASK_1_COMMAND_1="chage -M 90 -m 7 -W 14 bob"


# Auto-generate HINT from commands
HINT=$(_build_hint)

# =============================================================================
# LAB IMPLEMENTATION
# =============================================================================

# Prepare the lab environment
prepare_lab() {
    echo -e "  ${DIM}• Resetting user bob...${RESET}"
    userdel -r bob 2>/dev/null
    useradd bob 2>/dev/null
    sleep 0.3
}

# Check task completion - sets TASK_STATUS array
check_tasks() {
    # Task 0: Check password aging values for bob
    if id bob &>/dev/null; then
        local min_days max_days warn_days
        # Extract from /etc/shadow: username:password:lastchanged:min:max:warn:...
        min_days=$(getent shadow bob 2>/dev/null | cut -d: -f4)
        max_days=$(getent shadow bob 2>/dev/null | cut -d: -f5)
        warn_days=$(getent shadow bob 2>/dev/null | cut -d: -f6)

        if [[ "$min_days" == "7" ]] && [[ "$max_days" == "90" ]] && [[ "$warn_days" == "14" ]]; then
            TASK_STATUS[0]="true"
        else
            TASK_STATUS[0]="false"
        fi
    else
        TASK_STATUS[0]="false"
    fi
}

# Cleanup the lab environment before exit
cleanup_lab() {
    echo -e "  ${DIM}• Cleaning up lab environment...${RESET}"
    userdel -r bob 2>/dev/null
    echo -e "  ${GREEN}✓ Lab environment cleaned up${RESET}"
    sleep 1
}
