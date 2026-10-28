#!/bin/bash
# Objective 4: Operate running systems
# LAB: Start, Stop, and Manage Services with systemctl

# This is a LAB exercise
IS_LAB=true
LAB_ID="systemd_service"

QUESTION="Manage system services and ensure they start at boot"

# Lab configuration
LAB_TASK_COUNT=2

# =============================================================================
# TASK DEFINITIONS - Each task has question, hint, and command(s)
# =============================================================================

# Task 1
TASK_1_QUESTION="Enable and start the sshd service in a single command"
TASK_1_HINT="Use systemctl enable --now sshd"
TASK_1_COMMAND_1="systemctl enable --now sshd"

# Task 2
TASK_2_QUESTION="Verify the current active and enabled status of sshd"
TASK_2_HINT="Use systemctl is-active sshd and systemctl is-enabled sshd"
TASK_2_COMMAND_1="systemctl status sshd"


# Auto-generate HINT from commands
HINT=$(_build_hint)

# =============================================================================
# LAB IMPLEMENTATION
# =============================================================================

# Prepare the lab environment
prepare_lab() {
    echo -e "  ${DIM}• Disabling service for lab exercise...${RESET}"
    systemctl disable sshd 2>/dev/null
    sleep 0.3
}

# Check task completion - sets TASK_STATUS array
check_tasks() {
    # Task 0: Check if sshd is active and enabled
    if systemctl is-active sshd &>/dev/null && systemctl is-enabled sshd &>/dev/null; then
        TASK_STATUS[0]="true"
    else
        TASK_STATUS[0]="false"
    fi

    # Task 1: Check if sshd status command can be verified
    if systemctl is-active sshd &>/dev/null; then
        TASK_STATUS[1]="true"
    else
        TASK_STATUS[1]="false"
    fi
}

# Cleanup the lab environment before exit
cleanup_lab() {
    echo -e "  ${DIM}• Ensuring sshd is enabled and running...${RESET}"
    systemctl enable --now sshd 2>/dev/null
    echo -e "  ${GREEN}✓ Lab environment cleaned up${RESET}"
    sleep 1
}
