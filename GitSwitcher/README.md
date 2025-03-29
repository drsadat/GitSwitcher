# GitSwitcher

A tool to manage multiple GitHub identities and workspaces efficiently. GitSwitcher helps you maintain separate Git identities for different contexts (academic, research, personal, etc.) and automatically switches between them based on your workspace.

## Features

- 🔄 Automatic Git identity switching based on workspace
- 🗂️ Workspace-specific configurations
- 🔐 SSH key management for different identities
- 📝 Easy-to-use scripts for setup and switching
- 🚀 VS Code workspace integration

## Setup

1. Clone the repository:
   ```bash
   git clone git@github-tools:drsadat/GitSwitcher.git
   ```

2. Generate SSH keys for each identity:
   ```bash
   ./scripts/add_github_keys.sh
   ```

3. Configure your identities in `config/identities.json`:
   ```json
   {
     "academic": {
       "name": "Your Academic Name",
       "email": "your.academic@university.edu",
       "workspace": "academic"
     }
   }
   ```

4. Set up workspace configurations in `src/workspace/`.

## Usage

Switch between identities using:
```bash
./scripts/set-git-identity.sh [profile]
```

Where `[profile]` is one of your configured identities (e.g., academic, research, personal).

## License

MIT License - See LICENSE file for details.

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request 