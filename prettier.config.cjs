/** @type {import("prettier").Config} */
const config = {
  trailingComma: 'es5',
  semi: false,
  singleQuote: true,
  plugins: ['prettier-plugin-sh'],
  overrides: [
    {
      files: '*.md',
      options: {
        arrowParens: 'avoid',
        proseWrap: 'never',
        trailingComma: 'none',
      },
    },
  ],
}

module.exports = config
