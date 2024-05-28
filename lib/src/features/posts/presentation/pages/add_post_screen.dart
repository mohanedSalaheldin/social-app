import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/src/core/entites/post_entity.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/models/user_info_model.dart';
import 'package:social_app/src/core/utls/constants/constants.dart';
import 'package:social_app/src/core/utls/methods/screen_sizes.dart';
import 'package:social_app/src/core/utls/widgets/custom_buttons.dart';
import 'package:social_app/src/core/utls/widgets/default_button.dart';
import 'package:social_app/src/features/home/presentation/pages/cubit/layout_cubit_cubit.dart';
import 'package:social_app/src/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:social_app/src/features/profile/presentation/cubit/profile_cubit.dart';

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
        if (state is PostsAddPostSuccessState) {
          context.read<LayoutCubit>().setCurrentScreen(0);
        }
      },
      builder: (context, state) {
        UserInfoEntity userInfo = context.read<ProfileCubit>().userInfo;
        return Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () async {
          //     print('--------------------------------');
          //     print(await FirebaseMessaging.instance.getToken());
          //     print('--------------------------------');
          //   },
          //   child: const Icon(Icons.add),
          // ),
          appBar: AppBar(
            title: const Text('Add Post'),
            actions: [
              MyCustomizedElevatedButtonSmall(
                onPressed: () {
                  PostsCubit.get(context).addPost(
                    userInfo: userInfo,
                    imagePath: imagePath,
                    postCaption: postCaption.text,
                  );
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
                        ? LinearProgressIndicator(
                            color: mainColor,
                          )
                        : const SizedBox(),
                    CaptionAreaWidget(
                      postCaption: postCaption,
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Add Image',
                          style: TextStyle(
                            // color: mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 50);
                              if (image != null) {
                                setState(() {
                                  imagePath = image.path;
                                });
                              }
                            },
                            child: Icon(
                              Icons.image,
                              color: mainColor,
                            )),
                      ],
                    ),
                    const Gap(20),
                    Container(
                      height: ScreenSizes.width(context) * .9,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        border: Border.all(width: 1, color: Colors.black),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imagePath != ''
                              ? Image.file(File(imagePath)).image
                              : const AssetImage('assets/images/gallery.png'),
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

class CaptionAreaWidget extends StatelessWidget {
  const CaptionAreaWidget({
    super.key,
    required this.postCaption,
  });

  final TextEditingController postCaption;

  final outlineInputBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.all(Radius.circular(10)));

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: postCaption,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14.0,
      ),
      validator: (value) {
        if (value!.isEmpty || value == '') {
          return 'Tell about your post';
        }
        return null;
      },
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      minLines: 3,
      maxLines: 4,
      // expands: true,
      decoration: InputDecoration(
        // hintMaxLines: 3,

        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        enabledBorder: outlineInputBorder,
        border: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        hintText: 'What\'s on your mind?',
      ),
      onFieldSubmitted: (value) {},
    );
  }
}
