# Agentic Development System

A collection of specialized system prompts and slash commands for AI agents to accelerate software development workflows.

> [!IMPORTANT]
> This is the automation for the most essential **global** commands and instructions ONLY.

## Supported AI Agents

- [x] Cursor
- [x] Amp

## What It Does

1. Sets up core rules and instructions that are automatically included in every chat request to guide AI assistants.
2. Automates\* [commands](./commands/).
3. Automates\* [MCP servers](./mcp.json).

> [!NOTE]
> Some tools don't have an appropriate global configuration and require installation into a project's folder.

## Installation

Run symlinks init script and follow the steps bellow for an extra manual configuration.

```bash
$HOME/dotfiles/setup/symlinks.sh
```

### Add LLM instructions

Helps LLM powered tools like Cursor and Amp understand how to interact with our codebase. These add some base user-level instructions to define some essential standards that _should_ work no matter the project: LLM behavior, code style, essential best practices.

#### How to use

1. **Cursor**: Paste [file content](./agent-instructions.md) in `AGENTS.md` file at the project root
2. **Amp**: Paste [file content](./agent-instructions.md) in `~/.config/AGENTS.md` (automated ✔️)

### Add MCP servers

#### How to use

1. **Cursor**: Paste [file content](./mcp.json) in `~/.cursor/mcp.json` (automated ✔️)
2. **Amp**: Paste [file content](./mcp.json) in `~/.config/amp/settings.json` as `amp.mcpServers` and in VS Code settings as `amp.mcpServers` (automated ✔️)

#### Available servers

- [Playwright MCP Server](https://github.com/microsoft/playwright-mcp)
- [Context7 MCP Server](https://github.com/upstash/context7)

### Add slash commands

#### How to use

1. **Cursor**: Copy the [command files](./commands/) to `~/.cursor/commands/` (automated ✔️)
2. **Amp**: Copy the [command files](./commands/) to `~/.config/amp/commands/` (automated ✔️)

#### Available commands

- `/blog-fix-grammar` — Fix grammatical mistakes
- `/blog-fix-wording` — Fix poor wording and sentence structure
- `/explain` — Explain how project or a particular feature works
- `/review` — Review a pull request
- `/security-review` — Complete a security review of the pending changes on the current branch

## References

- [AGENTS.md](https://agents.md/)
- [AI coding workflow](https://github.com/nicksp/ai-coding-worflow): my custom prompts for AI agents
- [Claude Code security review action](https://github.com/anthropics/claude-code-security-review)
