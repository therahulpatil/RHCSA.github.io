#!/bin/bash
# Objective 3: Create simple shell scripts
# LAB: Conditionally Execute Code

# This is a LAB exercise
IS_LAB=true
LAB_ID="script_conditions"

QUESTION="Create a shell script with conditional logic (if, test, [ ])"

# Lab configuration
LAB_TASK_COUNT=2

# =============================================================================
# TASK DEFINITIONS - Each task has question, hint, and command(s)
# =============================================================================

# Task 1
TASK_1_QUESTION="Create /usr/local/bin/check_file.sh: checks if \$1 is a regular file; prints FILE_EXISTS and exits 0 if true, prints FILE_NOT_FOUND and exits 1 if false"
TASK_1_HINT="Use if [ -f \"\$1\" ]; then ... else ... fi with appropriate echo and exit codes"
TASK_1_COMMAND_1="cat << 'EOF' > /usr/local/bin/check_file.sh
#!/bin/bash
if [ -f \"\$1\" ]; then
    echo \"FILE_EXISTS\"
    exit 0
else
    echo \"FILE_NOT_FOUND\"
    exit 1
fi
EOF"

# Task 2
TASK_2_QUESTION="Make /usr/local/bin/check_file.sh executable"
TASK_2_HINT="Use chmod +x to give execute permissions"
TASK_2_COMMAND_1="chmod +x /usr/local/bin/check_file.sh"


# Auto-generate HINT from commands
HINT=$(_build_hint)

# =============================================================================
# LAB IMPLEMENTATION
# =============================================================================

# Prepare the lab environment
prepare_lab() {
    echo -e "  ${DIM}• Removing existing script if present...${RESET}"
    rm -f /usr/local/bin/check_file.sh 2>/dev/null
    sleep 0.3
}

# Check task completion - sets TASK_STATUS array
check_tasks() {
    local script="/usr/local/bin/check_file.sh"
    
    # Task 0: Check script behavior with existing and non-existing file
    if [[ -f "$script" ]]; then
        local out_exists
        local code_exists
        out_exists=$(bash "$script" /etc/passwd 2>/dev/null)
        code_exists=$?

        local out_missing
        local code_missing
        out_missing=$(bash "$script" /tmp/nonexistent_test_rhcsa_$$ 2>/dev/null)
        code_missing=$?

        if [[ "$code_exists" -eq 0 ]] && [[ "$out_exists" =~ "FILE_EXISTS" ]] && \
           [[ "$code_missing" -eq 1 ]] && [[ "$out_missing" =~ "FILE_NOT_FOUND" ]]; then
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
    rm -f /usr/local/bin/check_file.sh 2>/dev/null
    echo -e "  ${GREEN}✓ Lab environment cleaned up${RESET}"
    sleep 1
}
