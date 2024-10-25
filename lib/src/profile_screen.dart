import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _raController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRA();
  }

  Future<void> _loadRA() async {
    User? user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        String? ra = doc.data()?['ra'];
        _raController.text = ra ?? '';
      }
    }
  }

  Future<void> _saveRA() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'ra': _raController.text,
      }, SetOptions(merge: true));

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('RA salvo com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _raController,
              decoration: const InputDecoration(
                labelText: 'RA',
                hintText: 'Digite seu RA',
              ),
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
