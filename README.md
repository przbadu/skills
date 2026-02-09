# Claude Code Skills

A collection of modular, specialized AI skills that extend Claude Code's capabilities with domain-specific knowledge, workflows, and tool integrations.

## Available Skills

| Skill | Description |
|-------|-------------|
| **agent-browser** | Browser automation CLI for AI agents (navigate, fill forms, click, screenshot, scrape) |
| **algorithmic-art** | Create generative algorithmic art using p5.js |
| **brand-guidelines** | Anthropic brand colors, typography, and styling |
| **canvas-design** | Create visual art and designs in PNG and PDF |
| **doc-coauthoring** | Structured workflow for collaborative documentation |
| **docx** | Word document creation, editing, and analysis |
| **frontend-design** | Production-grade frontend interfaces with React/HTML/CSS |
| **internal-comms** | Internal communication templates (updates, newsletters, FAQs) |
| **mcp-builder** | Guide for building Model Context Protocol (MCP) servers |
| **pdf** | PDF processing: merge, split, extract, fill forms, OCR |
| **pptx** | PowerPoint presentation creation and editing |
| **skill-creator** | Meta-skill for creating new skills |
| **slack-gif-creator** | Create animated GIFs optimized for Slack |
| **theme-factory** | Apply professional themes to artifacts |
| **web-artifacts-builder** | Build complex claude.ai HTML artifacts with React/Tailwind |
| **webapp-testing** | Playwright-based web app testing toolkit |
| **xlsx** | Excel/spreadsheet creation, analysis, and editing |

## Prerequisites

Most skills work out of the box with Claude Code. Some skills require external tools to be installed first.

### agent-browser

The **agent-browser** skill requires the `agent-browser` CLI to be installed. Choose one of the following methods:

**NPM (Recommended)**

```bash
npm install -g agent-browser
agent-browser install  # Downloads Chromium
```

**Homebrew (macOS)**

```bash
brew install agent-browser
agent-browser install  # Downloads Chromium
```

**From Source**

```bash
git clone https://github.com/vercel-labs/agent-browser
cd agent-browser
pnpm install
pnpm build
pnpm build:native  # Requires Rust (https://rustup.rs)
pnpm link --global
agent-browser install
```

**Linux users** — install system dependencies with:

```bash
agent-browser install --with-deps
```

## Installation

Claude Code discovers skills automatically from two locations:

- **Personal** (all projects): `~/.claude/skills/<skill-name>/`
- **Project** (single project): `.claude/skills/<skill-name>/`

### Install all skills (personal)

Symlink or copy the entire collection so every skill is available in all your projects:

```bash
# Clone the repo
git clone <repo-url> ~/dev/skills

# Symlink each skill into your personal skills directory
mkdir -p ~/.claude/skills
for skill in ~/dev/skills/*/; do
  skill_name=$(basename "$skill")
  [ -f "$skill/SKILL.md" ] && ln -sf "$skill" ~/.claude/skills/"$skill_name"
done
```

### Install a single skill (personal)

```bash
mkdir -p ~/.claude/skills
ln -sf ~/dev/skills/pdf ~/.claude/skills/pdf
```

### Install for a specific project

```bash
cd /path/to/your/project
mkdir -p .claude/skills
ln -sf ~/dev/skills/pdf .claude/skills/pdf
```

### Verify installation

Open Claude Code and type `/` — your installed skills will appear in the autocomplete list. You can invoke any skill directly (e.g., `/pdf`, `/docx`) or let Claude use them automatically based on your request.

## Creating a New Skill

Use the skill-creator to scaffold a new skill:

```bash
python skill-creator/scripts/init_skill.py <skill-name> --path <output-directory>
```

See the [skill-creator SKILL.md](skill-creator/SKILL.md) for the full authoring guide.
