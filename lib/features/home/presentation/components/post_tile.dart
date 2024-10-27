import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_app/features/post/domain/entities/post.dart';

class PostTile extends StatelessWidget {
  final Post post;
  final void Function()? onDelete;
  const PostTile({super.key, required this.post, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              post.userName,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        CachedNetworkImage(
          imageUrl: post.imageUrl,
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
    );
  }
}
