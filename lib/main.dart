import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'src/firebase_options.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);

  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  await FirebaseAuth.instance.signOut();

  runApp(const AuthApp());
}
