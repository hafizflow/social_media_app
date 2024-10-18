import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //     padding: const EdgeInsets.all(24),
    //     decoration: BoxDecoration(
    //       color: Theme.of(context).colorScheme.tertiary,
    //       borderRadius: BorderRadius.circular(12),
    //     ),
    //     child: Center(
    //       child: Text(
    //         text,
    // style: GoogleFonts.poppins(
    //   fontSize: 18,
    //   fontWeight: FontWeight.bold,
    // ),
    //       ),
    //     ),
    //   ),
    // );

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.grey.shade100),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(24)),
        elevation: const WidgetStatePropertyAll(0.5),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      onPressed: () {},
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primaryFixed,
          ),
        ),
      ),
    );
  }
}
