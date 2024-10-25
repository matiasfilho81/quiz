import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  final String userName;
  final String ra;

  const HomePage({super.key, required this.userName, required this.ra});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _userId;
  String? _userEmail;
  String? _ra; // RA do usuário

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
        _userEmail = user.email;
      });

      // Buscar o RA do Firestore
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        setState(() {
          _ra = doc.data()?['ra'];
        });
      }
    }
  }

  void _goToProfile() {
    Navigator.of(context).pushNamed('/profile').then((_) => _loadUserData());
  }

  void _checkAndNavigate(String route) {
    if (_ra == null || _ra!.isEmpty) {
      _showRARequiredDialog();
    } else {
      Navigator.of(context).pushNamed(
        route,
        arguments: {
          'userName': widget.userName,
          'ra': _ra ?? 'RA não definido',
        },
      );
    }
  }

  void _showRARequiredDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('RA Necessário'),
        content: const Text(
          'Por favor, adicione seu RA no perfil antes de continuar.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _goToProfile();
            },
            child: const Text('Ir para Perfil'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Cabeçalho com o nome do usuário
            Text(
              'Olá, ${widget.userName}!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            // Texto explicativo sobre a prova
            const Text(
              'Bem-vindo à prova da Disciplina de Desenvolvimento WEB, '
              'ministrada pelo professor José Matias Lemes Filho.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),

            // Informações do usuário: Email, ID, Nome e RA
            _buildUserInfo('Email', _userEmail),
            _buildUserInfo('Id', _userId),
            _buildUserInfo('DisplayName', widget.userName),
            _buildUserInfo('RA', _ra ?? 'RA não cadastrado'),

            const SizedBox(height: 20),

            // Botões para editar o perfil e editar apenas o RA
            ElevatedButton(
              onPressed: _goToProfile,
              child: const Text('Editar Perfil'),
            ),

            const SizedBox(height: 30),

            const Text(
              'Por favor, preencha seu RA antes de começar o tutorial ou a prova.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            // Botões para iniciar o Tutorial e a Prova
            ElevatedButton(
              onPressed: () => _checkAndNavigate('/tutorial'),
              child: const Text('Iniciar Tutorial'),
            ),
            const SizedBox(height: 10),
            // ElevatedButton(
            //   onPressed: () => _checkAndNavigate('/exam'),
            //   child: const Text('Iniciar Prova'),
            // ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para exibir as informações do usuário
  Widget _buildUserInfo(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value ?? 'Não disponível'),
        ],
      ),
    );
  }
}
