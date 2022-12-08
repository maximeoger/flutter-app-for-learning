import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;

void firebaseExceptionHandler(BuildContext context, FirebaseAuthException e) {
  String errorMessage = '';

  switch (e.code) {
    case 'weak-password':
      errorMessage = 'Le mot de passe est trop faible.';
      break;
    case 'email-already-in-use':
      errorMessage = 'Cet email est déjà utilisé.';
      break;
    case 'user-not-found':
      errorMessage = 'Cet utilisateur n\'existe pas.';
      break;
    case 'wrong-password':
      errorMessage = 'Mauvais mot de passe.';
      break;
    case 'invalid-email':
      errorMessage = 'Cet email est invalide.';
      break;
    default:
      errorMessage = 'Erreur: ${e.code}';
  }

  devtools.log(e.code);

  showErrorDialog(context, errorMessage);
}

Future<void> showErrorDialog(BuildContext context, String text) {
  return showDialog(
    context: context,
    builder: (context) {
      return (AlertDialog(
          title: const Text('An error occured'),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            )
          ]));
    },
  );
}
