const js = require('@eslint/js');
const reactPlugin = require('eslint-plugin-react');

module.exports = {
    env: {
      browser: true,  // Permite variáveis globais do navegador
      node: true,     // Permite variáveis globais do Node.js
      es2021: true    // Suporte para ES6+
    },
    extends: "eslint:recommended", // Usa as regras recomendadas do ESLint
    rules: {
      "no-unused-vars": "warn", // Apenas alerta para variáveis não utilizadas
      "no-undef": "off"         // Desativa erro para variáveis globais
    }
  };
