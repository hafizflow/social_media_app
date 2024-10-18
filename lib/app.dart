import 'package:flutter/material.dart';
import 'package:social_media_app/features/auth/presentation/pages/auth_page.dart';
import 'package:social_media_app/themes/light_mode.dart';

//* App - Root level

/* 

Repositories for database
 - firebase

Bloc Providers: for state management
  - Auth
  - Profile
  - Post 
  - Search
  - Theme

Check auth state
  - if user is authenticated =>  HomePage
  - if user is unauthenticated => AuthPage

*/

class SocialMediaApp extends StatelessWidget {
  const SocialMediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Social Media App",
      home: const AuthPage(),
      theme: lightTheme,
    );
  }
}
