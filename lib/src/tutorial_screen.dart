import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  TutorialScreenState createState() => TutorialScreenState();
}

class TutorialScreenState extends State<TutorialScreen> {
  List<dynamic> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  Timer? _timer;
  int _timeRemaining = 60;
  bool _answered = false;
  int? _selectedAnswer; // Armazena a alternativa escolhida

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadQuestions() async {
    try {
      final String response =
          await rootBundle.loadString('assets/questions.json');
      final List<dynamic> data = json.decode(response);
      setState(() {
        _questions = _getRandomQuestions(data, 5);
      });
      _startTimer();
    } catch (e) {
      _showErrorDialog('Erro ao carregar perguntas.');
    }
  }

  List<dynamic> _getRandomQuestions(List<dynamic> data, int count) {
    data.shuffle(Random());
    return data.take(count).toList();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _nextQuestion();
      }
    });
  }

  void _nextQuestion() {
    _timer?.cancel();
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _timeRemaining = 60;
        _answered = false;
        _selectedAnswer = null; // Resetar a seleção para a próxima questão
      });
      _startTimer();
    } else {
      _showFinalScore();
    }
  }

  void _checkAnswer() {
    if (_answered || _selectedAnswer == null) return;

    setState(() {
      _answered = true;
      if (_selectedAnswer ==
          _questions[_currentQuestionIndex]['correctAnswer']) {
        _score++;
      }
    });

    Future.delayed(const Duration(seconds: 2), _nextQuestion);
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resultado Final'),
        content:
            Text('Você acertou $_score de ${_questions.length} perguntas!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
              Navigator.of(context).pop(); // Volta para a tela anterior
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erro'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Tutorial')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Pergunta ${_currentQuestionIndex + 1} de ${_questions.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question['question'],
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            ...List.generate(question['answers'].length, (index) {
              return RadioListTile<int>(
                title: Text(question['answers'][index]),
                value: index,
                groupValue: _selectedAnswer,
                onChanged: _answered
                    ? null // Desativa a seleção se a questão já foi respondida
                    : (value) {
                        setState(() {
                          _selectedAnswer = value;
                        });
                      },
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _answered
                  ? null
                  : _checkAnswer, // Botão desativado após responder
              child: const Text('Confirmar'),
            ),
            const Spacer(),
            Text(
              'Tempo restante: $_timeRemaining segundos',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
