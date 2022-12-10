import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/auth_helpers.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Connexion')),
        body: Column(
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(hintText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(hintText: 'Mot de passe')),
            TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;

                  try {
                    final user = AuthService.firebase().currentUser;
                    await AuthService.firebase()
                        .logIn(email: email, password: password);

                    if (user?.isEmailVerified ?? false) {
                      // user's email is verified
                      Navigator.pushNamedAndRemoveUntil(
                          context, notesRoute, (route) => false);
                    } else {
                      // user's email is not verified
                      Navigator.pushNamedAndRemoveUntil(
                          context, verifyEmailRoute, (route) => false);
                    }
                  } on UserNotFoundException {
                    await showErrorDialog(context, 'User not found');
                  } on WrongPasswordException {
                    await showErrorDialog(context, 'Wrong credentials');
                  } on GenericAuthException {
                    await showErrorDialog(context, 'Authentication error');
                  }
                },
                child: const Text('Connexion')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                    (route) => false,
                  );
                },
                child: const Text('Créer mon compte'))
          ],
        ));
  }
}
