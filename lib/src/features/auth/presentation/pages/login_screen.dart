import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:social_app/src/core/utls/widgets/default_button.dart';
import 'package:social_app/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:social_app/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:social_app/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:social_app/src/features/auth/presentation/pages/register_screen.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sign in to Connect',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            // const Gap(20.0),
            Column(
              children: [
                AuthTextFormField(
                  controller: emailController,
                  iconData: Icons.email_outlined,
                  txt: 'your email',
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
                  controller: passwordController,
                  iconData: Icons.lock_outline_rounded,
                  txt: 'password',
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'can\'t be empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const Gap(
                  20.0,
                ),
                DefaultButton(
                  onPressed: () {
                    context.read<AuthCubit>().login(
                        email: emailController.text.toLowerCase().trim(),
                        password: passwordController.text.toLowerCase().trim());
                  },
                  txt: 'sign in',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Have an account?',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 17,
                      ),
                ),
                TextButton(
                  onPressed: () {
                    var Bloc = context.read<AuthCubit>();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: Bloc,
                          child: RegisterScreen(),
                        ),
                      ),
                    );
                  },
                  child: const Text('data'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
