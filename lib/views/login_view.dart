import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/helpers/firebase_exception_handler.dart';
import 'dart:developer' as devtools show log;

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
                  final pwd = _password.text;

                  try {
                    final user = FirebaseAuth.instance.currentUser;
                    final userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: pwd);
                    devtools.log(userCredential.toString());
                    devtools.log((user?.emailVerified).toString());
                    if (user?.emailVerified ?? false) {
                      // user's email is verified
                      Navigator.pushNamedAndRemoveUntil(
                          context, notesRoute, (route) => false);
                    } else {
                      // user's email is not verified
                      Navigator.pushNamedAndRemoveUntil(
                          context, verifyEmailRoute, (route) => false);
                    }
                  } on FirebaseAuthException catch (e) {
                    firebaseExceptionHandler(context, e);
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
