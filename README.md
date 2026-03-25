# Capnproto support for vscode

Support for capnproto (http://capnproto.org/) 

## Features
- Syntax Highlighting
- Bracket matching
- Capnp ID generator ( Ctrl+Shift+p -> GenerateCapnpID )


Built specially for @grimpy

## Installation
clone repo under `~/.vscode/extensions/vscode-capnp`.


## Testing Locally

### Option 1: Debug launch (recommended)

1. Open this folder in VS Code:
2. Press F5 — this launches an Extension Development Host window
3. In the new window, open any .capnp file and verify:
   - Syntax highlighting works (comments with #, keywords, types)
   - Bracket matching works
   - Ctrl+Shift+P → "Generate Capnp ID" inserts an ID at the top

### Option 2: Install locally as VSIX

```bash
# Install the packaging tool
npm install -g @vscode/vsce

# Package the extension
vsce package

# Install the .vsix file
code --install-extension vscode-capnp-1.1.0.vsix
```

Then reload VS Code: and test with a .capnp file.


## Publishing to VS Code: Marketplace

1. Get a Personal Access Token from Azure DevOps:
   - Go to https://dev.azure.com/xmonader (create org if needed)
   - User Settings → Personal Access Tokens → New Token
   - Set scope to Marketplace > Manage
   - Copy the token

2. Login and publish:

```bash
npm install -g @vscode/vsce
vsce login xmonader        # paste your token when prompted
vsce publish
```

This publishes version 1.1.0 to the marketplace under your existing xmonader publisher.


## Publishing to Open VSX (for VSCodium / open-source VS Code:)

```bash
npm install -g ovsx
ovsx publish vscode-capnp-1.1.0.vsix -p <your-open-vsx-token>
```

Get your token at https://open-vsx.org after signing in with GitHub.


## Credits
https://github.com/textmate/capnproto.tmbundle (For textmate language grammar)
