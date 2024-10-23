import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_app/features/auth/presentation/components/my_text_field.dart';
import 'package:social_media_app/features/profile/domain/entities/profile_user.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_states.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.user});

  final ProfileUser user;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // mobile pic image
  PlatformFile? imageProfile;

  // web pic image
  Uint8List? imageWebBytes;

  // pic image

  final bioController = TextEditingController();

  @override
  void dispose() {
    bioController.dispose();
    super.dispose();
  }

  //* upload profile button pressed
  void uploadProfile() {
    final profile = context.read<ProfileCubit>();

    if (bioController.text.isNotEmpty) {
      // upload profile
      profile.updateProfile(
        uid: widget.user.uid,
        newBio: bioController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        // profile loading
        if (state is ProfileLoading) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 25),
                  Text('Loading profile...', style: GoogleFonts.poppins()),
                ],
              ),
            ),
          );
        } else {
          // edit form
          return buildEditPage();
        }
      },
      listener: (context, state) {
        if (state is ProfileLoaded) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget buildEditPage({double uploadEditPage = 0.0}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.primaryFixed,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: uploadProfile,
              icon: Icon(
                Icons.upload,
                color: Theme.of(context).colorScheme.primaryFixed,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // profile image
          // bio
          Text('Bio', style: GoogleFonts.poppins()),
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: MyTextField(
              controller: bioController,
              hintText: widget.user.bio,
            ),
          ),
        ],
      ),
    );
  }
}
