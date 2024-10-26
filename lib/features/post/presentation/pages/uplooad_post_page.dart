import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_app/features/auth/domain/entities/app_user.dart';
import 'package:social_media_app/features/auth/presentation/components/my_snackbar.dart';
import 'package:social_media_app/features/auth/presentation/components/my_text_field.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_media_app/features/post/domain/entities/post.dart';
import 'package:social_media_app/features/post/presentation/cubits/post_cubit.dart';
import 'package:social_media_app/features/post/presentation/cubits/post_states.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  // Mobile platform file
  PlatformFile? imagePickedFile;

  // Web platform file
  Uint8List? webImage;

  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  // current user
  AppUser? currentUser;

  //! get current user
  void getCurrentUser() {
    final authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
  }

  //! pick image
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: kIsWeb,
    );

    if (result != null) {
      setState(
        () {
          imagePickedFile = result.files.first;

          if (kIsWeb) {
            webImage = imagePickedFile!.bytes;
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  //! upload post
  void uploadPost() {
    // check if caption and image is empty
    if (textController.text.isEmpty || imagePickedFile == null) {
      mySnackBar(context, 'Both image and caption are required');
      return;
    }

    // create a new post object
    final newPost = Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: currentUser!.uid,
      userName: currentUser!.name,
      text: textController.text,
      imageUrl: '',
      createdAt: DateTime.now(),
    );

    // post cubit
    final postCubit = context.read<PostCubit>();

    // upload post
    if (kIsWeb) {
      postCubit.createPost(newPost, bytes: imagePickedFile!.bytes);
    } else {
      log(imagePickedFile!.path!);
      postCubit.createPost(newPost, imagePath: imagePickedFile!.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostStates>(
      builder: (context, state) {
        if (state is PostsUploading || state is PostsLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // build the upload post page
        return buildUploadPage();
      },
      listener: (context, state) {
        if (state is PostsLoaded) {
          Navigator.pop(context);
          mySnackBar(
            context,
            'Post uploaded successfully',
            bgColor: Colors.teal,
          );
        }
      },
    );
  }

  Widget buildUploadPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload Post',
          style: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.primaryFixed,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                uploadPost();
              },
              icon: Icon(
                Icons.upload,
                color: Theme.of(context).colorScheme.primaryFixed,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(height: 25),

            // caption text field
            MyTextField(
              controller: textController,
              hintText: 'Caption',
            ),

            const SizedBox(height: 25),

            // image preview for web
            if (kIsWeb && webImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.memory(webImage!),
              ),

            // image preview for mobile
            if (!kIsWeb && imagePickedFile != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(File(imagePickedFile!.path!)),
              ),

            const SizedBox(height: 25),

            // Image picker button
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                onPressed: () => pickImage(),
                color: Colors.blue,
                child: Text('Pick Image', style: GoogleFonts.poppins()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
