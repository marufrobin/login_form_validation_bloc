import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form_validation_bloc/bloc/auth_bloc.dart';
import 'package:login_form_validation_bloc/widgets/gradient_button.dart';

import 'login.screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authSate = context.watch<AuthBloc>().state as AuthSuccess;

    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Column(
              spacing: 60,
              children: [
                SizedBox(height: 100),
                Text(authSate.uid),
                GradientButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogOutRequested());
                  },
                  label: "Sign out",
                ),
              ],
            ),
          );
        },
      ),
      // body: BlocBuilder(builder: (context, state) {}),
    );
  }
}
