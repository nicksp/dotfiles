import type { PluginAIAskResult, PluginAPI } from '@ampcode/plugin'

/**
 * Plugin that prevents risky git operations by asking the user for confirmation.
 * Uses amp.ai.ask() to classify git commands as risky and prompts the user accordingly.
 */
export default function (amp: PluginAPI) {
  const safePatterns = [
    /^\s*git\s+status\b/,
    /^\s*git\s+log\b/,
    /^\s*git\s+diff\b/,
    /^\s*git\s+show\b/,
    /^\s*git\s+branch\s*$/,
    /^\s*git\s+branch\s+-[av]\b/,
    /^\s*git\s+stash\s+list\b/,
    /^\s*git\s+remote\s+-v\b/,
    /^\s*git\s+fetch\b/,
    /^\s*git\s+pull\b/,
    /^\s*git\s+add\b/,
    /^\s*git\s+commit\b/,
  ]

  amp.on('tool.call', async (event, ctx) => {
    const shellCommand = amp.helpers.shellCommandFromToolCall(event)
    if (!shellCommand?.command) {
      return { action: 'allow' }
    }

    const command = shellCommand.command

    if (!/^\s*git\s+/.test(command)) {
      return { action: 'allow' }
    }

    if (safePatterns.some((pattern) => pattern.test(command))) {
      return { action: 'allow' }
    }

    const aiResponse: PluginAIAskResult = await ctx.ai.ask(
      `Does this git command look like a potentially destructive operation that could lose work? Answer yes if it's a destructive operation like force push, branch deletion, reset, or checkout to detached HEAD. Command: ${command}`
    )

    if (aiResponse.result === 'no') {
      return { action: 'allow' }
    }

    const confirmed = await ctx.ui.confirm({
      title: 'Potentially destructive git operation',
      message: `${command}\n\nReason: ${aiResponse.reason}\n\nDo you want to proceed?`,
      confirmButtonText: 'Allow',
    })

    if (confirmed) {
      return { action: 'allow' }
    }

    return {
      action: 'reject-and-continue',
      message: `User cancelled potentially destructive git operation: ${command}`,
    }
  })
}
