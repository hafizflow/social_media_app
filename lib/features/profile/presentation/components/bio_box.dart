import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BioBox extends StatelessWidget {
  const BioBox({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
      ),
      width: double.infinity,
      child: Text(
        text.isEmpty ? 'Empty bio..' : text,
        style: GoogleFonts.poppins(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
