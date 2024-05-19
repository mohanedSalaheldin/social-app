
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageWithPickerWidget extends StatefulWidget {
  const ProfileImageWithPickerWidget(
      {super.key, required this.profileImagePathController});
  final TextEditingController profileImagePathController;

  @override
  State<ProfileImageWithPickerWidget> createState() =>
      _ProfileImageWithPickerWidgetState();
}

class _ProfileImageWithPickerWidgetState
    extends State<ProfileImageWithPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        // clipBehavior: Clip.antiAlias,
      ),
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60.0,
            backgroundColor: Colors.grey.shade300,
            child: widget.profileImagePathController.text.isEmpty
                ? Image.asset(
                    width: 120,
                    'assets/images/auth_illustration.png',
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    width: 120,
                    File(widget.profileImagePathController.text),
                    fit: BoxFit.cover,
                  ),
          ),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              color: Colors.white,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.black87.withOpacity(.5)),
              ),
              onPressed: _pickProfileImage,
              icon: const Icon(Icons.camera_alt),
            ),
          )
        ],
      ),
    );
  }

  void _pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image != null) {
      setState(() {
        widget.profileImagePathController.text = image.path;
      });
    }
  }
}
