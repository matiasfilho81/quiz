async function loadQuestions() {
    try {
        const response = await fetch('/data/questions.json');
        if (!response.ok) throw new Error('Erro ao carregar as perguntas.');
        const questions = await response.json();
        return questions;
    } catch (error) {
        console.error(error);
        alert('Não foi possível carregar as perguntas. Verifique o caminho do arquivo.');
    }
}

let currentQuestionIndex = 0;
let score = 0;
let questions = [];

window.onload = async () => {
    questions = await loadQuestions();
    if (questions && questions.length > 0) {
        showQuestion();
    } else {
        alert('Nenhuma pergunta encontrada!');
    }
};

function showQuestion() {
    const questionContainer = document.getElementById('question-container');
    questionContainer.innerHTML = ''; // Limpa o conteúdo anterior

    const question = questions[currentQuestionIndex];
    const div = document.createElement('div');
    div.className = 'question'; // Adiciona uma classe para estilização (opcional)

    // Exibe a pergunta
    div.innerHTML = `<h3>${question.question}</h3>`;

    // Adiciona as respostas
    question.answers.forEach((answer, index) => {
        div.innerHTML += `
            <label>
                <input type="radio" name="question${currentQuestionIndex}" value="${index}"> ${answer}
            </label><br>`;
    });

    questionContainer.appendChild(div);

    // Desativa o botão "Próxima Pergunta" até que uma resposta seja selecionada
    const nextButton = document.getElementById('next-button');
    nextButton.disabled = true;

    document.querySelectorAll(`input[name="question${currentQuestionIndex}"]`).forEach(input => {
        input.addEventListener('change', () => {
            nextButton.disabled = false;
        });
    });
}

function nextQuestion() {
    const selectedAnswer = document.querySelector(`input[name="question${currentQuestionIndex}"]:checked`);
    if (selectedAnswer && parseInt(selectedAnswer.value) === questions[currentQuestionIndex].correctAnswer) {
        score++;
    }

    currentQuestionIndex++;
    if (currentQuestionIndex < questions.length) {
        showQuestion();
    } else {
        showResult();
    }
}

function showResult() {
    const questionContainer = document.getElementById('question-container');
    questionContainer.innerHTML = `<h2>Seu placar: ${score} de ${questions.length}</h2>`;

    const nextButton = document.getElementById('next-button');
    nextButton.style.display = 'none'; // Oculta o botão após o fim do quiz
}