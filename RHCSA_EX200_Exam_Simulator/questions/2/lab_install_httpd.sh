#!/bin/bash
# Objective 2: Manage Software (httpd)
# LAB: Install Software Using DNF

IS_LAB=true
LAB_ID="install_httpd"

QUESTION="Install the Apache HTTP Server (httpd) package and verify it is installed."

LAB_TASK_COUNT=2

# =============================================================================
# TASK DEFINITIONS
# =============================================================================

# Task 1
TASK_1_QUESTION="Install the httpd package using dnf."
TASK_1_HINT="Use dnf install with the -y option."
TASK_1_COMMAND_1="dnf install -y httpd"

# Task 2
TASK_2_QUESTION="Verify that the httpd package is installed."
TASK_2_HINT="Use rpm or dnf to verify the installation."
TASK_2_COMMAND_1="rpm -q httpd"

# Auto-generate hint
HINT=$(_build_hint)

prepare_lab() {

    echo -e "  ${DIM}• Removing httpd if already installed...${RESET}"
    dnf remove -y httpd >/dev/null 2>&1

    echo -e "  ${DIM}• Cleaning DNF cache...${RESET}"
    dnf clean all >/dev/null 2>&1

    sleep 0.3
}

check_tasks() {

    # Task 1 - Package installed
    if rpm -q httpd >/dev/null 2>&1; then
        TASK_STATUS[0]="true"
    else
        TASK_STATUS[0]="false"
    fi

    # Task 2 - Verification possible
    if dnf list installed httpd >/dev/null 2>&1; then
        TASK_STATUS[1]="true"
    else
        TASK_STATUS[1]="false"
    fi
}
