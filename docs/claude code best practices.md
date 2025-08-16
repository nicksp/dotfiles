# Claude Code Best Practices

Consider these suggestions as starting points when using Claude Code.

## Initial Configuration

1. Start with `CLAUDE.md` files with instructions for Claude to document commands, project architecture, style guidelines, and key context.
    1. Create in strategic locations
        1. project memory: `./CLAUDE.md` - share it with your team
        2. user memory: `~/.claude/CLAUDE.md` - personal preferences applied to all *claude* sessions
    2. Refine regularly
    3. Keep it concise and human-readable
    4. Use `# <text>` to add particular memory to the `CLAUDE.md` file
    5. Use `/memory` to edit the memory file directly
2. Curate allowed tools to reduce interruptions during coding sessions.
    1. Use the `/permissions` command
    2. Edit manually in `.claude/settings.json` (project-level) or `~/.claude.json` (user-level).
3. Integrate with IDE and GitHub
4. Connect with MCP servers
    1. `.mcp.json` in the project root
    2. Claude Code is very capable of running regular tools. So consider using MCP only if you need to give Claude access to something that it finds too hard to use otherwise. A good example is the [playwright-mcp](https://github.com/microsoft/playwright-mcp) for browser automation.
5. Add custom slash commands
    1. `.claude/commands/` for project-level commands
    2. `~/.claude/commands` for user-level commands

## Context Engineering

1. Be explicit and specific with your instructions.
    1. Specificity leads to better alignment with expectations.
    2. Tell LLM what it SHOULD do instead of what NOT to do.
2. Clear context regularly with `/clear` to maintain focused conversations.
    1. Even better, restart the *claude* session.
3. Add emphasis to instructions with "IMPORTANT" or "YOU MUST" as needed.
4. Use screenshots to guide and debug.
5. Course correction tools
    1. **Ask Claude to make a plan** before coding. Explicitly tell it not to code until you’ve confirmed its plan looks good.
    2. **Use Escape** — balance letting Claude work and interjecting at the right times. Press Escape once to stop. Press Escape twice to jump back in the conversation.
    3. **Ask Claude to undo changes**.
6. Use checklists and scratchpads for complex workflows.
7. Use terms like "deep dive", "comprehensive", "analyze", "evaluate", "assess", "research", or "make a report" to trigger thoroughness.
8. Use the word "think" to trigger extended thinking mode.
    1. "think" < "think hard" < "think harder" < "ultrathink"
        1. Extended thinking works really well if Claude already has something in context.
9. Match your prompt style to the desired response style.

## Common Workflows

### explore → plan → confirm → code → commit

Suitable for complex changes. First ask Claude to read relevant files and make a detailed plan. Verify Claude’s TODO list.

`plan mode` vs `auto-accept mode` vs `edit mode`:

- Verify what is about to be performed using plan mode.
- Once verified, proceed with auto-accept mode.
  - Bash commands will still require explicit approval, but file edits can be auto-accepted.
- Edit mode is the default mode with no auto-accept.

### tests → commit; code → iterate → commit

Leverage TDD and regular commits to have guardrails.

### code → screenshot results → iterate

Useful for UI development. Claude can iterate based on visual feedback if it has a way to check its work.

- <https://github.com/modelcontextprotocol/servers/tree/c19925b8f0f2815ad72b08d2368f0007c86eb8e6/src/puppeteer>
- <https://github.com/joshuayoes/ios-simulator-mcp>

### Codebase Q&A

Use Claude Code for learning and exploration by asking general questions about your code. No special prompting is required.

### Git & GitHub interactions

- Searching git history
- Writing commit messages
- Handling complex git operations
- Creating pull requests
- Fixing failing builds
- fixing comments on a PR

## Advanced Techniques

1. Consider using multi-Claude for tasks parallelization.
   1. While sub-agents should preserve context better, I often get better results by starting new sessions and writing thoughts to Markdown files.
2. Use YOLO mode (`claude --dangerously-skip-permissions`) to bypass all permission checks and let Claude work uninterrupted until completion.
3. Headless mode — use `claude -p "prompt"`

## Misc

1. When referencing @files from custom commands and `CLAUDE.md` files, do not wrap imports in markdown code spans and code blocks since they will not be evaluated
2. Piping into and out of:

    ```
    git status | claude -p "what are my changes?" --output-format=json | jq '.result'
    ```

3. Sometimes, simply explaining what you want in plain English and giving it clear instructions beats elaborate pre-written prompts.
4. Before automating anything, run the same task 3 times and check if you'd accept the results. If there's too much variation, it's not ready to automate.

## Useful Links

- [Claude Code: Best practices for agentic coding](https://www.anthropic.com/engineering/claude-code-best-practices)
- [Claude 4 best practices](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)
- [Common workflows](https://docs.anthropic.com/en/docs/claude-code/common-workflows)
- [Claude Code Memory Management](https://docs.anthropic.com/en/docs/claude-code/memory)
- [General Prompt Engineering](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/overview)
- [Prompt Engineering Tips](https://kilocode.ai/docs/advanced-usage/prompt-engineering)
- [Mastering Claude Code: Boris Cherny's Guide & Cheatsheet](https://www.nibzard.com/claude-code/)
