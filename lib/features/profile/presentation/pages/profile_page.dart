import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_app/features/auth/domain/entities/app_user.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_media_app/features/profile/presentation/components/bio_box.dart';
import 'package:social_media_app/features/profile/presentation/components/customHeading.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_states.dart';
import 'package:social_media_app/features/profile/presentation/pages/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Cubit
  late final authCubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();

  // Current user
  late AppUser? currentUser = authCubit.currentUser;

  @override
  void initState() {
    super.initState();
    profileCubit.fetchUserProfile(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        // loaded
        if (state is ProfileLoaded) {
          final user = state.profileUser;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                user.name,
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(user: user),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.settings,
                      color: Theme.of(context).colorScheme.primaryFixed,
                    ),
                  ),
                ),
              ],
            ),
            body: Center(
              child: Column(
                children: [
                  // email
                  Text(
                    user.email,
                    style: GoogleFonts.poppins(),
                  ),

                  const SizedBox(height: 25),

                  // Profile image
                  // Container(
                  //   height: 150,
                  //   width: 150,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(12),
                  //     color: Theme.of(context).colorScheme.secondary,
                  //   ),
                  //   padding: const EdgeInsets.all(25),
                  //   child: Center(
                  //     child: Icon(
                  //       Icons.person,
                  //       size: 72,
                  //       color: Theme.of(context).colorScheme.primary,
                  //     ),
                  //   ),
                  // ),

                  CachedNetworkImage(
                    imageUrl: user.profileImageUrl,
                    // loading
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),

                    // error
                    errorWidget: (context, url, error) => Icon(
                      Icons.person,
                      size: 72,
                      color: Theme.of(context).colorScheme.primaryFixed,
                    ),

                    // loaded image
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.secondary,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 150,
                      width: 150,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Bio
                  const CustomHeading(text: 'Bio'),
                  const SizedBox(height: 10),
                  BioBox(text: user.bio),

                  // Posts
                  const SizedBox(height: 25),
                  const CustomHeading(text: 'Posts'),
                ],
              ),
            ),
          );
        }

        // loading
        else if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('No profile found...'),
            ),
          );
        }
      },
    );
  }
}
