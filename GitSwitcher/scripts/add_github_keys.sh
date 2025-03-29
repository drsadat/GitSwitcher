#!/bin/bash

# GitHub API token should be provided as an environment variable
if [ -z "$GITHUB_TOKEN" ]; then
    echo "Please set the GITHUB_TOKEN environment variable"
    echo "Example: export GITHUB_TOKEN='your_token_here'"
    exit 1
fi

# Function to add an SSH key
add_ssh_key() {
    local title=$1
    local key_file=$2
    local key_content=$(cat "$key_file")
    
    echo "Adding key: $title"
    
    response=$(curl -s -X POST \
        -H "Accept: application/vnd.github+json" \
        -H "Authorization: Bearer $GITHUB_TOKEN" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        https://api.github.com/user/keys \
        -d "{
            \"title\": \"$title\",
            \"key\": \"$key_content\"
        }")
    
    if echo "$response" | grep -q "key_id"; then
        echo "✅ Successfully added key: $title"
    else
        echo "❌ Failed to add key: $title"
        echo "Error: $response"
    fi
}

# Add each SSH key
add_ssh_key "Academic Identity" ~/.ssh/id_ed25519_academic.pub
add_ssh_key "Research Identity" ~/.ssh/id_ed25519_research.pub
add_ssh_key "Tools Identity" ~/.ssh/id_ed25519_tools.pub
add_ssh_key "Personal Identity" ~/.ssh/id_ed25519_personal.pub

echo "Done! Please verify the keys at https://github.com/settings/keys" 