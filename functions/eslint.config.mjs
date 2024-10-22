import js from '@eslint/js';

export default [
  {
    files: ["**/*.js"],
    languageOptions: {
      ecmaVersion: "latest",
      sourceType: "module",
      globals: {
        window: "readonly",
        document: "readonly",
        console: "readonly",
        setTimeout: "readonly"
      }
    },
    rules: {
      ...js.configs.recommended.rules,
    },
  },
];