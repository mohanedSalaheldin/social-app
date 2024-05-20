import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickalert/quickalert.dart';
import 'package:social_app/src/config/routes/routes_name.dart';
import 'package:social_app/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:social_app/src/features/auth/presentation/widgets/auth_text_button.dart';
import 'package:social_app/src/features/auth/presentation/widgets/register_form_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      _showRegisterRulesDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterSuccess) {
          Navigator.pushReplacementNamed(context, RoutesName.layout);
        }
        if (state is AuthRegisterError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(state.error.toString(),
                  style: const TextStyle(color: Colors.white)),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const RegisterFormWidget(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Have an account?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(fontSize: 17.0)),
                              DefaultTextButton(
                                txt: 'Login',
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, RoutesName.login);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
// Momo123123@g.com
  Future<void> _showRegisterRulesDialog() async {
    QuickAlert.show(
      backgroundColor: HexColor('#191b1c'),
      titleColor: HexColor('ffc947'),
      textColor: Colors.white,
      confirmBtnColor: HexColor('ffc947'),
      confirmBtnTextStyle: const TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
      confirmBtnText: 'I understand',
      context: context,
      type: QuickAlertType.info,
      textAlignment: TextAlign.start,
      text:
          'Registeration Quick Rules: \n1. Ensure you add your profile image \n2.Password should be: \n \t - 8 characters long \n \t - 1 digit \n \t - 1 lowercase \n \t - 1 uppercase \n \t - 1 special character',
    );
  }
}
