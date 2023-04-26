import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:massup/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDvUFpl8IkhxJqFG4lbgzY9CVZHMA_4OIM",
        authDomain: "massup-51634.firebaseapp.com",
        projectId: "massup-51634",
        storageBucket: "massup-51634.appspot.com",
        messagingSenderId: "71446605654",
        appId: "1:71446605654:web:f83579e16d2b807a42f0f7",
        measurementId: "G-2NP9ZNFRLH"),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: ' Mass Up',
      routerConfig: app_router,
    );
  }
}
