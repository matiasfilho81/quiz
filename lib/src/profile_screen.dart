import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _raController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRA(); // Carregar o RA existente (se houver) ao iniciar a tela
  }

  Future<void> _loadRA() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists) {
        String? ra = doc.data()?['ra'];
        _raController.text =
            ra ?? ''; // Preenche o campo com o RA se disponível
      }
    }
  }

  Future<void> _saveRA() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
          {'ra': _raController.text},
          SetOptions(merge: true), // Mesclar com os dados existentes
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('RA salvo com sucesso!')),
        );

        Navigator.of(context).pop(); // Voltar após salvar
      } catch (e) {
        // print('Erro ao salvar RA: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao salvar RA. Tente novamente.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar RA'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _raController,
              decoration: const InputDecoration(labelText: 'RA'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveRA,
              child: const Text('Salvar RA'),
            ),
          ],
        ),
      ),
    );
  }
}
