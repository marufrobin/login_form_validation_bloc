import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);

    on<AuthLogOutRequested>(_onAuthLogOutRequested);
  }

  void _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final email = event.email;
      final password = event.password;
      log(name: "Auth Email", email);
      log(name: "Auth Password", password);

      final emailRegex = RegExp(
        r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
      );
      if (email.isEmpty) {
        return emit(AuthFailure("Email is required"));
      } else if (!emailRegex.hasMatch(email)) {
        return emit(AuthFailure("Please enter a valid email"));
      } else if (password.length < 6) {
        return emit(AuthFailure("Password must be at least 6 characters long"));
      }
      await Future.delayed(Duration(seconds: 4), () {
        return emit(AuthSuccess("$email-$password"));
      });
    } catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }

  void _onAuthLogOutRequested(
    AuthLogOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await Future.delayed(Duration(seconds: 4), () {
        return emit(AuthInitial());
      });
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
