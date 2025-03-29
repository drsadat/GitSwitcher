#!/bin/bash

WORKSPACE=$1
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Validate workspace argument
if [[ ! "$WORKSPACE" =~ ^(academic|research|work|tools)$ ]]; then
    echo "Invalid workspace. Use: academic, research, work, or tools"
    exit 1
fi

# Set git identity
"$SCRIPT_DIR/set-git-identity.sh" "$WORKSPACE"

# Open VS Code workspace
code ~/Workspaces/"$WORKSPACE".code-workspace

# Show notification
osascript -e "display notification \"Switched to $WORKSPACE workspace\" with title \"Workspace Switcher\""

echo "Switched to $WORKSPACE workspace and set appropriate git identity" 