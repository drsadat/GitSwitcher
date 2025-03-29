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

# Get Git root
GIT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
if [ -z "$GIT_ROOT" ]; then
    echo "❌ Not inside a Git repo"
    exit 1
fi

echo "📂 Git root directory: $GIT_ROOT"

# Get identity configuration
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

# Get identity details from config
NAME=$(jq -r ".$IDENTITY.name" "$CONFIG_FILE")
EMAIL=$(jq -r ".$IDENTITY.email" "$CONFIG_FILE")

if [ -z "$NAME" ] || [ -z "$EMAIL" ]; then
    echo "❌ Invalid configuration for identity '$IDENTITY'"
    echo "Name or email is missing in the configuration"
    exit 1
fi

# Set Git identity
git -C "$GIT_ROOT" config user.name "$NAME"
git -C "$GIT_ROOT" config user.email "$EMAIL"

echo "✅ Git identity set to: $NAME <$EMAIL>" 