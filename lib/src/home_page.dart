import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String userName;

  const HomePage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo, $userName'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/tutorial',
                  arguments: userName,
                );
              },
              child: const Text('Iniciar Tutorial'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/prova');
              },
              child: const Text('Iniciar Prova'),
            ),
          ],
        ),
      ),
    );
  }
}
