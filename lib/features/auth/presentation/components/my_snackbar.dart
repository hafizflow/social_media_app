import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void mySnackBar(BuildContext context, String message, {Color? bgColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: bgColor ?? Colors.red.shade800,
    ),
  );
}
