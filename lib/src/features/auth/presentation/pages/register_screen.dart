import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/src/core/utls/widgets/default_button.dart';
import 'package:social_app/src/features/auth/presentation/pages/login_screen.dart';
import 'package:social_app/src/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:social_app/src/features/auth/presentation/widgets/register_steps_widgets.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _repeatPasswordFormKey = GlobalKey<FormState>();
  final _userNameFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<GlobalKey<FormState>> keys = [
      _emailFormKey,
      _passwordFormKey,
      // _repeatPasswordFormKey,
      _userNameFormKey,
      _userNameFormKey,
    ];
    final List<Widget> pages = [
      RegisterPage(
        icon: Icons.email_outlined,
        title: 'Enter your email address',
        controller: _emailController,
        globalKey: _emailFormKey,
        validator: (value) {
          if (value!.isEmpty) {
            return "can't be empty";
          }
          return null;
        },
      ),
      RegisterPage(
        icon: Icons.lock_outline_rounded,
        title: 'Enter your password',
        controller: _passwordController,
        globalKey: _passwordFormKey,
        validator: (value) {
          if (value!.isEmpty) {
            return "can't be empty";
          }
          return null;
        },
      ),
      RegisterPage(
        icon: Icons.person_outline_rounded,
        title: 'Enter your user name',
        controller: _userNameController,
        globalKey: _userNameFormKey,
        validator: (value) {
          if (value!.isEmpty) {
            return "can't be empty";
          }
          return null;
        },
      ),
      const FilePickScreen()
    ];

    var pageController = PageController();
    int currentPage = 0;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  currentPage = value;
                },
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                itemBuilder: (context, index) => pages[index],
                itemCount: 4,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: 4,
                  effect: const ExpandingDotsEffect(),
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (currentPage == 3) {
                      print('********************');
                      print(_emailController.text);
                      print('********************');
                      print(_passwordController.text);
                      print('********************');
                      print(_userNameController.text);
                      print('********************');
                      print(_userNameController.text);
                      print('********************');
                      // print(emailController.text);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const LoginScreen(),
                      //   ),
                      // );
                    } else if (currentPage == 2) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (keys[currentPage].currentState!.validate()) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    } else {
                      // print()
                      // FocusManager.instance.primaryFocus?.unfocus();
                      if (keys[currentPage].currentState!.validate()) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    }
                  },
                  child: const Icon(Icons.arrow_forward_sharp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FilePickScreen extends StatefulWidget {
  const FilePickScreen({super.key});

  @override
  State<FilePickScreen> createState() => _FilePickScreenState();
}

class _FilePickScreenState extends State<FilePickScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(),
        DefaultButton(
            txt: 'Pick File',
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: [
                  'jpg',
                  'jpeg',
                  'png',
                ],
              );

              if (result != null) {
                File file = File(result.files.single.path!);
                print('-------------------------------');
                print(file.path);
                print('-------------------------------');
              } else {
                // User canceled the picker
              }
            }),
      ],
    );
  }
}
