import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/src/core/entites/user_info_entity.dart';
import 'package:social_app/src/core/utls/constants/constants.dart';
import 'package:social_app/src/core/utls/widgets/default_form_field.dart';
import 'package:social_app/src/core/utls/widgets/custom_buttons.dart';
import 'package:social_app/src/core/utls/widgets/default_button.dart';
import 'package:social_app/src/features/home/presentation/pages/cubit/layout_cubit_cubit.dart';
import 'package:social_app/src/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:social_app/injection_container.dart' as di;

class ProfileInfoEditScreen extends StatefulWidget {
  const ProfileInfoEditScreen({super.key});

  @override
  State<ProfileInfoEditScreen> createState() => _ProfileInfoEditScreenState();
}

class _ProfileInfoEditScreenState extends State<ProfileInfoEditScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _addressController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  String imagePath = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateInfoSuccessState) {
          context.read<LayoutCubit>().setCurrentScreen(0);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text('Profile updated successfully'),
          ));
        }
        if (state is ProfileUpdateInfoErrorState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Something went wrong, please try again'),
          ));
        }
      },
      builder: (context, state) {
        UserInfoEntity userInfo = ProfileCubit.get(context).userInfo;
        _userNameController.text = userInfo.userName.toString();
        _addressController.text = userInfo.address.toString();
        _bioController.text = userInfo.bio.toString();
        return Scaffold(
          appBar: AppBar(
              // title: const Text('Edit Profile'),
              ),
          body: Builder(builder: (context) {
            if (state is ProfileUpdateInfoLoadingState) {
              return Center(child: CircularProgressIndicator(color: mainColor));
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            minRadius: 50,
                            backgroundImage: imagePath != ''
                                ? Image.file(File(imagePath)).image
                                : NetworkImage(
                                    userInfo.profileImageURL.toString()),
                            foregroundImage: null,
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: IconButton(
                              onPressed: () async {
                                final ImagePicker picker = ImagePicker();
                                // Pick an image.
                                final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 50,
                                );

                                if (image != null) {
                                  setState(() {
                                    imagePath = image.path;
                                  });
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(mainColor)),
                              icon: const Icon(Icons.edit),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    DefaultTextFormField(
                      controller: _userNameController,
                      txt: 'User Name',
                      iconData: Icons.person,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Address must not be empty';
                        }
                        return null;
                      },
                    ),
                    const Gap(10),
                    DefaultTextFormField(
                      controller: _addressController,
                      txt: 'Address',
                      iconData: Icons.location_on,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Address must not be empty';
                        }
                        return null;
                      },
                    ),
                    const Gap(10),
                    DefaultTextFormField(
                      controller: _bioController,
                      txt: 'Bio',
                      iconData: Icons.info_outline,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Address must not be empty';
                        }
                        return null;
                      },
                    ),
                    const Gap(20),
                    MyCustomizedElevatedButton(
                      text: 'Save',
                      onPressed: () {
                        if (!(_bioController.text == userInfo.bio.toString() &&
                            _addressController.text ==
                                userInfo.address.toString() &&
                            _userNameController.text ==
                                userInfo.userName.toString() &&
                            imagePath == '')) {
                          _onSaveButton(userInfo);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  _onSaveButton(UserInfoEntity userInfo) {
    print('hello');
    ProfileCubit.get(context).updateProfileInfo(
      model: UserInfoEntity(
        userName: _userNameController.text,
        address: _addressController.text,
        fcmToken: userInfo.fcmToken,
        bio: _bioController.text,
        profileImageURL: imagePath == '' ? userInfo.profileImageURL : imagePath,
        userId: userInfo.userId,
        followers: userInfo.followers,
        following: userInfo.following,
        email: userInfo.email,
      ),
      userId: userInfo.userId,
      oldImageUrl: userInfo.profileImageURL,
    );
  }
}
