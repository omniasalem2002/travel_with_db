import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guru/splash.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          appId: '1:366342141425:android:f8f43d19f6a5808d670050',
          messagingSenderId: '366342141425',
          projectId: 'travel-27e7d',
          apiKey: 'key'
      )
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
