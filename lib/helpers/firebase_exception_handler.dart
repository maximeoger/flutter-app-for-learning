import 'package:firebase_auth/firebase_auth.dart';

void firebaseExceptionHandler(FirebaseAuthException e) {
  switch (e.code) {
    case 'weak-password':
      print('Weak password.');
      break;
    case 'email-already-in-use':
      print('Email already in use.');
      break;
    case 'user-not-found':
      print('User not found.');
      break;
    case 'wrong-password':
      print('Wrong password.');
      break;
    case 'invalid-email':
      print('Invalid email.');
      break;
    default:
      print(e.code);
  }
}
