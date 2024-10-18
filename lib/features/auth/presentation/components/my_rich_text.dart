import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRichText extends StatelessWidget {
  const MyRichText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onTap,
  });

  final String firstText;
  final String secondText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: firstText,
        style: GoogleFonts.poppins(
          color: Theme.of(context).colorScheme.primaryFixed,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        children: <InlineSpan>[
          TextSpan(
            text: secondText,
            style: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          )
        ],
      ),
    );
  }
}
