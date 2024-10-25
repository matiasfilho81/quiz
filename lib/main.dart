import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'src/auth_app.dart';
import 'src/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);

  await FirebaseAuth.instance
      .signOut(); // Opcional: Garantir que o usuário começa deslogado

  runApp(const AuthApp()); // Executar a aplicação de autenticação.
}
