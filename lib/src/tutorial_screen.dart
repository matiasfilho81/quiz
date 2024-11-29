import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TutorialScreen extends StatefulWidget {
  final String userName;
  final String ra;

  const TutorialScreen({super.key, required this.userName, required this.ra});

  @override
  TutorialScreenState createState() => TutorialScreenState();
}

class TutorialScreenState extends State<TutorialScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<dynamic> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  Timer? _timer;
  int _timeRemaining = 60;
  bool _answered = false;
  int? _selectedAnswer;
  final List<Map<String, dynamic>> _userAnswers = [];

  late DateTime _startTime;
  late DateTime _endTime;

  late bool
      _showScorePerQuestion; // Variável para definir o grupo do experimento

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _showScorePerQuestion = false; //Random().nextBool(); // Sorteio para A/B
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
        _selectedAnswer = null;
      });
      _startTimer();
    } else {
      _endTime = DateTime.now();
      _saveResultsToFirestore();
    }
  }

  void _checkAnswer() {
    if (_answered || _selectedAnswer == null) return;

    setState(() {
      _answered = true;
      bool correct =
          _selectedAnswer == _questions[_currentQuestionIndex]['correctAnswer'];
      if (correct) _score++;

      _userAnswers.add({
        'question': _questions[_currentQuestionIndex]['question'],
        'selectedAnswer': _selectedAnswer,
        'correctAnswer': _questions[_currentQuestionIndex]['correctAnswer'],
        'isCorrect': correct,
        'timestamp': DateTime.now().toIso8601String(),
      });
    });

    if (_showScorePerQuestion) {
      _showQuestionScore();
    } else {
      Future.delayed(const Duration(seconds: 2), _nextQuestion);
    }
  }

  void _showQuestionScore() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resultado da Questão'),
        content: Text(
          _userAnswers[_currentQuestionIndex]['isCorrect']
              ? 'Você acertou esta questão!'
              : 'Você errou esta questão.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _nextQuestion();
            },
            child: const Text('Próxima'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveResultsToFirestore() async {
    Duration totalDuration = _endTime.difference(_startTime);
    double averageTimePerQuestion = totalDuration.inSeconds / _questions.length;
    
    try {
      await _firestore.collection('quiz_results').add({
        'userName': widget.userName,
        'ra': widget.ra,
        'score': _score,
        'answers': _userAnswers,
        'totalDuration': totalDuration.inSeconds,
        'averageTimePerQuestion': averageTimePerQuestion,
        'showScorePerQuestion': _showScorePerQuestion, // Experimento A/B
        'timestamp': FieldValue.serverTimestamp(),
      });

      _showFinalScore();
    } catch (e) {
      _showErrorDialog('Erro ao salvar resultados.');
    }
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
              Navigator.of(context).pop();
              Navigator.of(context).pop();
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
              Navigator.of(context).pop();
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
        automaticallyImplyLeading: false,
        title: Text(
          'Pergunta ${_currentQuestionIndex + 1} de ${_questions.length}',
        ),
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
                    ? null
                    : (value) {
                        setState(() {
                          _selectedAnswer = value;
                        });
                      },
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _answered ? null : _checkAnswer,
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
