# Code Style Rules for Node.js

You MUST write valid TypeScript code, which uses Node.js version derived from the project (or, the latest LTM version for new projects) and follows best practices.

## Core Principles

- Always use ES6+ syntax.
- Always use the built-in `fetch` for HTTP requests, rather than libraries like `node-fetch` or `axios` unless they are already installed and used in the project.
- Always use Node.js `import`, never use `require`.
