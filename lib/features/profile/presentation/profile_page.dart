import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Cubit
  late final authCubit = context.read<AuthCubit>();

  // Current user
  late final currentUser = authCubit.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile', style: GoogleFonts.poppins())),
      body: Center(
        child: Text(currentUser!.email),
      ),
    );
  }
}
