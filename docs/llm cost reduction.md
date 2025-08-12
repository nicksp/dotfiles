# LLM Usage Cost Reduction Tips

The cost depends mainly on _A)_ context size (i.e. how many tokens are fed to the LLM) and _B)_ the pricing of the model you’re using. Also the size of the output (i.e. how many tokens there are in the LLMs response) affects the price.

## TL;DR

- Smart context management
  - **Set up code indexing** if it helps
  - **Start fresh chat sessions** for new tasks
- Model switching
  - **Try Orchestrator mode** (if available) with model switching between modes
- Documentation
  - **Create memory file(s)** for your projects to hold the project knowledge and key context.

## Practical Steps

- For Gemini, if you want to keep things economical, you could set auto context condensing to 20%. That’ll keep you within the lower price (1.25 usd/million tokens) window, instead of the higher Gemini price (2.5 usd per million tokens).
- For all models (not just Gemini 2.5 pro) most important is to manage your context. Whenever you go over ~50% your calls get very expensive, and the quality goes down too. One way to reduce cost is to use the Orchestrator mode. It'll grab the context it needs for the greater task, break it down into smaller chunks, and fire off specific "code mode" tasks with only the context they need to achieve the task.
  - Before you start, go through each mode in the prompt window and select which model you want them to use.
    - **Orchestrator and Architect:** Claude Sonnet 4
    - **Code:** Gemini 2.5 Flash (or something similar like DeepSeek v3)
      - Smart models do the plan and design, and the cheap models to implement the plan.
- Give LLM the right context upfront so it doesn't need to constantly search for it and consume even more tokens.
  - Initialize [memory bank](https://kilocode.ai/docs/advanced-usage/memory-bank)
  - Create [steering documents](https://kiro.dev/docs/steering/)
    - `product.md` — Defines core feature and user flow
    - `tech.md` — Documents tech stack with development commands
    - `structure.md` — Outlines the project's organization, database schema, and architecture patterns
- Code indexing should also help you reduce cost, it does require some setup though.
- Use expensive models only where they’re actually relevant, and run the actual code generation on a cheaper model.
- Consider using CLI tools instead of MCP servers. Too many available tools can reduce model performance and consume more tokens.
  - Use MCP servers that expose a small number of high-level tools.
  - Disable MCP tools that you aren’t using.
- Keep it short, keep it focused. Break very large tasks up into smaller sub-tasks, one per chat session.
  - Otherwise you’re unnecessarily bloating the context with things that have nothing to do with what you’re asking.

## Helpful Pages

- [Control Your AI Development Budget Bleed](https://blog.kilocode.ai/p/control-your-ai-development-budget)
- [Memory Bank](https://kilocode.ai/docs/advanced-usage/memory-bank)
- [Orchestrator Mode: Coordinate Complex Workflows](https://kilocode.ai/docs/basic-usage/orchestrator-mode)
- [Codebase Indexing](https://kilocode.ai/docs/features/codebase-indexing)
- Model Temperature
  - <https://api-docs.deepseek.com/quick_start/parameter_settings>
  - <https://kilocode.ai/docs/features/model-temperature>
