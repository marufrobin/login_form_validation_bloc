import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form_validation_bloc/bloc/auth_bloc.dart';
import 'package:login_form_validation_bloc/widgets/gradient_button.dart';
import 'package:login_form_validation_bloc/widgets/login_field.dart';
import 'package:login_form_validation_bloc/widgets/social_button.dart';

import 'home.screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.uid)));
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Column(
                spacing: 16,
                children: [
                  Image.asset('assets/images/signin_balls.png'),
                  const Text(
                    'Sign in.',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                  ),
                  const SizedBox(height: 30),
                  const SocialButton(
                    iconPath: 'assets/svgs/g_logo.svg',
                    label: 'Continue with Google',
                  ),
                  const SocialButton(
                    iconPath: 'assets/svgs/f_logo.svg',
                    label: 'Continue with Facebook',
                    horizontalPadding: 80,
                  ),
                  const Text('or', style: TextStyle(fontSize: 17)),
                  LoginField(hintText: 'Email', controller: emailController),
                  LoginField(
                    hintText: 'Password',
                    controller: passwordController,
                  ),
                  SizedBox(height: 10),
                  GradientButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        AuthLoginRequested(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
