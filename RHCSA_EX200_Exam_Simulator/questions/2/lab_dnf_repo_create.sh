#!/bin/bash
# Objective 2: Manage software
# LAB: Configure and Manage Access to RPM Repositories

# This is a LAB exercise
IS_LAB=true
LAB_ID="dnf_repo_create"

QUESTION="Configure a new RPM software repository for DNF"

# Lab configuration
LAB_TASK_COUNT=2

# =============================================================================
# TASK DEFINITIONS - Each task has question, hint, and command(s)
# =============================================================================

# Task 1
TASK_1_QUESTION="Create /etc/yum.repos.d/custom_app.repo with section [custom_app], name=Custom App Repo, baseurl=file:///var/repo/custom, enabled=1, gpgcheck=0"
TASK_1_HINT="Create the repository file in /etc/yum.repos.d/ with the required parameters"
TASK_1_COMMAND_1="cat << 'EOF' > /etc/yum.repos.d/custom_app.repo
[custom_app]
name=Custom App Repo
baseurl=file:///var/repo/custom
enabled=1
gpgcheck=0
EOF"

# Task 2
TASK_2_QUESTION="Verify the repository is recognized by running dnf repolist"
TASK_2_HINT="Use dnf repolist custom_app to confirm the repository is recognized"
TASK_2_COMMAND_1="dnf repolist custom_app"


# Auto-generate HINT from commands
HINT=$(_build_hint)

# =============================================================================
# LAB IMPLEMENTATION
# =============================================================================

# Prepare the lab environment
prepare_lab() {
    echo -e "  ${DIM}• Cleaning existing repo configuration...${RESET}"
    rm -f /etc/yum.repos.d/custom_app.repo 2>/dev/null
    mkdir -p /var/repo/custom 2>/dev/null
    sleep 0.3
}

# Check task completion - sets TASK_STATUS array
check_tasks() {
    # Task 0: Check /etc/yum.repos.d/custom_app.repo content
    local repo_file="/etc/yum.repos.d/custom_app.repo"
    if [[ -f "$repo_file" ]] && \
       grep -qE '^\s*\[custom_app\]' "$repo_file" 2>/dev/null && \
       grep -qE 'baseurl\s*=\s*file:///var/repo/custom' "$repo_file" 2>/dev/null && \
       grep -qE 'enabled\s*=\s*1' "$repo_file" 2>/dev/null && \
       grep -qE 'gpgcheck\s*=\s*0' "$repo_file" 2>/dev/null; then
        TASK_STATUS[0]="true"
    else
        TASK_STATUS[0]="false"
    fi

    # Task 1: Check dnf repolist recognizes the repo
    if dnf repolist custom_app 2>/dev/null | grep -q "custom_app"; then
        TASK_STATUS[1]="true"
    else
        TASK_STATUS[1]="false"
    fi
}

# Cleanup the lab environment before exit
cleanup_lab() {
    echo -e "  ${DIM}• Cleaning up lab environment...${RESET}"
    rm -f /etc/yum.repos.d/custom_app.repo 2>/dev/null
    rm -rf /var/repo/custom 2>/dev/null
    echo -e "  ${GREEN}✓ Lab environment cleaned up${RESET}"
    sleep 1
}
