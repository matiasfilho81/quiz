# Quiz App - Firebase Deployment Guide

# Pré-requisitos

Certifique-se de ter as seguintes ferramentas instaladas:

    • Node.js
    • Firebase CLI

# Faça login no Firebase com:

firebase login

# Passo 1: Selecionar o projeto correto

Verifique se você está usando o projeto correto do Firebase:

firebase use quiz-4da91

Se o projeto não estiver configurado, adicione-o:

firebase use --add quiz-4da91

# Passo 2: Testar localmente (Opcional)

Antes de fazer o deploy, é recomendável testar o projeto localmente:

firebase serve --only functions,hosting

Este comando inicia um servidor local para testar suas funções e o hosting.

# Passo 3: Fazer o Deploy

Após verificar que tudo está funcionando corretamente, faça o deploy do seu projeto com:

firebase deploy --only functions,hosting

# Passo 4: Resolução de Erros

Se encontrar algum erro durante o deploy, use o modo debug para mais detalhes:

firebase deploy --only functions,hosting --debug

Dica: Deploy de Funções Específicas

Se quiser enviar apenas uma função específica:

firebase deploy --only functions:nomeDaFuncao

Verificar no Console do Firebase

Após o deploy, vá até o Firebase Console para garantir que as funções e o hosting foram atualizados corretamente.

# Resumo dos Comandos

	1.	Login no Firebase: firebase login
	2.	Selecionar projeto: firebase use quiz-4da91
	3.	Testar localmente: firebase serve --only functions,hosting
	4.	Fazer deploy completo: firebase deploy --only functions,hosting
	5.	Deploy de função específica: firebase deploy --only functions:nomeDaFuncao
	6.	Modo debug: firebase deploy --only functions,hosting --debug

Com este guia no seu README.md, qualquer pessoa que trabalhar no projeto terá instruções claras para configurar e fazer o deploy do aplicativo no Firebase.

# Arquitetura

/quiz
│
├── /functions           # Código das funções Firebase
│   ├── node_modules     # Dependências
│   ├── eslint.config.js # Configuração do ESLint
│   ├── index.js         # Funções principais
│   ├── firebase-config.js # Configuração do Firebase
│   ├── package.json     # Dependências do projeto
│   ├── package-lock.json # Registro das dependências instaladas
│   ├── script.js        # Scripts auxiliares
│
├── /public              # Arquivos de hosting
│   ├── index.html       # Página principal do projeto
│   ├── styles.css       # Estilos CSS
│
├── .eslintrc.json       # Configurações do ESLint
├── .firebaserc          # Configurações do projeto Firebase CLI
├── .gitignore           # Arquivos a serem ignorados no Git
├── firebase.json        # Configurações globais do Firebase
├── firestore.rules      # Regras de segurança do Firestore
├── firestore.indexes.json # Configuração de índices do Firestore
└── README.md            # Documentação do projeto

index.html: Contém a estrutura da interface web.
styles.css: Arquivo com a estilização da página.
firebase-config.js: Configuração do Firebase.
index.js: Arquivo principal onde o Firebase é importado e inicializado.