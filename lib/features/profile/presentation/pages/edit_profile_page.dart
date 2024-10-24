import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
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
  PlatformFile? imagesPickedFile;

  // web pic image
  Uint8List? webImage;

  // pic image
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: kIsWeb,
    );

    if (result != null) {
      setState(() {
        imagesPickedFile = result.files.first;

        if (kIsWeb) {
          webImage = imagesPickedFile!.bytes;
        }
      });
    }
  }

  final bioController = TextEditingController();

  @override
  void dispose() {
    bioController.dispose();
    super.dispose();
  }

  //* upload profile button pressed
  void uploadProfile() {
    final profile = context.read<ProfileCubit>();

    // prepare image & data
    final String uid = widget.user.uid;
    final String? newBio =
        bioController.text.isNotEmpty ? bioController.text.trim() : null;
    final imageMobilePath = kIsWeb ? null : imagesPickedFile?.path;
    final imageWebBytes = kIsWeb ? imagesPickedFile?.bytes : null;

    // only update profile if there is a change
    if (imagesPickedFile != null || newBio != null) {
      // upload profile
      profile.updateProfile(
        uid: uid,
        newBio: newBio,
        imageMobilePath: imageMobilePath,
        imageWebBytes: imageWebBytes,
      );
    } else {
      Navigator.pop(context);
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

  Widget buildEditPage() {
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
          Stack(
            children: [
              Center(
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child:
                      // mobile image
                      (!kIsWeb && imagesPickedFile != null)
                          ? Image.file(
                              File(imagesPickedFile!.path!),
                              fit: BoxFit.cover,
                            )
                          :

                          // web image
                          (kIsWeb && webImage != null)
                              ? Image.memory(
                                  webImage!,
                                  fit: BoxFit.cover,
                                )
                              :

                              // no image selected -> display existing image
                              CachedNetworkImage(
                                  imageUrl: widget.user.profileImageUrl,
                                  // loading
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),

                                  // error
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.person,
                                    size: 72,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryFixed,
                                  ),

                                  // loaded image
                                  imageBuilder: (context, imageProvider) =>
                                      Image(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: MediaQuery.sizeOf(context).width / 2 - 80,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.teal.withOpacity(.8),
                  child: IconButton(
                    onPressed: pickImage,
                    icon: const Icon(
                      Iconsax.edit5,
                      size: 26,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

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
