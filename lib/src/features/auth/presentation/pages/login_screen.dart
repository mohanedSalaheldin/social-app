import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: DefaultTextFormField(
              context: context,
              controller: TextEditingController(),
              iconData: Icons.email,
              txt: 'Email',
              validator: (p0) {
                return null;
              },
            ),
          )
        ],
      ),
    );
  }
}

class DefaultTextFormField extends StatelessWidget {
  final BuildContext context;
  final String txt;
  final IconData iconData;
  final TextEditingController controller;
  final bool? isPassword;
  final bool? isPasswordShown;
  final TextInputType? keyboard;
  final String? Function(String?) validator;
  final void Function()? onSuffexPressed;

  const DefaultTextFormField({
    super.key,
    required this.context,
    required this.txt,
    required this.iconData,
    required this.controller,
    this.isPassword = false,
    this.isPasswordShown,
    this.keyboard = TextInputType.name,
    required this.validator,
    this.onSuffexPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(iconData),
            const SizedBox(width: 10.0),
            Text(txt,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      height: 0,
                      color: const Color.fromARGB(255, 24, 24, 24),
                    )),
          ],
        ),
        TextFormField(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18),
          validator: validator,
          obscureText: isPasswordShown ?? false,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            suffixIcon: isPassword!
                ? TextButton(
                    onPressed: onSuffexPressed,
                    child: const Text(
                      'Show',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : null,
          ),
          controller: controller,
          keyboardType: keyboard,
        ),
      ],
    );
  }
}
