import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media_app/features/auth/presentation/components/my_button.dart';
import 'package:social_media_app/features/auth/presentation/components/my_rich_text.dart';
import 'package:social_media_app/features/auth/presentation/components/my_snackbar.dart';
import 'package:social_media_app/features/auth/presentation/components/my_text_field.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  final void Function() togglePage;

  const RegisterPage({super.key, required this.togglePage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final cpwController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    nameController.dispose();
    super.dispose();
  }

  //* Register button pressed
  void register() {
    final email = emailController.text.trim();
    final name = nameController.text.trim();
    final pw = pwController.text;
    final cpw = cpwController.text;

    final authCubit = context.read<AuthCubit>();

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        pw.isNotEmpty &&
        cpw.isNotEmpty) {
      if (pw == cpw) {
        authCubit.register(name, email, pw);
      } else {
        mySnackBar(context, 'Password must be match');
      }
    } else {
      mySnackBar(context, 'All fields are required. Please complete the form!');
    }
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
                    Iconsax.activity5,
                    size: 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 50),

                  // Create account message
                  Text(
                    "Let's create an account for your",
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.primaryFixed,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Password TextField
                  MyTextField(
                    controller: nameController,
                    hintText: "Name",
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
                  ),

                  const SizedBox(height: 10),

                  // Password TextField
                  MyTextField(
                    controller: cpwController,
                    hintText: "Confirm Password",
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                  ),

                  const SizedBox(height: 25),

                  // Register Button
                  MyButton(
                    text: "Register",
                    onTap: () => register(),
                  ),

                  const SizedBox(height: 50),

                  // Not a member ? Register now
                  MyRichText(
                    firstText: 'Already have account?  ',
                    secondText: 'Login Now!',
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
