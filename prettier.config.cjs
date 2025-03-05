/**
 * @see https://prettier.io/docs/en/options
 * @type {import("prettier").Config}
 */
const config = {
  singleQuote: true,
  semi: false,
  trailingComma: 'es5',
  overrides: [
    {
      files: '*.md',
      options: {
        arrowParens: 'avoid',
        printWidth: 70,
        proseWrap: 'never',
        trailingComma: 'none',
      },
    },
    {
      files: 'firefox/user.js',
      options: {
        semi: true,
      },
    },
  ],
}

module.exports = config
