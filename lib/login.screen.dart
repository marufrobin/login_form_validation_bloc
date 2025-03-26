import 'package:flutter/material.dart';
import 'package:login_form_validation_bloc/widgets/gradient_button.dart';
import 'package:login_form_validation_bloc/widgets/login_field.dart';
import 'package:login_form_validation_bloc/widgets/social_button.dart';

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
      body: SingleChildScrollView(
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
                horizontalPadding: 90,
              ),
              const Text('or', style: TextStyle(fontSize: 17)),
              LoginField(hintText: 'Email', controller: emailController),
              LoginField(hintText: 'Password', controller: passwordController),
              SizedBox(height: 10),
              const GradientButton(),
            ],
          ),
        ),
      ),
    );
  }
}
