# Setting Up GitSwitcher in Alfred 5

This guide will walk you through setting up the GitSwitcher workflow in Alfred 5.

## Prerequisites

1. [Alfred 5](https://www.alfredapp.com/) installed on your Mac
2. Alfred Powerpack license (required for workflows)
3. GitSwitcher installed and configured

## Step-by-Step Setup

### 1. Create a New Workflow

1. Open Alfred Preferences (⌘ + ,)
2. Click on the "Workflows" tab in the sidebar
3. Click the "+" button in the bottom left corner
4. Select "Blank Workflow"
5. Fill in the workflow details:
   - Name: `GitSwitcher`
   - Description: `Quick switching between Git identities`
   - Category: `Productivity`
   - Icon: Choose any icon you prefer (optional)
   - Click "Create"

### 2. Add Script Filter

1. Right-click in the workflow canvas
2. Select "Inputs" > "Script Filter"
3. Configure the Script Filter:
   - Search Keyword: `gs`
   - Title: `Switch Git Identity`
   - Subtext: `Select an identity to switch to`
   - Language: `/bin/bash`
   - Copy and paste this script:
   ```bash
   CONFIG_FILE="$HOME/Workspaces/tools/GitSwitcher/config/identities.json"
   
   # Check if config file exists
   if [ ! -f "$CONFIG_FILE" ]; then
       echo "{
           \"items\": [{
               \"title\": \"Error: Configuration not found\",
               \"subtitle\": \"Please ensure GitSwitcher is properly installed\",
               \"valid\": false
           }]
       }"
       exit 1
   fi
   
   # Check if jq is installed
   if ! command -v jq &> /dev/null; then
       echo "{
           \"items\": [{
               \"title\": \"Error: jq not installed\",
               \"subtitle\": \"Please install jq using: brew install jq\",
               \"valid\": false
           }]
       }"
       exit 1
   fi
   
   echo "{"
   echo "  \"items\": ["
   
   # Get all identities
   first=true
   jq -r 'keys | .[]' "$CONFIG_FILE" | while read -r key; do
       if [ "$first" = true ]; then
           first=false
       else
           echo ","
       fi
       name=$(jq -r ".[\"$key\"].name" "$CONFIG_FILE")
       email=$(jq -r ".[\"$key\"].email" "$CONFIG_FILE")
       workspace=$(jq -r ".[\"$key\"].workspace" "$CONFIG_FILE")
       echo "    {
           \"title\": \"Switch to $key\",
           \"subtitle\": \"$name <$email> - Workspace: $workspace\",
           \"arg\": \"$key\",
           \"icon\": {
               \"path\": \"./icons/$key.png\"
           }
       }"
   done
   
   echo "  ]"
   echo "}"
   ```

### 3. Add Run Script Action

1. Right-click in the workflow canvas
2. Select "Actions" > "Run Script"
3. Connect the Script Filter to the Run Script action
4. Configure the Run Script:
   - Language: `/bin/bash`
   - Copy and paste this script:
   ```bash
   $HOME/Workspaces/tools/GitSwitcher/scripts/switch-git-id.sh "$1"
   ```

### 4. Add Notification (Optional)

1. Right-click in the workflow canvas
2. Select "Outputs" > "Post Notification"
3. Connect the Run Script to the Post Notification
4. Configure the notification:
   - Title: `GitSwitcher`
   - Text: `Switched to {query} identity`

## Usage

1. Trigger Alfred (default: ⌥ Space)
2. Type `gs`
3. Select your desired identity from the list
4. Press Enter to switch

## Customization

### Adding Icons

1. Create a folder named `icons` in your workflow directory
2. Add PNG icons for each identity (e.g., `academic.png`, `research.png`, `tools.png`)
3. Name each icon to match your identity keys in `identities.json`

### Modifying the Trigger

1. Double-click the Script Filter in your workflow
2. Change the "Search Keyword" to your preferred trigger
3. Click "Save"

## Troubleshooting

If you encounter issues:

1. Verify GitSwitcher is properly installed
2. Ensure `jq` is installed: `brew install jq`
3. Check the configuration file exists
4. Verify the paths in the scripts match your installation
5. Check Alfred's debug console for errors

## Tips

- Use ⌘ + Enter to view the identity details before switching
- Add tags to your identities for easier searching
- Customize the notification sound in the Post Notification settings 