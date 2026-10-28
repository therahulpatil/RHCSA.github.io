#!/bin/bash
# Objective 10: Manage security
# LAB: Configure Firewall Settings Using firewall-cmd

# This is a LAB exercise
IS_LAB=true
LAB_ID="firewalld_service_port"

QUESTION="Configure firewall rules for services and custom ports using firewall-cmd"

# Lab configuration
LAB_TASK_COUNT=3

# =============================================================================
# TASK DEFINITIONS - Each task has question, hint, and command(s)
# =============================================================================

# Task 1
TASK_1_QUESTION="Permanently allow the http service through the firewall"
TASK_1_HINT="Use firewall-cmd with --permanent --add-service=http"
TASK_1_COMMAND_1="firewall-cmd --permanent --add-service=http"

# Task 2
TASK_2_QUESTION="Permanently open TCP port 8080 in the firewall"
TASK_2_HINT="Use firewall-cmd with --permanent --add-port=8080/tcp"
TASK_2_COMMAND_1="firewall-cmd --permanent --add-port=8080/tcp"

# Task 3
TASK_3_QUESTION="Reload firewalld to apply permanent changes to the running environment"
TASK_3_HINT="Use firewall-cmd --reload"
TASK_3_COMMAND_1="firewall-cmd --reload"


# Auto-generate HINT from commands
HINT=$(_build_hint)

# =============================================================================
# LAB IMPLEMENTATION
# =============================================================================

# Prepare the lab environment
prepare_lab() {
    echo -e "  ${DIM}• Resetting test firewall rules...${RESET}"
    if systemctl is-active firewalld &>/dev/null; then
        firewall-cmd --permanent --remove-service=http 2>/dev/null
        firewall-cmd --permanent --remove-port=8080/tcp 2>/dev/null
        firewall-cmd --reload 2>/dev/null
    else
        systemctl start firewalld 2>/dev/null
        firewall-cmd --permanent --remove-service=http 2>/dev/null
        firewall-cmd --permanent --remove-port=8080/tcp 2>/dev/null
        firewall-cmd --reload 2>/dev/null
    fi
    sleep 0.3
}

# Check task completion - sets TASK_STATUS array
check_tasks() {
    # Task 0: Check if http service is configured permanently
    if firewall-cmd --permanent --list-services 2>/dev/null | grep -qE '\bhttp\b'; then
        TASK_STATUS[0]="true"
    else
        TASK_STATUS[0]="false"
    fi

    # Task 1: Check if port 8080/tcp is configured permanently
    if firewall-cmd --permanent --list-ports 2>/dev/null | grep -qE '\b8080/tcp\b'; then
        TASK_STATUS[1]="true"
    else
        TASK_STATUS[1]="false"
    fi

    # Task 2: Check if reload was executed (runtime active rules match permanent)
    if firewall-cmd --list-services 2>/dev/null | grep -qE '\bhttp\b' && \
       firewall-cmd --list-ports 2>/dev/null | grep -qE '\b8080/tcp\b'; then
        TASK_STATUS[2]="true"
    else
        TASK_STATUS[2]="false"
    fi
}

# Cleanup the lab environment before exit
cleanup_lab() {
    echo -e "  ${DIM}• Cleaning up lab environment...${RESET}"
    firewall-cmd --permanent --remove-service=http 2>/dev/null
    firewall-cmd --permanent --remove-port=8080/tcp 2>/dev/null
    firewall-cmd --reload 2>/dev/null
    echo -e "  ${GREEN}✓ Lab environment cleaned up${RESET}"
    sleep 1
}
