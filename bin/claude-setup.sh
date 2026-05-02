#!/usr/bin/env bash
#
# Claude Template Setup CLI
# Initializes and manages Claude Code template configurations
#
# Usage:
#   ./bin/claude-setup.sh init [name]        - Initialize new project from template
#   ./bin/claude-setup.sh install [component] - Install a specific component
#   ./bin/claude-setup.sh bundle [stack]      - Install all components for a stack
#   ./bin/claude-setup.sh list                - Show available components by stack
#   ./bin/claude-setup.sh upgrade             - Check for template updates
#

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CLAUDE_DIR="$HOME/.claude"

# ── Helpers ──────────────────────────────────────────────

info()  { echo -e "${BLUE}ℹ${NC} $*"; }
ok()    { echo -e "${GREEN}✓${NC} $*"; }
warn()  { echo -e "${YELLOW}⚠${NC} $*"; }
err()   { echo -e "${RED}✗${NC} $*"; }

separator() {
  echo -e "${CYAN}── $* ──────────────────────────────────${NC}"
}

# ── Commands ─────────────────────────────────────────────

cmd_init() {
  local name="${1:-claude-project}"

  separator "INITIALIZING: $name"

  # Create target directory
  local target="$PWD/$name"
  if [[ -d "$target" ]]; then
    err "Directory '$name' already exists"
    exit 1
  fi

  mkdir -p "$target"
  info "Created directory: $target"

  # Copy template files
  info "Copying template files..."

  # Copy core files
  cp "$TEMPLATE_ROOT/CLAUDE.md" "$target/"
  cp "$TEMPLATE_ROOT/.gitignore" "$target/"
  cp "$TEMPLATE_ROOT/.env.template" "$target/"
  cp "$TEMPLATE_ROOT/.mcp.json.template" "$target/"
  cp "$TEMPLATE_ROOT/settings.json.template" "$target/"

  # Copy LICENSE if exists
  [[ -f "$TEMPLATE_ROOT/LICENSE" ]] && cp "$TEMPLATE_ROOT/LICENSE" "$target/"

  # Copy directories
  for dir in persona commands skills agents docs plugins bin memory; do
    if [[ -d "$TEMPLATE_ROOT/$dir" ]]; then
      cp -r "$TEMPLATE_ROOT/$dir" "$target/"
    fi
  done

  # Create actual config files from templates
  cp "$target/.env.template" "$target/.env"
  cp "$target/.mcp.json.template" "$target/.mcp.json"
  cp "$target/settings.json.template" "$target/settings.json"

  ok "Template files copied"

  # Initialize git
  if command -v git &>/dev/null; then
    (cd "$target" && git init && git add -A && git commit -m "Initial commit: Claude Code template")
    ok "Git repository initialized"
  fi

  echo ""
  ok "Project '$name' created successfully!"
  echo ""
  echo "Next steps:"
  echo "  1. cd $name"
  echo "  2. Edit .env with your credentials"
  echo "  3. Edit .mcp.json with your MCP server config"
  echo "  4. Edit CLAUDE.md to set your default persona"
  echo "  5. Install stacks: ./bin/claude-setup.sh bundle flutter"
  echo ""
}

cmd_install() {
  local component="$1"

  if [[ -z "$component" ]]; then
    err "Component name required"
    echo "Usage: ./bin/claude-setup.sh install [component]"
    echo ""
    echo "Components:"
    echo "  persona/nova       - Nova persona"
    echo "  persona/blaze      - Blaze persona"
    echo "  agents/flutter     - Flutter dev agent"
    echo "  agents/kotlin      - Kotlin dev agent"
    echo "  agents/node        - Node.js dev agent"
    echo "  agents/nextjs      - Next.js dev agent"
    echo "  agents/python      - Python dev agent"
    echo "  agents/database    - Database architect agent"
    echo "  agents/devops      - DevOps engineer agent"
    echo "  agents/design      - Design analyst agent"
    echo "  agents/seo         - SEO auditor agent"
    echo "  agents/security    - Security auditor agent"
    echo "  agents/code-review - Code reviewer agent"
    exit 1
  fi

  separator "INSTALLING: $component"

  # Check if we're on main branch or have the component available
  local source_path=""

  case "$component" in
    # Personas
    persona/nova)
      source_path="persona/nova.md"
      ;;
    persona/blaze)
      source_path="persona/blaze.md"
      ;;
    # Agent shorthand
    agents/flutter)
      source_path="agents/flutter-dev-agent.md"
      ;;
    agents/kotlin)
      source_path="agents/kotlin-dev-agent.md"
      ;;
    agents/react-native)
      source_path="agents/react-native-dev-agent.md"
      ;;
    agents/ios)
      source_path="agents/ios-dev-agent.md"
      ;;
    agents/node)
      source_path="agents/node-dev-agent.md"
      ;;
    agents/nextjs)
      source_path="agents/nextjs-dev-agent.md"
      ;;
    agents/python)
      source_path="agents/python-dev-agent.md"
      ;;
    agents/database)
      source_path="agents/database-architect-agent.md"
      ;;
    agents/devops)
      source_path="agents/devops-engineer-agent.md"
      ;;
    agents/design)
      source_path="agents/design-analyst-agent.md"
      ;;
    agents/seo)
      source_path="agents/seo-auditor-agent.md"
      ;;
    agents/security)
      source_path="agents/security-auditor-agent.md"
      ;;
    agents/code-review)
      source_path="agents/code-reviewer-agent.md"
      ;;
    *)
      err "Unknown component: $component"
      cmd_list
      exit 1
      ;;
  esac

  # Copy from main branch (try git show first)
  local target_dir
  target_dir="$(dirname "$source_path")"

  mkdir -p "$target_dir"

  # Try to get from current repo
  if [[ -f "$TEMPLATE_ROOT/$source_path" ]]; then
    cp "$TEMPLATE_ROOT/$source_path" "$source_path"
    ok "Installed: $component"
  else
    # Try from git main branch
    if git -C "$TEMPLATE_ROOT" show "main:$source_path" > "$source_path" 2>/dev/null; then
      ok "Installed: $component (from main branch)"
    else
      err "Component '$component' not found"
      err "Make sure you're on the main branch or the component exists"
      exit 1
    fi
  fi
}

cmd_bundle() {
  local stack="$1"

  if [[ -z "$stack" ]]; then
    err "Stack name required"
    echo "Usage: ./bin/claude-setup.sh bundle [stack]"
    echo ""
    echo "Available stacks:"
    echo "  flutter         - Flutter/Dart (Riverpod, GoRouter, Dio)"
    echo "  kotlin          - Kotlin/Android (Compose, Retrofit, Room)"
    echo "  react-native    - React Native (Zustand, React Navigation)"
    echo "  ios             - iOS/Swift (SwiftUI, CoreData)"
    echo "  node            - Node.js/Express (JWT, Socket.io)"
    echo "  nextjs          - Next.js/React (App Router, Server Actions)"
    echo "  python          - Python/FastAPI (SQLAlchemy, Pydantic)"
    echo "  database        - Database (SQL, migrations, schema)"
    echo "  devops          - DevOps (Docker, CI/CD, deploy)"
    echo "  design          - Design (Figma, UI specs, tokens)"
    echo "  seo             - SEO (audit, content, performance)"
    echo "  security        - Security (audit, headers, secrets)"
    exit 1
  fi

  separator "BUNDLING: $stack"

  local count=0

  # Install commands
  if [[ -d "$TEMPLATE_ROOT/commands/$stack" ]]; then
    mkdir -p "commands/$stack"
    cp -r "$TEMPLATE_ROOT/commands/$stack/"* "commands/$stack/" 2>/dev/null || true
    count=$((count + $(find "commands/$stack" -name "*.md" | wc -l)))
    ok "Commands installed for $stack"
  else
    warn "No commands found for $stack"
  fi

  # Install skills
  if [[ -d "$TEMPLATE_ROOT/skills/$stack" ]]; then
    mkdir -p "skills/$stack"
    cp -r "$TEMPLATE_ROOT/skills/$stack/"* "skills/$stack/" 2>/dev/null || true
    count=$((count + $(find "skills/$stack" -name "*.md" | wc -l)))
    ok "Skills installed for $stack"
  else
    warn "No skills found for $stack"
  fi

  # Install agent
  local agent_name=""
  case "$stack" in
    flutter)       agent_name="flutter-dev-agent" ;;
    kotlin)        agent_name="kotlin-dev-agent" ;;
    react-native)  agent_name="react-native-dev-agent" ;;
    ios)           agent_name="ios-dev-agent" ;;
    node)          agent_name="node-dev-agent" ;;
    nextjs)        agent_name="nextjs-dev-agent" ;;
    python)        agent_name="python-dev-agent" ;;
    database)      agent_name="database-architect-agent" ;;
    devops)        agent_name="devops-engineer-agent" ;;
    design)        agent_name="design-analyst-agent" ;;
    seo)           agent_name="seo-auditor-agent" ;;
    security)      agent_name="security-auditor-agent" ;;
  esac

  if [[ -n "$agent_name" && -f "$TEMPLATE_ROOT/agents/$agent_name.md" ]]; then
    mkdir -p "agents"
    cp "$TEMPLATE_ROOT/agents/$agent_name.md" "agents/"
    count=$((count + 1))
    ok "Agent installed: $agent_name"
  else
    warn "No agent found for $stack"
  fi

  # Install guide
  local guide_name=""
  case "$stack" in
    flutter)       guide_name="flutter-patterns" ;;
    kotlin)        guide_name="kotlin-patterns" ;;
    react-native)  guide_name="react-native-patterns" ;;
    ios)           guide_name="ios-patterns" ;;
    node)          guide_name="node-patterns" ;;
    nextjs)        guide_name="nextjs-patterns" ;;
    python)        guide_name="python-patterns" ;;
    database)      guide_name="database-patterns" ;;
    devops)        guide_name="devops-workflows" ;;
    design)        guide_name="design-to-code" ;;
    seo)           guide_name="seo-checklist" ;;
    security)      guide_name="security-checklist" ;;
  esac

  if [[ -n "$guide_name" && -f "$TEMPLATE_ROOT/docs/guides/$guide_name.md" ]]; then
    mkdir -p "docs/guides"
    cp "$TEMPLATE_ROOT/docs/guides/$guide_name.md" "docs/guides/"
    count=$((count + 1))
    ok "Guide installed: $guide_name"
  fi

  echo ""
  ok "Bundle '$stack' complete ($count components installed)"
}

cmd_list() {
  separator "AVAILABLE COMPONENTS"

  echo ""
  echo "Stacks:"
  echo "  flutter         - Flutter/Dart"
  echo "  kotlin          - Kotlin/Android"
  echo "  react-native    - React Native"
  echo "  ios             - iOS/Swift"
  echo "  node            - Node.js/Express"
  echo "  nextjs          - Next.js/React"
  echo "  python          - Python/FastAPI"
  echo "  database        - Database/SQL"
  echo "  devops          - DevOps/Deploy"
  echo "  design          - Design/Figma"
  echo "  seo             - SEO/Content"
  echo "  security        - Security/Audit"
  echo ""
  echo "Personas:"
  echo "  nova            - Precision engineer"
  echo "  blaze           - Creative partner"
  echo ""
  echo "Agents:"
  echo "  flutter-dev-agent           kotlin-dev-agent"
  echo "  react-native-dev-agent      ios-dev-agent"
  echo "  node-dev-agent              nextjs-dev-agent"
  echo "  python-dev-agent            database-architect-agent"
  echo "  devops-engineer-agent       design-analyst-agent"
  echo "  seo-auditor-agent           security-auditor-agent"
  echo "  code-reviewer-agent"
  echo ""
  echo "Usage:"
  echo "  ./bin/claude-setup.sh bundle flutter      # Install all Flutter components"
  echo "  ./bin/claude-setup.sh install persona/nova # Install Nova persona"
  echo "  ./bin/claude-setup.sh install agents/node  # Install Node.js agent"
}

cmd_upgrade() {
  separator "CHECKING FOR UPDATES"

  if ! git -C "$TEMPLATE_ROOT" remote get-url origin &>/dev/null; then
    warn "No git remote configured"
    exit 0
  fi

  info "Fetching latest from remote..."
  git -C "$TEMPLATE_ROOT" fetch origin 2>/dev/null || {
    err "Failed to fetch from remote"
    exit 1
  }

  local current_branch
  current_branch=$(git -C "$TEMPLATE_ROOT" branch --show-current)

  local local_hash remote_hash
  local_hash=$(git -C "$TEMPLATE_ROOT" rev-parse HEAD)
  remote_hash=$(git -C "$TEMPLATE_ROOT" rev-parse "origin/$current_branch" 2>/dev/null || echo "")

  if [[ -z "$remote_hash" ]]; then
    warn "No remote branch found for $current_branch"
    exit 0
  fi

  if [[ "$local_hash" == "$remote_hash" ]]; then
    ok "Already up to date"
  else
    echo ""
    info "Updates available:"
    git -C "$TEMPLATE_ROOT" log --oneline HEAD.."$remote_hash"
    echo ""
    echo "To update: git pull origin $current_branch"
  fi
}

# ── Main ─────────────────────────────────────────────────

main() {
  local command="${1:-}"
  shift || true

  case "$command" in
    init)
      cmd_init "$@"
      ;;
    install)
      cmd_install "$@"
      ;;
    bundle)
      cmd_bundle "$@"
      ;;
    list)
      cmd_list
      ;;
    upgrade)
      cmd_upgrade
      ;;
    *)
      echo "Claude Template Setup CLI"
      echo ""
      echo "Usage:"
      echo "  ./bin/claude-setup.sh init [name]          Initialize new project"
      echo "  ./bin/claude-setup.sh install [component]  Install a component"
      echo "  ./bin/claude-setup.sh bundle [stack]       Install all for a stack"
      echo "  ./bin/claude-setup.sh list                 Show available components"
      echo "  ./bin/claude-setup.sh upgrade              Check for updates"
      echo ""
      echo "Stacks: flutter, kotlin, react-native, ios, node, nextjs,"
      echo "        python, database, devops, design, seo, security"
      ;;
  esac
}

main "$@"
