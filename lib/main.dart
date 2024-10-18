import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/features/auth/presentation/pages/login_page.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:social_media_app/themes/light_mode.dart';

void main() async {
  //* Firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //* Run app
  runApp(const SocialMediaApp());
}

class SocialMediaApp extends StatelessWidget {
  const SocialMediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Social Media App",
      home: const LoginPage(),
      theme: lightTheme,
    );
  }
}
