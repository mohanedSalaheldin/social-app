import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AuthTextFormField extends StatelessWidget {
  final String txt;
  final IconData iconData;
  final TextEditingController controller;
  final bool? isPassword;
  final bool? isPasswordShown;
  final TextInputType? keyboard;
  final String? Function(String?) validator;
  final void Function()? onSuffexPressed;

  const AuthTextFormField({
    super.key,
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
            Icon(
              iconData,
              color: Colors.black,
            ),
            const Gap(10),
            Expanded(
              child: TextFormField(
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 18),
                validator: validator,
                obscureText: isPasswordShown ?? false,
                decoration: InputDecoration(
                  // contentPadding: const EdgeInsets.all(0),
                  label: Text(txt),
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
            ),
          ],
        ),
      ],
    );
  }
}
