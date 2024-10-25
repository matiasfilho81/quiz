import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase_ui;
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'profile_screen.dart' as local;
import 'test_screen.dart';
import 'tutorial_screen.dart';

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) {
          return firebase_ui.SignInScreen(
            actions: [
              firebase_ui.ForgotPasswordAction(
                (context, email) {
                  Navigator.of(context).pushNamed(
                    '/forgot-password',
                    arguments: email,
                  );
                },
              ),
              firebase_ui.AuthStateChangeAction(
                (context, state) {
                  if (state is firebase_ui.UserCreated ||
                      state is firebase_ui.SignedIn) {
                    var user = (state is firebase_ui.SignedIn)
                        ? state.user
                        : (state as firebase_ui.UserCreated).credential.user;
                    if (user == null) return;

                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home',
                      (_) => false,
                      arguments: {
                        'userName': user.displayName ?? user.email ?? 'Usuário',
                        'ra': '', // RA pode ser preenchido depois no perfil
                      },
                    );
                  }
                },
              ),
            ],
          );
        },
        '/home': (context) {
          final args =
              ModalRoute.of(context)?.settings.arguments as Map<String, String>;
          final userName = args['userName'] ?? 'Usuário';
          final ra = args['ra'] ?? 'RA não definido';

          return HomePage(userName: userName, ra: ra);
        },
        '/tutorial': (context) {
          final args =
              ModalRoute.of(context)?.settings.arguments as Map<String, String>;
          final userName = args['userName'] ?? 'Usuário';
          final ra = args['ra'] ?? 'RA não definido';

          return TutorialScreen(userName: userName, ra: ra);
        },
        '/exam': (context) {
          final args =
              ModalRoute.of(context)?.settings.arguments as Map<String, String>;
          final userName = args['userName'] ?? 'Usuário';
          final ra = args['ra'] ?? 'RA não definido';

          return TestScreen(userName: userName, ra: ra);
        },
        // '/exam': (context) => const ProvaScreen(),
        '/profile': (context) => const local.ProfileScreen(),
        '/forgot-password': (context) {
          final email = ModalRoute.of(context)?.settings.arguments as String;
          return firebase_ui.ForgotPasswordScreen(
            email: email,
            headerMaxExtent: 200,
          );
        },
      },
    );
  }
}
