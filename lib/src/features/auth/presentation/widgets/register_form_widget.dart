
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:social_app/src/core/utls/constants/constants.dart';
import 'package:social_app/src/core/utls/methods/methods.dart';
import 'package:social_app/src/core/utls/widgets/default_button.dart';
import 'package:social_app/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:social_app/src/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:social_app/src/features/auth/presentation/widgets/profile_image_with_picker_widget.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterFormWidgetState createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordAgainController = TextEditingController();
  final profileImagePathController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              const Gap(20.0),
              const Text(
                'Sign up to Connect',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(40.0),
              ProfileImageWithPickerWidget(
                  profileImagePathController: profileImagePathController),
              const Gap(20.0),
              AuthTextFormField(
                controller: usernameController,
                iconData: Icons.person_2_outlined,
                txt: 'username',
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return 'can\'t be empty';
                  } else {
                    return null;
                  }
                },
              ),
              const Gap(20.0),
              AuthTextFormField(
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
                },
              ),
              const Gap(20.0),
              AuthTextFormField(
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
                },
              ),
              const Gap(20.0),
              AuthTextFormField(
                controller: passwordAgainController,
                iconData: Icons.lock_outline_rounded,
                txt: 'password again',
                isPassword: true,
                validator: (p0) {
                  if (!passwordValid(p0!)) {
                    return 'Invalid Password';
                  } else if (passwordController.text !=
                      passwordAgainController.text) {
                    return 'passwords don\'t match';
                  } else {
                    return null;
                  }
                },
              ),
              const Gap(20.0),
              state is AuthRegisterLoading
                  ? CircularProgressIndicator(
                      color: mainColor,
                    )
                  : DefaultButton(
                      onPressed: () {
                        _onSignInButtonPressed(context);
                      },
                      txt: 'sign in',
                    ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordAgainController.dispose();
    profileImagePathController.dispose();
    super.dispose();
  }

  _onSignInButtonPressed(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (profileImagePathController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Please add your profile image',
                style: TextStyle(color: Colors.white)),
          ),
        );
      } else {
        AuthCubit.get(context).register(
            email: emailController.text.toLowerCase().trim(),
            password: passwordController.text.trim(),
            userName: usernameController.text.trim(),
            imagePath: profileImagePathController.text);
      }
    }
  }
}
