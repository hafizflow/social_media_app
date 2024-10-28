import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_app/features/auth/domain/entities/app_user.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_media_app/features/post/domain/entities/post.dart';
import 'package:social_media_app/features/post/presentation/cubits/post_cubit.dart';
import 'package:social_media_app/features/profile/domain/entities/profile_user.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_cubit.dart';

class PostTile extends StatefulWidget {
  final Post post;
  final void Function()? onDelete;
  const PostTile({super.key, required this.post, this.onDelete});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  // cubits
  late final postCubit = context.read<PostCubit>();
  late final profileCubit = context.read<ProfileCubit>();

  // app user
  AppUser? currentUser;

  // profile user
  ProfileUser? postUser;

  bool isOwnPost = false;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
    fetchPostUser();
  }

  void getCurrentUser() {
    final authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
    isOwnPost = (currentUser!.uid == widget.post.userId);
  }

  Future<void> fetchPostUser() async {
    final fetchUser = await profileCubit.getUserProfile(widget.post.userId);

    if (fetchUser != null) {
      setState(() {
        postUser = fetchUser;
      });
    }
  }

  void showOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Post?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                widget.onDelete!();
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // profile picture
              // postUser?.profileImageUrl == null
              //     ? const Icon(Icons.person)
              //     : CachedNetworkImage(
              //         imageUrl: postUser!.profileImageUrl,
              //         errorWidget: (context, url, error) {
              //           log(error.toString());
              //           return const Icon(Icons.person);
              //         },
              //         imageBuilder: (context, imageProvider) {
              //           return Container(
              //             height: 40,
              //             width: 40,
              //             decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               image: DecorationImage(
              //                 image: imageProvider,
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           );
              //         },
              //       ),

              // name
              Text(
                widget.post.userName,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              // delete button
              IconButton(
                onPressed: showOptions,
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          CachedNetworkImage(
            imageUrl: widget.post.imageUrl,
            height: 430,
            fit: BoxFit.cover,
            width: double.infinity,
            placeholder: (context, url) {
              return const SizedBox(
                height: 430,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            errorWidget: (context, url, error) {
              return const Icon(Icons.error);
            },
          ),
        ],
      ),
    );
  }
}
