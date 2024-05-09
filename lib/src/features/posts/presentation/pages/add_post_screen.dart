import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/utls/methods/screen_sizes.dart';
import 'package:social_app/src/core/utls/widgets/custom_buttons.dart';
import 'package:social_app/src/core/utls/widgets/default_button.dart';
import 'package:social_app/src/features/posts/presentation/cubit/posts_cubit.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController postCaption = TextEditingController();
  String imagePath = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {

          //   },
          //   child: const Icon(Icons.add),
          // ),
          appBar: AppBar(
            actions: [
              MyCustomizedElevatedButton(
                onPressed: () {
                  PostsCubit.get(context).addPost(
                      userID: 'Lw6kL5VqyTWIgMxuAN9dNnAGRZz1',
                      postEntity: PostEntity(
                        writtenBy: 'Ayman Ahmed',
                        imageUrl: imagePath == '' ? null : imagePath,
                        userProfileImage:
                            'https://www.nme.com/wp-content/uploads/2021/08/Zool-Redimensioned-Cover-Art.jpg',
                        id: '',
                        text: postCaption.text,
                        time: DateTime.now().toString(),
                        likes: 0,
                        comments: 0,
                      ));
                },
                text: 'Post',
              ),
              const Gap(20.0),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    (state is PostsAddPostLoadingState)
                        ? const LinearProgressIndicator()
                        : const SizedBox(),
                    TextFormField(
                      controller: postCaption,
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return 'Tell about your post';
                        }
                        return null;
                      },
                      minLines: 4,
                      maxLines: 6,
                      // expands: true,
                      decoration: const InputDecoration(
                        // hintMaxLines: 3,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: 'What\'s on your mind?',
                      ),
                      onFieldSubmitted: (value) {},
                    ),
                    const Gap(20),
                    ElevatedButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 50);
                          if (image != null) {
                            setState(() {
                              imagePath = image.path;
                            });
                          }
                        },
                        child: const Icon(Icons.image)),
                    const Gap(20),
                    Container(
                      height: ScreenSizes.width(context) * .9,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: imagePath != ''
                              ? Image.file(File(imagePath)).image
                              : const NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3gpZSb_Y8zMJevdd9E2ZxI4doS3D4BMsus5ltKAyKydLH-zxnGIQQ3Dx7sNWcnZvFea4',
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
