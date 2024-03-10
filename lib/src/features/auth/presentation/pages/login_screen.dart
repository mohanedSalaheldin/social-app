import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/src/features/auth/presentation/widgets/auth_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Sign in to Connect',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(20.0),
            AuthTextFormField(
              controller: emailController,
              iconData: Icons.email_outlined,
              txt: 'your email',
              validator: (p0) {
                return null;
              },
            ),
            const Gap(20.0),
            AuthTextFormField(
              controller: passwordController,
              iconData: Icons.lock_outline_rounded,
              txt: 'password',
              validator: (p0) {
                return null;
              },
            ),
            const Gap(
              20.0,
            ),
            DefaultButton(
              onPressed: () {},
              txt: 'sign in',
            ),
          ],
        ),
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.txt,
    required this.onPressed,
    this.backgoungColor,
    this.textColor = Colors.white,
    this.width = 170,
  });

  final Color? textColor;
  final double width;
  final String txt;
  final Color? backgoungColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 60.0,
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgoungColor,
          borderRadius: BorderRadius.circular(80),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              backgoungColor ?? HexColor('#7737ff'),
            ),
          ),
          // height: 60,

          child: Text(
            txt,
            style: TextStyle(
              height: 0.0,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
