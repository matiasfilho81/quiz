import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'tutorial_screen.dart';
import 'prova_screen.dart';

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) {
          return SignInScreen(
            actions: [
              ForgotPasswordAction(
                (context, email) {
                  Navigator.of(context).pushNamed(
                    '/forgot-password',
                    arguments: email,
                  );
                },
              ),
              AuthStateChangeAction(
                (context, state) {
                  if (state is UserCreated || state is SignedIn) {
                    var user = (state is SignedIn)
                        ? state.user
                        : (state as UserCreated).credential.user;
                    if (user == null) return;

                    if (!user.emailVerified && (state is UserCreated)) {
                      user.sendEmailVerification();
                    }

                    if (state is UserCreated) {
                      if (user.displayName == null && user.email != null) {
                        var defaultDisplayName = user.email!.split('@')[0];
                        user.updateDisplayName(defaultDisplayName);
                      }
                    }

                    // Redireciona para a HomePage após o login
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home',
                      (_) => false,
                      arguments: user.displayName ?? user.email,
                    );
                  }
                },
              ),
            ],
          );
        },
        '/home': (context) {
          final userName = ModalRoute.of(context)?.settings.arguments as String;
          return HomePage(userName: userName);
        },
        '/tutorial': (context) {
          final userName = ModalRoute.of(context)?.settings.arguments as String;
          return TutorialScreen(userName: userName);
        },
        '/prova': (context) => const ProvaScreen(),
        '/profile': (context) => ProfileScreen(
              appBar: AppBar(title: const Text('Profile')),
              providers: const [],
              actions: [
                SignedOutAction((context) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/',
                    (_) => false,
                  );
                }),
              ],
            ),
        '/forgot-password': (context) {
          final email = ModalRoute.of(context)?.settings.arguments as String;
          return ForgotPasswordScreen(
            email: email,
            headerMaxExtent: 200,
          );
        },
      },
    );
  }
}
