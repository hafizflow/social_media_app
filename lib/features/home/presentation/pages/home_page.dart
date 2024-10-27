import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_media_app/features/home/presentation/components/my_drawer.dart';
import 'package:social_media_app/features/home/presentation/components/post_tile.dart';
import 'package:social_media_app/features/post/presentation/cubits/post_cubit.dart';
import 'package:social_media_app/features/post/presentation/cubits/post_states.dart';
import 'package:social_media_app/features/post/presentation/pages/uplooad_post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final postCubit = context.read<PostCubit>();

  @override
  void initState() {
    super.initState();

    // fetch all post
    fetchAllPost();
  }

  // fetch all post
  void fetchAllPost() {
    postCubit.fetchAllPost();
  }

  // delete post
  void deletePost(String postId) {
    postCubit.deletePost(postId);
    fetchAllPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.primaryFixed,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Iconsax.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const UploadPostPage();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),

      // Body
      body: BlocBuilder<PostCubit, PostStates>(
        builder: (context, state) {
          // loading
          if (state is PostsLoading && state is PostsUploading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // loaded
          else if (state is PostsLoaded) {
            final allPost = state.posts;

            if (allPost.isEmpty) {
              return const Center(
                child: Text('No posts available'),
              );
            }

            return ListView.builder(
              itemCount: allPost.length,
              itemBuilder: (context, index) {
                // get individual post
                final post = allPost[index];

                // image
                return PostTile(
                  post: post,
                  onDelete: () => deletePost(post.id),
                );
              },
            );
          }

          // error

          else if (state is PostsError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
