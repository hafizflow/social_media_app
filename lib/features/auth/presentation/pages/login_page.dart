//! Login Page: In this page an existing user can login with email and password

// Once the user successfully login in, they will be redirect to the homepage
// Also if the user doesn't have an account they can go to register page from here to create one

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media_app/features/auth/presentation/components/my_button.dart';
import 'package:social_media_app/features/auth/presentation/components/my_rich_text.dart';
import 'package:social_media_app/features/auth/presentation/components/my_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
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
                ),

                const SizedBox(height: 25),

                MyButton(
                  text: "Login",
                  onTap: () {},
                ),

                const SizedBox(height: 50),

                // Not a member ? Register now
                MyRichText(
                  firstText: 'Don’t have account?  ',
                  secondText: 'Register Now!',
                  onTap: () {
                    const snackBar = SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text('Yay! A SnackBar!'),
                      showCloseIcon: true,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}