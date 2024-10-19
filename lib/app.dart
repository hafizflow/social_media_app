import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/auth/data/firebase_auth_repo.dart';
import 'package:social_media_app/features/auth/presentation/components/my_snackbar.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_state.dart';
import 'package:social_media_app/features/auth/presentation/pages/auth_page.dart';
import 'package:social_media_app/features/post/presentation/pages/home_page.dart';
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
  SocialMediaApp({super.key});

  // auth repo
  final authRepo = FirebaseAuthRepo();

  @override
  Widget build(BuildContext context) {
    //* Provide cubit to the app
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Social Media App",
        theme: lightTheme,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            log(authState.toString());

            if (authState is Unauthenticated) {
              return const AuthPage();
            } else if (authState is Authenticated) {
              return const HomePage();
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          listener: (context, state) {
            if (state is AuthError) {
              mySnackBar(context, state.message);
            }
          },
        ),
      ),
    );
  }
}
