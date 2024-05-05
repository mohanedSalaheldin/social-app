import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_app/src/core/utls/widgets/custom_buttons.dart';
import 'package:social_app/src/core/utls/widgets/default_button.dart';

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
    // Clean up the controllers when the widget is disposed
    _userNameController.dispose();
    _addressController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text('Edit Profile'),
          ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(
              minRadius: 120,
              backgroundImage:
                  NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
              foregroundImage: null,
            ),
            DefaultButton(
                txt: 'Pick File',
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
// Pick an image.
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 50,
                  );

                  if (image != null) {
                    setState(() {});
                  }

                }),
            const Gap(10),
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(hintText: 'User Name'),
            ),
            const Gap(10),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(hintText: 'Address'),
            ),
            const Gap(10),
            TextField(
              controller: _bioController,
              decoration: const InputDecoration(hintText: 'Bio'),
            ),
            const Gap(10),
            MyCustomizedElevatedButton(
              text: 'Save',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
