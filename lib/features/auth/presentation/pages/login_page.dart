//! Login Page: In this page an existing user can login with email and password

// Once the user successfully login in, they will be redirect to the homepage
// Also if the user doesn't have an account they can go to register page from here to create one

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media_app/features/auth/presentation/components/my_button.dart';
import 'package:social_media_app/features/auth/presentation/components/my_rich_text.dart';
import 'package:social_media_app/features/auth/presentation/components/my_snackbar.dart';
import 'package:social_media_app/features/auth/presentation/components/my_text_field.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  final void Function() togglePage;

  const LoginPage({super.key, required this.togglePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  //* login button pressed
  void login() {
    final String email = emailController.text.trim();
    final String pw = pwController.text.trim();

    // AuthCubit
    final authCubit = context.read<AuthCubit>();

    if (email.isNotEmpty && pw.isNotEmpty) {
      // Login!
      authCubit.login(email, pw);
    } else {
      // Show error message
      mySnackBar(context, "Please enter both email and password");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //* Logo
                  Icon(
                    Iconsax.lock_circle5,
                    size: 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 50),

                  // Welcome back message
                  Text(
                    "Welcome back, you've been missed!",
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.primaryFixed,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Email TextField
                  MyTextField(
                    controller: emailController,
                    hintText: "Email",
                  ),

                  const SizedBox(height: 10),

                  // Password TextField
                  MyTextField(
                    controller: pwController,
                    hintText: "Password",
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                  ),

                  const SizedBox(height: 25),

                  // Login Button
                  MyButton(
                    text: "Login",
                    onTap: () => login(),
                  ),

                  const SizedBox(height: 50),

                  // Not a member ? Register now
                  MyRichText(
                    firstText: 'Don’t have account?  ',
                    secondText: 'Register Now!',
                    onTap: () => widget.togglePage(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
