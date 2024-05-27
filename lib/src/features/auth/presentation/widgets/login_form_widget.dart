import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:social_app/src/config/routes/routes_name.dart';
import 'package:social_app/src/core/utls/constants/constants.dart';
import 'package:social_app/src/core/utls/methods/methods.dart';
import 'package:social_app/src/core/utls/widgets/custom_buttons.dart';
import 'package:social_app/src/core/utls/widgets/default_button.dart';
import 'package:social_app/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:social_app/src/core/utls/widgets/default_form_field.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({
    super.key,
  });

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Column(
          children: [
            const Gap(20.0),
            Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/auth_illustration.png'),
                ))),
            const Gap(20.0),
            DefaultTextFormField(
                controller: emailController,
                iconData: Icons.alternate_email,
                keyboard: TextInputType.emailAddress,
                txt: 'your email',
                validator: (p0) {
                  if (!emailValid(p0!)) {
                    return 'Invalid Email';
                  } else {
                    return null;
                  }
                }),
            const Gap(20.0),
            DefaultTextFormField(
                controller: passwordController,
                iconData: Icons.lock_outline_rounded,
                txt: 'password',
                isPassword: true,
                validator: (p0) {
                  if (!passwordValid(p0!)) {
                    return 'Invalid Password';
                  } else {
                    return null;
                  }
                }),
            const Gap(30.0),
            state is AuthLoginLoading
                ? CircularProgressIndicator(color: mainColor)
                : MyCustomizedElevatedButton(
                    text: 'Login',
                    onPressed: () {
                      AuthCubit.get(context).login(
                          email: emailController.text.toLowerCase().trim(),
                          password: passwordController.text.trim());
                    },
                  ),
          ],
        );
      },
    );
  }
}
