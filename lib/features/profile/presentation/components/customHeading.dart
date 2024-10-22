import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHeading extends StatelessWidget {
  const CustomHeading({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.primaryFixed,
            ),
          ),
        ],
      ),
    );
  }
}
