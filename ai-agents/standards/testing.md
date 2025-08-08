# Testing Guidelines

## General

- Always use English in tests.
- Always test edge cases, valid scenarios, and error conditions.
- Follow DRY principles and avoid duplication. Don't over-DRY at the cost of clarity; duplication is acceptable if it improves readability.
- Use shared examples for repeated behaviors.
- Do not test external dependencies.

## Layout

- Do not leave empty lines after `describe` declarations.
- Leave one empty line between example groups (`describe`).
- Leave one empty line after `beforeEach`/`beforeAll`, and `afterEach`/`afterAll` blocks.
- Leave one empty line around each `it` block.
- Separate test phases (setup, exercise, assertion) with one empty line.

## Example Structure

- One expectation per example (`it`). If an example description contains 'and', it probably contains more than one expectation.
- Keep example descriptions short and clear.

## Naming

- Do not use 'should' in example descriptions. Use present tense, third person.
- Be explicit in `describe` blocks about what is being tested.

## Stubbing & Mocks

- Mock/stub only when necessary. Prefer real objects for integration tests.
- Stub HTTP requests instead of hitting real services.
