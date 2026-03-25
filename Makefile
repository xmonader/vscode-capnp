# Makefile for VS Code: Cap'n Proto Extension
# Provides build, test, package, and publish targets

.PHONY: all build compile test clean package install publish publish-ovsx help check-tools

# Detect VS Code: CLI (code or codium)
VSCODE_CLI := $(shell command -v code || command -v codium || echo "")

# Default target
all: build

# Check required tools are installed
check-tools:
	@which npm > /dev/null || (echo "ERROR: npm not found. Install Node.js first." && exit 1)
	@which node > /dev/null || (echo "ERROR: node not found. Install Node.js first." && exit 1)
	@echo "✓ Node.js and npm found"

# Build/compile the extension
build: check-tools
	@echo "Building extension..."
	npm run compile

# Alias for build
compile: build

# Watch mode for development
watch: check-tools
	@echo "Starting watch mode..."
	npm run watch

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -rf out/
	rm -f *.vsix

# Install dependencies
install-deps: check-tools
	@echo "Installing dependencies..."
	npm install

# Run tests
test: build
	@echo "Running tests..."
	@if [ ! -d "out/test" ]; then \
		echo "ERROR: Test files not compiled. Run 'make build' first."; \
		exit 1; \
	fi
	npm test

# Package the extension into .vsix file
package: clean build
	@echo "Packaging extension..."
	@which npx > /dev/null || (echo "ERROR: npx not found." && exit 1)
	npx @vscode/vsce package

# Install the .vsix locally for testing
install: package
	@if [ -z "$(VSCODE_CLI)" ]; then \
		echo "ERROR: Neither 'code' nor 'codium' CLI found."; \
		echo "Install VS Code: from https://code.visualstudio.com/"; \
		echo "For VSCodium, install from https://vscodium.com/"; \
		exit 1; \
	fi
	@echo "Installing extension using: $(VSCODE_CLI)"
	$(VSCODE_CLI) --install-extension $$(ls -t *.vsix | head -1)

# Publish to VS Code: Marketplace
publish: package
	@echo "Publishing to VS Code: Marketplace..."
	@which npx > /dev/null || (echo "ERROR: npx not found." && exit 1)
	npx @vscode/vsce publish

# Publish to Open VSX Registry (for VSCodium)
publish-ovsx: package
	@echo "Publishing to Open VSX..."
	@which npx > /dev/null || (echo "ERROR: npx not found." && exit 1)
	npx ovsx publish

# Quick publish workflow: package + publish to both
publish-all: package
	@echo "Publishing to VS Code: Marketplace..."
	npx @vscode/vsce publish
	@echo "Publishing to Open VSX..."
	npx ovsx publish

# Login to VS Code: Marketplace (run once)
login-vscode:
	@which npx > /dev/null || (echo "ERROR: npx not found." && exit 1)
	npx @vscode/vsce login xmonader

# Login to Open VSX (run once)
login-ovsx:
	@which npx > /dev/null || (echo "ERROR: npx not found." && exit 1)
	npx ovsx login xmonader

# Development workflow - clean, install, build
dev-setup: clean install-deps build
	@echo "Development setup complete!"

# Verify everything works (build + test)
ci: build test
	@echo "✓ CI checks passed"

# Show help
help:
	@echo "Available targets:"
	@echo "  make build          - Compile TypeScript sources"
	@echo "  make compile        - Alias for build"
	@echo "  make watch          - Start TypeScript watch mode"
	@echo "  make clean          - Remove build artifacts and .vsix files"
	@echo "  make test           - Run tests (builds first)"
	@echo "  make package        - Create .vsix package for distribution"
	@echo "  make install        - Install the .vsix locally for testing"
	@echo "  make publish        - Publish to VS Code: Marketplace"
	@echo "  make publish-ovsx   - Publish to Open VSX Registry"
	@echo "  make publish-all    - Publish to both marketplaces"
	@echo "  make login-vscode   - Login to VS Code: Marketplace"
	@echo "  make login-ovsx     - Login to Open VSX"
	@echo "  make dev-setup      - Full development setup"
	@echo "  make ci             - Run CI checks (build + test)"
	@echo "  make help           - Show this help message"
