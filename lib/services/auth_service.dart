// ignore_for_file: avoid_types_as_parameter_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:massup/services/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    Firebase.initializeApp();
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      print('success loggin in');
      return result;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Register with email and password
  Future<String> registerWithEmailAndPassword(
      // ignore: non_constant_identifier_names
      String email, String password, String name, String studentId, String Text, String y, String t, String z, String o, String p) async {
    Firebase.initializeApp();
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      Map<String, dynamic> data = {
        'id': user?.uid,
        'email': email,
        'password': password,
        'name': name,
        'studentId': studentId
      };

      AppUser.createProfile(data);
      return result.user!.uid;
    } catch (error) {
      print(error.toString());
      return "";
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
