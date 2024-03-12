import 'package:flutter/material.dart';
import 'package:social_app/src/features/auth/presentation/widgets/auth_form_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    super.key,
    required this.icon,
    required this.title,
    required this.controller,
    required this.globalKey, required this.validator,
  });
  final IconData icon;
  final String title;
  final TextEditingController controller;
  final GlobalKey globalKey;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          AuthTextFormField(
            controller: controller,
            iconData: icon,
            txt: '',
            validator: validator,
          ),
        ],
      ),
    );
  }
}
