# Warp Shell - Development Environment Bootstrap
# Run `just --list` to see all available commands

# Default recipe (shows help)
default:
    @just --list

# 🚀 Full installation (all components)
bootstrap-all: base rust shell python nodejs docker iac utils atuin ai git-tools visuals
    @echo "🎉 Full installation complete!"
    @echo "💡 Restart your terminal or run: source ~/.zshrc"

# 🎯 Quick install (essential only)
bootstrap-quick: base rust shell
    @echo "✅ Quick setup complete!"
    @echo "💡 Restart your terminal or run: source ~/.zshrc"

# 📦 Individual components

# Install base packages and CLI tools
base:
    @echo "📦 Installing base packages..."
    @bash bootstrap/base.sh

# Install Rust toolchain
rust:
    @echo "🦀 Installing Rust..."
    @bash bootstrap/rust.sh

# Setup shell (zsh, starship, zellij)
shell:
    @echo "🌀 Setting up shell..."
    @bash bootstrap/shell.sh

# Install Python development environment
python:
    @echo "🐍 Installing Python tools..."
    @bash bootstrap/python.sh

# Install Node.js development environment
nodejs:
    @echo "📗 Installing Node.js tools..."
    @bash bootstrap/nodejs.sh

# Install Docker and container tools
docker:
    @echo "🐳 Installing Docker..."
    @bash bootstrap/docker.sh

# Install IaC tools (terraform, k8s, etc)
iac:
    @echo "🏗️  Installing IaC tools..."
    @bash bootstrap/iac.sh

# Install utility tools (jq, yq, etc)
utils:
    @echo "🛠️  Installing utils..."
    @bash bootstrap/utils.sh

# Install atuin (advanced history)
atuin:
    @echo "🔮 Installing Atuin..."
    @bash bootstrap/atuin.sh

# Install AI tools (Ollama)
ai:
    @echo "🤖 Installing AI tools..."
    @bash bootstrap/ai.sh

# Install git tools (commitizen, pre-commit)
git-tools:
    @echo "🔧 Installing Git tools..."
    @bash bootstrap/git-tools.sh

# Install fonts and themes
visuals:
    @echo "🎨 Installing fonts and themes..."
    @bash bootstrap/visuals.sh

# 🧹 Maintenance

# Update all packages
update:
    @echo "🔄 Updating system packages..."
    sudo apt update && sudo apt upgrade -y
    @echo "🔄 Updating Rust..."
    rustup update
    @echo "🔄 Updating cargo tools..."
    cargo install-update -a || echo "Install cargo-update with: cargo install cargo-update"

# Clean old configs
clean:
    @echo "🧹 Cleaning old configs..."
    rm -rf ~/.oh-my-zsh ~/.p10k.zsh

# Show system info
info:
    @echo "💻 System Information:"
    @command -v macchina &>/dev/null && macchina || neofetch || echo "Install macchina for better info"

# 🐳 Docker helpers (import from justfiles/docker.just if exists)

# Start all containers
docker-up:
    docker-compose up -d

# Stop all containers
docker-down:
    docker-compose down

# View logs
docker-logs:
    docker-compose logs -f

# Clean docker system
docker-clean:
    docker system prune -af

# 🐍 Python helpers

# Create new poetry project
py-new name:
    poetry new {{name}}
    cd {{name}} && poetry install

# Install dependencies
py-install:
    poetry install

# Run tests
py-test:
    poetry run pytest

# Format code
py-format:
    poetry run black .
    poetry run ruff check --fix .

# 📗 Node helpers

# Install dependencies
node-install:
    pnpm install

# Run dev server
node-dev:
    pnpm dev

# Build project
node-build:
    pnpm build

# 🤖 AI Agent helpers

# Translate text (French to English)
translate text:
    @bash agents/translator.sh "{{text}}"

# Generate Jira ticket
jira-ticket title:
    @bash agents/jira-ticket.sh "{{title}}"

# Generate documentation
gen-doc path:
    @bash agents/doc-generator.sh "{{path}}"

# 🏗️ Terraform/IaC helpers

# Terraform init
tf-init:
    terraform init

# Terraform plan
tf-plan:
    terraform plan

# Terraform apply
tf-apply:
    terraform apply

# Terragrunt run-all plan
tg-plan:
    terragrunt run-all plan

# Terragrunt run-all apply
tg-apply:
    terragrunt run-all apply

# ☸️  Kubernetes helpers

# Get all pods
k8s-pods:
    kubectl get pods -A

# Start k9s
k9s:
    k9s

# Get contexts
k8s-contexts:
    kubectl config get-contexts

# Switch context
k8s-use context:
    kubectl config use-context {{context}}
