import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AuthTextFormField extends StatefulWidget {
  final String txt;
  final IconData iconData;
  final TextEditingController controller;
  final bool? isPassword;

  final TextInputType? keyboard;
  final String? Function(String?) validator;
  final void Function()? onSuffexPressed;

  const AuthTextFormField({
    super.key,
    required this.txt,
    required this.iconData,
    required this.controller,
    this.isPassword = false,
    this.keyboard = TextInputType.name,
    required this.validator,
    this.onSuffexPressed,
  });

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  bool isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              widget.iconData,
              color: Colors.white,
              size: 25.0,
            ),
            const Gap(10),
            Expanded(
              child: TextFormField(
                
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                validator: widget.validator,
                
                obscureText: isPasswordHidden && widget.isPassword!,
                decoration: InputDecoration(
                  
                  // contentPadding: const EdgeInsets.all(0),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: .5,
                    ),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: .5,
                    ),
                  ),
                  
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: .5,
                    ),
                  ),
                  // hintText: txt,
                  // floatingLabelBehavior: FloatingLabelBehavior.never,
                  label: Text(
                    widget.txt,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                  ),

                  suffixIcon: widget.isPassword!
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordHidden = !isPasswordHidden;
                            });
                          },
                          icon: Icon(
                            isPasswordHidden
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
                controller: widget.controller,
                keyboardType: widget.keyboard,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
