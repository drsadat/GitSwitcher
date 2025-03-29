# GitSwitcher

A tool to manage multiple GitHub identities and workspaces efficiently. GitSwitcher helps you maintain separate Git identities for different contexts (academic, research, personal, etc.) and automatically switches between them based on your workspace.

## Features

- 🔄 Automatic Git identity switching based on workspace
- 🗂️ Workspace-specific configurations
- 🔐 SSH key management for different identities
- 📝 Easy-to-use scripts for setup and switching
- 🚀 VS Code workspace integration
- ⚡ Quick switching via Alfred 5 workflow

## Setup

1. Clone the repository:
   ```

## Alfred 5 Integration

GitSwitcher can be integrated with Alfred 5 for quick workspace switching. For detailed setup instructions, see [Alfred Setup Guide](docs/alfred_setup.md).

Quick setup:
1. Install Alfred 5 from [alfredapp.com](https://www.alfredapp.com/)
2. Create a new workflow named "GitSwitcher"
3. Add a Script Filter with keyword `gs`
4. Add a Run Script action
5. Configure as per the setup guide

Once configured, you can quickly switch identities by:
1. Triggering Alfred (default: ⌥ Space)
2. Typing `gs`
3. Selecting your desired identity

## License