Aqui está o conteúdo formatado para que você possa copiá-lo e colar diretamente no seu README.md:

# Quiz App - Firebase Deployment Guide

## Pré-requisitos

Certifique-se de ter as seguintes ferramentas instaladas:

- **Node.js**: [Download Node.js](https://nodejs.org)
- **Firebase CLI**: Instale com o comando:
  ```bash
  npm install -g firebase-tools

Login no Firebase

Faça login no Firebase:

firebase login

Passo 1: Selecionar o Projeto

Verifique se você está usando o projeto correto do Firebase:

firebase use quiz-4da91

Se o projeto não estiver configurado, adicione-o:

firebase use --add quiz-4da91

Passo 2: Testar Localmente (Opcional)

Antes de fazer o deploy, é recomendável testar o projeto localmente:

firebase serve --only functions,hosting

Isso inicia um servidor local para testar suas funções e o hosting.

Passo 3: Fazer o Deploy

Após verificar que tudo está funcionando corretamente, faça o deploy com:

firebase deploy --only functions,hosting

Passo 4: Resolução de Erros

Se encontrar erros durante o deploy, use o modo debug para mais detalhes:

firebase deploy --only functions,hosting --debug

Dica: Deploy de Funções Específicas

Se quiser enviar apenas uma função específica:

firebase deploy --only functions:nomeDaFuncao

Verificar no Console do Firebase

Após o deploy, acesse o Firebase Console e confirme se as funções e o hosting foram atualizados corretamente.

Resumo dos Comandos

	1.	Login no Firebase:

firebase login


	2.	Selecionar projeto:

firebase use quiz-4da91


	3.	Testar localmente:

firebase serve --only functions,hosting


	4.	Fazer deploy completo:

firebase deploy --only functions,hosting


	5.	Fazer deploy apenas do hosting:

firebase deploy --only hosting


	6.	Deploy de função específica:

firebase deploy --only functions:nomeDaFuncao


	7.	Modo debug:

firebase deploy --only functions,hosting --debug



Arquitetura do Projeto

/quiz
│
├── /functions              # Código das funções Firebase
│   ├── node_modules        # Dependências
│   ├── eslint.config.mjs   # Configuração do ESLint
│   ├── index.js            # Funções principais
│   ├── firebase-config.js  # Configuração do Firebase
│   ├── package.json        # Dependências do projeto
│   ├── package-lock.json   # Registro das dependências instaladas
│   ├── script.js           # Scripts auxiliares
│
├── /public                 # Arquivos de hosting
│   ├── index.html          # Página principal do projeto
│   ├── styles.css          # Estilos CSS
│
├── .eslintrc.json          # Configurações do ESLint
├── .firebaserc             # Configurações do Firebase CLI
├── .gitignore              # Arquivos a serem ignorados no Git
├── firebase.json           # Configurações globais do Firebase
├── firestore.rules         # Regras de segurança do Firestore
├── firestore.indexes.json  # Configuração de índices do Firestore
└── README.md               # Documentação do projeto

Com este guia detalhado, qualquer colaborador do projeto terá instruções claras para configurar e fazer o deploy no Firebase, além de uma visão geral da estrutura do projeto.

