# GitSwitcher

A tool to manage multiple Git identities and VS Code workspaces with a single command.

## Project Structure

```
GitSwitcher/
├── config/
│   └── identities.json    # Git identity configurations
├── scripts/
│   ├── set-identity.sh    # Core Git identity setting script
│   └── switch.sh          # Main entry point script
└── src/
    └── workspace/         # Workspace configuration files
        ├── academic.code-workspace
        ├── research.code-workspace
        └── work.code-workspace
```

## Setup

1. Clone this repository to your desired location
2. Update `config/identities.json` with your Git identities
3. Update workspace paths in `src/workspace/*.code-workspace` files
4. Create an Alfred workflow:
   - Keyword: `gitid`
   - With Space: Yes
   - Script: `path/to/GitSwitcher/scripts/switch.sh {query}`

## Usage

```bash
gitid acad  # Switch to academic identity
gitid res   # Switch to research identity
gitid work  # Switch to work identity
```

## Configuration

Edit `config/identities.json` to add or modify Git identities:

```json
{
  "acad": {
    "name": "Prof. Sadat Choudhury",
    "email": "sadat@university.edu",
    "workspace": "academic"
  },
  "res": {
    "name": "Sadat Choudhury",
    "email": "sadat@researchhub.org",
    "workspace": "research"
  },
  "work": {
    "name": "Dr. Sadat Choudhury",
    "email": "sadat@company.com",
    "workspace": "work"
  }
}
``` 