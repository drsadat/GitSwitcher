#!/bin/bash

PROFILE=$1
CONFIG_FILE="$HOME/Workspaces/tools/GitSwitcher/config/identities.json"
ROOT=$(git rev-parse --show-toplevel 2>/dev/null) || exit 1

# Function to extract value from JSON
get_json_value() {
    local key=$1
    local profile=$2
    python3 -c "import json; f=open('$CONFIG_FILE'); d=json.load(f); print(d['$profile']['$key'])"
}

# Get identity details
NAME=$(get_json_value "name" "$PROFILE")
EMAIL=$(get_json_value "email" "$PROFILE")
WORKSPACE=$(get_json_value "workspace" "$PROFILE")

# Set git config
git -C "$ROOT" config user.name "$NAME"
git -C "$ROOT" config user.email "$EMAIL"

# Display notification
osascript -e "display notification \"Git identity set to $NAME\" with title \"Git Identity\""

echo "Git identity set to:"
echo "Name: $NAME"
echo "Email: $EMAIL"
echo "Workspace: $WORKSPACE" 