import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;

  const MyDrawerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primaryFixed),
      title: Text(title,
          style: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.primaryFixed)),
      onTap: onTap,
    );
  }
}
