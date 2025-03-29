#!/bin/bash

# Enable debug mode if DEBUG environment variable is set
[[ -n $DEBUG ]] && set -x

# Exit on error
set -e

# Get the script's directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "🔍 Using project root: $PROJECT_ROOT"

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "❌ jq is required but not installed. Please install it first:"
    echo "  brew install jq"
    exit 1
fi

# Check if Cursor is installed
if ! command -v cursor &> /dev/null; then
    echo "❌ Cursor command not found. Please install Cursor and the command line tools"
    exit 1
fi

# Check if an identity shortcut was provided
if [ -z "$1" ]; then
    echo "❌ Please provide an identity shortcut (acad, res, or work)"
    echo "Available identities:"
    jq -r 'keys | .[]' "$PROJECT_ROOT/config/identities.json" | while read -r key; do
        echo "  $key"
    done
    exit 1
fi

IDENTITY=$1
CONFIG_FILE="$PROJECT_ROOT/config/identities.json"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ Configuration file not found: $CONFIG_FILE"
    exit 1
fi

echo "📄 Using config file: $CONFIG_FILE"

# Validate identity exists in config
if ! jq -e ".$IDENTITY" "$CONFIG_FILE" > /dev/null; then
    echo "❌ Invalid identity '$IDENTITY'"
    echo "Available identities:"
    jq -r 'keys | .[]' "$CONFIG_FILE" | while read -r key; do
        echo "  $key"
    done
    exit 1
fi

# Get workspace name from config
WORKSPACE=$(jq -r ".$IDENTITY.workspace" "$CONFIG_FILE")

if [ -z "$WORKSPACE" ]; then
    echo "❌ Workspace not defined for identity '$IDENTITY'"
    exit 1
fi

WORKSPACE_FILE="$PROJECT_ROOT/src/workspace/$WORKSPACE.code-workspace"

if [ ! -f "$WORKSPACE_FILE" ]; then
    echo "❌ Workspace file not found: $WORKSPACE_FILE"
    exit 1
fi

echo "🔄 Setting Git identity..."
# Set Git identity
"$PROJECT_ROOT/scripts/set-identity.sh" "$IDENTITY"

echo "💻 Opening workspace: $WORKSPACE_FILE"
# Launch Cursor with the corresponding workspace
cursor "$WORKSPACE_FILE"

echo "✅ Successfully switched to $IDENTITY identity and opened $WORKSPACE workspace" 