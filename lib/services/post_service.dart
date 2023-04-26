import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> submitPost(String title, String content) async {
  // Get a reference to the Firestore collection
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  // Get the current user ID
  String? userId = await FirebaseAuth.instance.currentUser?.uid;
  String? userEmail = await FirebaseAuth.instance.currentUser?.email;

  // Create a new document in the collection with the user ID as the document ID
  await posts.doc().set({
    'title': title,
    'content': content,
    'userId': userId,
    'userEmail':userEmail,
    'timeCreated': FieldValue.serverTimestamp(),
  });
}
