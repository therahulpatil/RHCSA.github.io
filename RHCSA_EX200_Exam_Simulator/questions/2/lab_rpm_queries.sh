#!/bin/bash
# Objective 2: Manage software
# LAB: Query RPM Packages and File Ownership

# This is a LAB exercise
IS_LAB=true
LAB_ID="rpm_queries"

QUESTION="Query RPM packages for file ownership and installed documentation"

# Lab configuration
LAB_TASK_COUNT=2

# =============================================================================
# TASK DEFINITIONS - Each task has question, hint, and command(s)
# =============================================================================

# Task 1
TASK_1_QUESTION="Find which package provides /etc/passwd and save the output to /tmp/passwd_pkg.txt"
TASK_1_HINT="Use rpm -qf to query which package owns a specific file path"
TASK_1_COMMAND_1="rpm -qf /etc/passwd > /tmp/passwd_pkg.txt"

# Task 2
TASK_2_QUESTION="List all documentation files provided by the setup package and save to /tmp/setup_docs.txt"
TASK_2_HINT="Use rpm -qd to list documentation files for a package"
TASK_2_COMMAND_1="rpm -qd setup > /tmp/setup_docs.txt"


# Auto-generate HINT from commands
HINT=$(_build_hint)

# =============================================================================
# LAB IMPLEMENTATION
# =============================================================================

# Prepare the lab environment
prepare_lab() {
    echo -e "  ${DIM}• Removing existing output files...${RESET}"
    rm -f /tmp/passwd_pkg.txt /tmp/setup_docs.txt 2>/dev/null
    sleep 0.3
}

# Check task completion - sets TASK_STATUS array
check_tasks() {
    # Task 0: Check /tmp/passwd_pkg.txt contains setup package name
    if [[ -f /tmp/passwd_pkg.txt ]] && grep -qE '^setup-[0-9]' /tmp/passwd_pkg.txt 2>/dev/null; then
        TASK_STATUS[0]="true"
    else
        TASK_STATUS[0]="false"
    fi

    # Task 1: Check /tmp/setup_docs.txt contains doc files and is non-empty
    if [[ -f /tmp/setup_docs.txt ]] && [[ -s /tmp/setup_docs.txt ]] && grep -qE '/usr/share/doc|/usr/share/licenses' /tmp/setup_docs.txt 2>/dev/null; then
        TASK_STATUS[1]="true"
    else
        TASK_STATUS[1]="false"
    fi
}

# Cleanup the lab environment before exit
cleanup_lab() {
    echo -e "  ${DIM}• Cleaning up lab environment...${RESET}"
    rm -f /tmp/passwd_pkg.txt /tmp/setup_docs.txt 2>/dev/null
    echo -e "  ${GREEN}✓ Lab environment cleaned up${RESET}"
    sleep 1
}
