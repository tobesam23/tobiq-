import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app/app.dart';

// entry point - initialize firebase then launch the app
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // connecting firebase using the auto-generated config
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}