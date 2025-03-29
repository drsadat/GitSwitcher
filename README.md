# Personal Development Tools

A collection of personal development tools and configurations.

## Tools

### GitSwitcher

A tool to manage multiple Git identities and workspaces. Allows quick switching between different Git configurations and corresponding VS Code/Cursor workspaces.

#### Features:
- Manage multiple Git identities (work, academic, research, etc.)
- Automatic workspace switching
- Cursor/VS Code integration
- Clean separation of concerns

#### Usage:
```bash
gitid acad  # Switch to academic identity
gitid res   # Switch to research identity
gitid work  # Switch to work identity
```

## Setup

1. Clone this repository:
```bash
git clone https://github.com/YOUR_USERNAME/tools.git ~/Workspaces/tools
```

2. Set up GitSwitcher:
```bash
cd ~/Workspaces/tools
chmod +x GitSwitcher/scripts/*.sh

# Create your personal identities configuration
cp GitSwitcher/config/identities.json.template GitSwitcher/config/identities.json
```

3. Configure your identities in `GitSwitcher/config/identities.json`:
   - This file is git-ignored to protect your personal information
   - Never commit this file to the repository
   - Use `identities.json.template` as a reference

4. Set up Alfred workflow (optional):
- Keyword: `gitid`
- Script: `~/Workspaces/tools/GitSwitcher/scripts/switch-git-id.sh {query}`

## Directory Structure

```
tools/
├── GitSwitcher/           # Git identity and workspace manager
│   ├── config/           # Configuration files
│   │   ├── identities.json.template  # Template for Git identities
│   │   └── identities.json          # Your personal config (git-ignored)
│   ├── scripts/         # Shell scripts
│   └── src/            # Source files and workspaces
└── [future tools]      # Space for additional tools
```

## Security Notes

### Sensitive Information
The following files are git-ignored to protect sensitive data:
- `GitSwitcher/config/identities.json` - Contains your personal Git identities
- `*.local.json` - Any local configuration files
- `*.private.*` - Any private files
- `*.secret.*` - Any secret files

### First-Time Setup
1. Always copy template files before adding personal information:
   ```bash
   cp config/identities.json.template config/identities.json
   ```
2. Never commit files containing:
   - Personal email addresses
   - API keys or tokens
   - Private paths or URLs
   - Sensitive workspace configurations

## License

MIT License - Feel free to use and modify as needed. 