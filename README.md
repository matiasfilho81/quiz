# Quiz App - Guia de Deploy no Firebase

## 📋 Pré-requisitos

Certifique-se de ter as seguintes ferramentas instaladas:

- **[Node.js](https://nodejs.org)**  
- **Firebase CLI**: Instale com o comando:
  ```bash
  npm install -g firebase-tools

🔐 Login no Firebase

Faça login na sua conta do Firebase:

firebase login

🎯 Passo 1: Selecionar o Projeto

Verifique se você está usando o projeto correto:

firebase use quiz-4da91

Caso o projeto ainda não esteja configurado:

firebase use --add quiz-4da91

🛠️ Passo 2: Testar Localmente (Opcional)

Antes de realizar o deploy, é recomendável testar o projeto localmente:

firebase serve --only functions,hosting

Esse comando inicia um servidor local para verificar se tudo está funcionando corretamente.

🚀 Passo 3: Realizar o Deploy

Se tudo estiver funcionando corretamente, faça o deploy do projeto com:

firebase deploy --only functions,hosting

🛑 Resolução de Erros

Caso ocorra algum erro durante o deploy, utilize o modo debug para mais detalhes:

firebase deploy --only functions,hosting --debug

Dica: Deploy de Funções Específicas

Para enviar apenas uma função específica:

firebase deploy --only functions:nomeDaFuncao

📊 Verificar no Firebase Console

Após o deploy, acesse o Firebase Console e confirme se as funções e o hosting foram atualizados corretamente.

📝 Resumo dos Comandos

	1.	Login no Firebase:

firebase login


	2.	Selecionar Projeto:

firebase use quiz-4da91


	3.	Testar Localmente:

firebase serve --only functions,hosting


	4.	Deploy Completo:

firebase deploy --only functions,hosting


	5.	Deploy Apenas do Hosting:

firebase deploy --only hosting


	6.	Deploy de Função Específica:

firebase deploy --only functions:nomeDaFuncao


	7.	Modo Debug:

firebase deploy --only functions,hosting --debug

<!-- ## 📁 Arquitetura do Projeto -->
<!-- 
/quiz
├── /functions               # Código das funções Firebase
│   ├── node_modules         # Dependências do projeto
│   ├── eslint.config.mjs    # Configuração do ESLint
│   ├── index.js             # Funções principais do projeto
│   ├── firebase-config.js   # Configuração do Firebase
│   ├── package.json         # Gerenciamento de dependências
│   ├── package-lock.json    # Registro exato das dependências instaladas
│   └── script.js            # Scripts auxiliares para lógica do projeto
│
├── /public              
│   ├── index.html       # Página principal
│   ├── styles.css       # Estilos CSS
│   ├── /data            
│   │   └── questions.json  # Arquivo de perguntas
│   └── script.js        # Lógica do Quiz
│
├── .eslintrc.json           # Configurações adicionais do ESLint
├── .firebaserc              # Configuração do Firebase CLI
├── .gitignore               # Arquivos a serem ignorados pelo Git
├── firebase.json            # Configurações gerais do Firebase
├── firestore.rules          # Regras de segurança do Firestore
├── firestore.indexes.json   # Configuração de índices do Firestore
└── README.md                # Documentação do projeto
 -->

