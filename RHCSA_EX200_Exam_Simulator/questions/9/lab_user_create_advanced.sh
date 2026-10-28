#!/bin/bash
# Objective 9: Manage users and groups
# LAB: Create and Configure User Accounts and Groups

# This is a LAB exercise
IS_LAB=true
LAB_ID="user_create_advanced"

QUESTION="Create and configure a local group and user account with specific attributes"

# Lab configuration
LAB_TASK_COUNT=2

# =============================================================================
# TASK DEFINITIONS - Each task has question, hint, and command(s)
# =============================================================================

# Task 1
TASK_1_QUESTION="Create a group named devops with GID 2050"
TASK_1_HINT="Use groupadd with the -g option to specify the GID"
TASK_1_COMMAND_1="groupadd -g 2050 devops"

# Task 2
TASK_2_QUESTION="Create user alice with UID 2050, primary group devops, supplementary group wheel, comment 'Lead DevOps Engineer', and shell /bin/bash"
TASK_2_HINT="Use useradd with -u, -g, -G, -c, and -s options"
TASK_2_COMMAND_1="useradd -u 2050 -g devops -G wheel -c 'Lead DevOps Engineer' -s /bin/bash alice"


# Auto-generate HINT from commands
HINT=$(_build_hint)

# =============================================================================
# LAB IMPLEMENTATION
# =============================================================================

# Prepare the lab environment
prepare_lab() {
    echo -e "  ${DIM}• Removing existing user and group if present...${RESET}"
    userdel -r alice 2>/dev/null
    groupdel devops 2>/dev/null
    sleep 0.3
}

# Check task completion - sets TASK_STATUS array
check_tasks() {
    # Task 0: Check group devops exists with GID 2050
    local gid
    gid=$(getent group devops 2>/dev/null | cut -d: -f3)
    if [[ "$gid" == "2050" ]]; then
        TASK_STATUS[0]="true"
    else
        TASK_STATUS[0]="false"
    fi

    # Task 1: Check user alice configuration
    if id alice &>/dev/null; then
        local uid
        local primary_gid
        local groups
        local comment
        local shell
        
        uid=$(id -u alice 2>/dev/null)
        primary_gid=$(id -g alice 2>/dev/null)
        groups=$(id -Gn alice 2>/dev/null)
        comment=$(getent passwd alice 2>/dev/null | cut -d: -f5)
        shell=$(getent passwd alice 2>/dev/null | cut -d: -f7)

        if [[ "$uid" == "2050" ]] && [[ "$primary_gid" == "2050" ]] && \
           [[ " $groups " =~ " wheel " ]] && [[ "$comment" == "Lead DevOps Engineer" ]] && \
           [[ "$shell" == "/bin/bash" ]]; then
            TASK_STATUS[1]="true"
        else
            TASK_STATUS[1]="false"
        fi
    else
        TASK_STATUS[1]="false"
    fi
}

# Cleanup the lab environment before exit
cleanup_lab() {
    echo -e "  ${DIM}• Cleaning up lab environment...${RESET}"
    userdel -r alice 2>/dev/null
    groupdel devops 2>/dev/null
    echo -e "  ${GREEN}✓ Lab environment cleaned up${RESET}"
    sleep 1
}
