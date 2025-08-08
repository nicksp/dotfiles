# Agentic Development System

A collection of specialized system prompts and slash commands for AI agents to accelerate software development workflows.

> [!IMPORTANT]
> This is the automation for the most essential **global** commands and instructions ONLY.

## Supported AI Agents

- [x] Cursor
- [x] Claude Code
- [x] Kilo Code

## What It Does

1. Sets up core rules and instructions that are automatically included in every chat request to guide AI assistants.
2. Automates\* [commands](./commands/).
3. Automates\* [agents](./claude-code/agents/).
4. Automates\* [MCP servers](./mcp.json).

> **Note:** Some tools don't have an appropriate global configuration and require installation into a project folder.

## Installation

Run symlinks init script and follow the steps bellow for an extra manual configuration.

```bash
$HOME/dotfiles/setup/symlinks.sh
```

### Add LLM instructions

Helps LLM powered tools like Cursor and Claude Code understand how to interact with our codebase. These add some base user-level instructions to define some essential standards that _should_ work no matter the project: LLM behavior, code style, essential best practices.

#### How to use

1. **Cursor**: Paste [file content](./agent-instructions.md) in your project's `.cursorrules` file
2. **Claude Code**: Paste [file content](./agent-instructions.md) in `~/.claude/CLAUDE.md` (automated ✔️)
3. **Kilo Code**: Paste [file content](./agent-instructions.md) in `~/.kilocode/rules/agent-instructions.md` (automated ✔️)

### Add MCP servers

#### How to use

1. **Cursor**: Paste [file content](./mcp.json) in `~/.cursor/mcp.json` (automated ✔️)
2. **Claude Code**: Paste [file content](./mcp.json) in `~/.claude.json` or your project's `.mcp.json` file
3. **Kilo Code**: Paste [file content](./mcp.json) in your project's `.kilocode/mcp.json` file

#### Available servers

- [Context7 MCP Server](https://github.com/upstash/context7)
- [Neon MCP Server](https://github.com/neondatabase-labs/mcp-server-neon)
- [Playwright MCP Server](https://github.com/microsoft/playwright-mcp)

### Add slash commands

#### How to use

1. **Cursor**: Copy the [command files](./commands/) to your project's `.cursor/commands/`
2. **Claude Code**: Copy the [command files](./commands/) to `~/.claude/commands/` (automated ✔️)
3. **Kilo Code**: Copy the [command files](./commands/) to `~/.kilocode/workflows/` (automated ✔️)

#### Available commands

- `/cleanup` — Perform codebase maintenance and refinement (?? doesn't seem to be realiable yet)
- `/explain` — Explain how project or a particular feature works
- `/fix` — Pull and fix a GitHub issue
- `/review` — Review a pull request
- `/blog:fix-grammar` — Fix grammatical mistakes
- `/blog:fix-wording` — Fix poor wording and sentence structure

### Add subagents

Specialized [subagents](https://docs.anthropic.com/en/docs/claude-code/sub-agents) that extend Claude Code's capabilities. All agents are configured with specific models based on task complexity for optimal performance and cost-effectiveness.

#### How to use

1. **Claude Code**: Copy the [agent files](./claude-code/agents/) to `~/.claude/agents/` (automated ✔️)

#### Available agents

- `architect-reviewer` — Reviews code changes for architectural consistency and patterns
- `code-reviewer` - Expert code review specialist

#### Other tools

1. **Cursor**: [Background agents](https://docs.cursor.com/en/background-agent) have their own format and require MAX Mode models to use.
2. **Kilo Code**: Achieves similar results via using the built-in [Orchestrator mode](https://kilocode.ai/docs/basic-usage/orchestrator-mode).
