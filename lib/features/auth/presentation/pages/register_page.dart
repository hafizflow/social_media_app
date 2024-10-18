import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media_app/features/auth/presentation/components/my_button.dart';
import 'package:social_media_app/features/auth/presentation/components/my_rich_text.dart';
import 'package:social_media_app/features/auth/presentation/components/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final nameController = TextEditingController();

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
                  // Logo
                  Icon(
                    Iconsax.activity,
                    size: 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 50),

                  // Create account message
                  Text(
                    "Create an account",
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.primaryFixed,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Password TextField
                  MyTextField(
                    controller: nameController,
                    hintText: "Name",
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // Email TextField
                  MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    textInputType: TextInputType.emailAddress,
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

                  // Register Button
                  MyButton(
                    text: "Register",
                    onTap: () {},
                  ),

                  const SizedBox(height: 50),

                  // Not a member ? Register now
                  MyRichText(
                    firstText: 'Already have account?  ',
                    secondText: 'Login Now!',
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
      ),
    );
  }
}
