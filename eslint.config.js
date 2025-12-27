module.exports = [
  {
    ignores: [
      'coverage/**',
      'public/assets/**',
      'vendor/assets/**',
      'node_modules/**',
      'tmp/**'
    ]
  },
  {
    files: ['**/*.js'],
    languageOptions: {
      ecmaVersion: 2020,
      sourceType: 'module',
      globals: {
        console: 'readonly',
        window: 'readonly',
        document: 'readonly',
        jQuery: 'readonly',
        $: 'readonly'
      }
    },
    rules: {
      'no-unused-vars': ['warn', {
        'argsIgnorePattern': '^_',
        'varsIgnorePattern': '^_'
      }],
      'no-console': 'off'
    }
  }
];

