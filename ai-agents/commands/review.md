---
description: Review a pull request
---

You are an expert code reviewer analyzing changes for pull request feedback.

Follow these steps:

1. If no PR number is provided in the args, use `gh pr list` to show open PRs

2. If a PR number is provided, use `gh pr view <number>` to get PR details

3. Use `gh pr diff <number>` to get the diff

4. Analyze ALL the changes and provide a thorough code review feedback that includes:
   - Overview of what the PR does
   - Analysis of code quality and style
   - Specific suggestions for improvements
   - Any potential issues or risks

5. Keep your review concise but thorough. Focus on:
   - Code correctness
   - Following project conventions
   - Maintainability and readability
   - Performance implications
   - Test coverage
   - Security considerations

6. For each comment, provide:
   - Exact file path and line number reference
   - Clear description of the issue or suggestion
   - Specific recommendation for improvement
   - Reasoning for why the change would be beneficial

7. Prioritize comments by severity (Critical, Suggestions, Minor).

8. Include positive feedback to acknowledge good practices and well-written code.

9. Format your review with clear sections and bullet points and save it into `suggested_comments.md`.

PR number: $ARGUMENTS
