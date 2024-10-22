const questions = [
    {
        question: "Qual a capital da França?",
        answers: ["Madrid","Berlin","Paris","Roma"],
        correctAnswer: 2
    },
    {
        question: "Quem escreveru Romeu e Julieta?",
        answers: ["William Shakespeare", "Charles Dickens", "J.K. Rowling", "Mark Twain"],
        correctAnswer: 0
    },
    {
        question: "Qual o maior planeta do sistema solar?",
        answers: ["Terra", "Marte", "Vênus", "Jupiter"],
        correctAnswer: 3
    },
    {
        question: "Qual elemento possui o símbolo químico O?",
        answers: ["Hidrogênio", "Nitrogênio", "Oxigênio", "Carbono"],
        correctAnswer: 2
    },
    {
        question: "Em que ano a Segunda Guerra Mundial acabou?",
        answers: ["1942", "1945", "1939", "1941"],
        correctAnswer: 1
    },
    //5
    {
        question: "Qual a substância natural mais dura da Terra?",
        answers: ["Aço", "Diamante", "Ouro", "Prata"],
        correctAnswer: 1
    },
    {
        question: "Qual país é conhecido como a Terra do Sol Nascente?",
        answers: ["China", "Coréia", "Japão", "Tailândia"],
        correctAnswer: 2
    },
    {
        question: "Quantos continentes existem?",
        answers: ["5", "7", "6", "8"],
        correctAnswer: 1
    },
    {
        question: "Qual a fórmula química da água?",
        answers: ["CO2", "H2SO4", "H2O", "O2"],
        correctAnswer: 2
    },
    {
        question: "Qual a capital da Austrália?",
        answers: ["Sydney", "Melbourne", "Perth", "Canberra"],
        correctAnswer: 3
    },
    //10
    {
        question: "Qual o ingrediente principal do prato Guacamole?",
        answers: ["Tomate", "Abacate", "Cebola", "Cenoura"],
        correctAnswer: 1
    },
    {
        question: "Qual gás que as plantas absorvem da atmosfera?",
        answers: ["Oxigênio", "Dióxido de carbono", "Nitrogênio", "Hidrogênio"],
        correctAnswer: 1
    },
    {
        question: "Qual país sediou as Olimíadas de Verão de 2016?",
        answers: ["China", "Brasil", "Russia", "EUA"],
        correctAnswer: 1
    },
    {
        question: "Quem pintou Mona Lisa?",
        answers: ["Vincent van Gogh", "Leonardo da Vinci", "Pablo Picasso", "Michelangelo"],
        correctAnswer: 1
    },
    {
        question: "Qual a raíz quadrada de 64?",
        answers: ["8", "10", "12", "16"],
        correctAnswer: 0
    },
    //15
    {
        question: "Qual é o maior oceano?",
        answers: ["Atlântico", "Índico", "Pacífico", "Ártico"],
        correctAnswer: 2
    },
    {
        question: "Qual o planeta mais próximo do sol?",
        answers: ["Mercúrio", "Terra", "Marte", "Vênus"],
        correctAnswer: 0
    },
    {
        question: "Quantos lados tem um hexágono?",
        answers: ["5", "6", "7", "8"],
        correctAnswer: 1
    },
    {
        question: "Qual o menor país do mundo?",
        answers: ["Mônaco", "Cidade do Vaticano", "Liechtenstein", "San Marino"],
        correctAnswer: 1
    },
    {
        question: "Qual é a moeda do Japão?",
        answers: ["Yuan", "Won", "Dolar", "Yen"],
        correctAnswer: 3
    },
    //20
    {
        question: "Qual a capital do Canadá?",
        answers: ["Toronto", "Montreal", "Ottawa", "Vancouver"],
        correctAnswer: 2
    },
    {
        question: "Qual o planeta conhecido como Planta Vermelho?",
        answers: ["Marte", "Terra", "Jupiter", "Netuno"],
        correctAnswer: 0
    },
    {
        question: "Qual o maior deserto do mundo?",
        answers: ["Gobi", "Kalahari", "Sahara", "Arábia"],
        correctAnswer: 2
    },
    {
        question: "Qual o elemento mais abundante na atmosfera da Terra?",
        answers: ["Oxigênio", "Nitrogênio", "Hidrogênio", "Dióxido de carbono"],
        correctAnswer: 1
    },
    {
        question: "Qual país presenteou a Estátua da Liberdade para os Estados Unidos?",
        answers: ["Reino Unido", "França", "Itália", "Espanha"],
        correctAnswer: 1
    },
    //25
    {
        question: "Quem pintou o teto da Capela Sistina?",
        answers: ["Rafael", "Michelangelo", "Donatello", "Leonardo da Vinci"],
        correctAnswer: 1
    },
    {
        question: "Qual o maior país em extensão territorial?",
        answers: ["Canadá", "Estados Unidos", "China", "Rússia"],
        correctAnswer: 3
    },
    {
        question: "Qual o animal terrestre mais rápido?",
        answers: ["Leão", "Guepardo", "Gazella", "Leopardo"],
        correctAnswer: 1
    },
    {
        question: "Qual o rio mais longo do mundo?",
        answers: ["Amazonas", "Yangtze", "Nilo", "Mississippi"],
        correctAnswer: 2
    },
    {
        question: "Quem descobriu a gravidade?",
        answers: ["Galileo Galilei","Isaac Newton","Albert Einstein","Johannes Kepler"],
        correctAnswer: 1
    }
];

let selectedQuestions = [];
let currentQuestionIndex = 0;
let score = 0;
let immediateFeedback = false;

// Função para embaralhar e selecionar 10 perguntas aleatoriamente
function shuffleAndPickQuestions() {
    let shuffled = questions.sort(() => 0.5 - Math.random());
    selectedQuestions = shuffled.slice(0, 10);
}

// Iniciar o quiz com seleção de modo
function startQuiz(immediate) {
    immediateFeedback = immediate;
    document.getElementById('start-screen').style.display = 'none';
    document.getElementById('quiz-container').style.display = 'block';
    shuffleAndPickQuestions(); // Embaralhar e selecionar perguntas
    initQuiz();
}

function initQuiz() {
    currentQuestionIndex = 0;
    score = 0;
    loadQuestion();
}

function loadQuestion() {
    if (currentQuestionIndex < selectedQuestions.length) {
        const q = selectedQuestions[currentQuestionIndex];
        const questionContainer = document.getElementById('question-container');
        questionContainer.innerHTML = `<h3>${q.question}</h3>`;
        q.answers.forEach((answer, i) => {
            questionContainer.innerHTML += `<label>
                <input type="radio" name="question" value="${i}" onclick="enableNextButton()"> ${answer}
            </label>`;
        });

        // Inicialmente desativa o botão, mas o deixa visível
        const nextButton = document.getElementById('next-btn');
        nextButton.disabled = true; // Desativa o botão inicialmente
        nextButton.style.display = 'block'; // Garante que ele seja sempre exibido
    } else {
        showResults();
    }
}

function enableNextButton() {
    document.getElementById('next-btn').disabled = false; // Ativa o botão ao selecionar uma resposta
}

function selectAnswer() {
    const selectedAnswer = document.querySelector('input[name="question"]:checked');
    if (selectedAnswer) {
        const selectedIndex = parseInt(selectedAnswer.value);
        const correct = selectedQuestions[currentQuestionIndex].correctAnswer === selectedIndex;

        if (immediateFeedback) {
            document.getElementById('feedback').innerHTML = correct ? "Correct!" : "Wrong!";
            score += correct ? 1 : 0;
            document.getElementById('result').innerHTML = `Score: ${score}`;
        } else {
            score += correct ? 1 : 0;
        }

        // Avança para a próxima questão
        currentQuestionIndex++;
        setTimeout(() => {
            document.getElementById('feedback').innerHTML = ''; // Limpa o feedback após um breve delay
            loadQuestion();
        }, 1000); // Adiciona um pequeno delay antes de carregar a próxima pergunta
    }
}

function showResults() {
    const result = document.getElementById('result');
    result.innerHTML = `Final Score: ${score} out of ${selectedQuestions.length}`;
    document.getElementById('question-container').style.display = 'none';
    document.getElementById('next-btn').style.display = 'none';
    document.getElementById('feedback').style.display = 'none';
}

function nextQuestion() {
    selectAnswer(); // Executa a verificação de resposta
}

window.onload = () => {
    document.getElementById('start-screen').style.display = 'block';
    document.getElementById('quiz-container').style.display = 'none';
};