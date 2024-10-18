import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen', style: GoogleFonts.poppins()),
        actions: [
          IconButton(
            onPressed: () => context.read<AuthCubit>()..logout(),
            icon: const Icon(Iconsax.logout),
          )
        ],
      ),
    );
  }
}
