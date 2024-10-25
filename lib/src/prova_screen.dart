import 'package:flutter/material.dart';

class ProvaScreen extends StatelessWidget {
  const ProvaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prova'),
      ),
      body: Center(
        child: Text(
          'Conteúdo da Prova',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
