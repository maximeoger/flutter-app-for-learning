import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes/constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Verification Email'),
        ),
        body: Column(
          children: [
            const Text(
                'Un email de confirmation a été envoyé à l\'addresse email que vous avez fournis. Veuillez cliquer sur le lien présent dans cet email pour vérifier votre compte (pensez à vérifier les spams!)'),
            const Text(
                'Si vous \'avez rien reçu, cliquer sur le bouton çi-dessous pour renvoyer un autre email de confirmation.'),
            TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
              child: const Text('Renvoyer un lien de vérification'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, registerRoute, (route) => false);
              },
              child: Text('Restart'),
            )
          ],
        ));
  }
}
