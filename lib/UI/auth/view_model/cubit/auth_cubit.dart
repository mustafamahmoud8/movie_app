import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/UI/auth/model/AuthService%20.dart';
import 'package:movies_app/UI/auth/model/googleServices.dart';
import 'package:movies_app/core/extentions/context_extention.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;

  AuthCubit(this.authService) : super(AuthInitial());

  void login(String email, String password, BuildContext context) async {
    emit(AuthLoading());
    try {
      await authService.login(email, password, context);
      emit(AuthSuccess(context.getLocalization().loginSuccess));
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll('Exception:', '').trim()));
    }
  }

  void register(
    String name,
    String email,
    String password,
    String confirmPassword,
    String phone,
    int avatarId,
    BuildContext context,
  ) async {
    emit(AuthLoading());

    try {
      final res = await authService.register(
        context,
        name,
        email,
        password,
        confirmPassword,
        phone,
        avatarId,
      );

      if (res['message'] != null &&
          res['message'].toLowerCase().contains('success')) {
        emit(AuthSuccess(context.getLocalization().registrationSuccess));
      } else {
        emit(AuthFailure(res['message'] ?? context.getLocalization().registrationFailed));
      }
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll('Exception:', '').trim()));
    }
  }

  void loginWithGoogle(BuildContext context) async {
    emit(AuthLoading());
    try {
      final user = await GoogleServices.login();

      if (user == null) {
        emit(AuthFailure(context.getLocalization().googleCancelled));
      } else {
        String username = user.displayName ?? user.email.split("@").first;

        emit(AuthSuccess(context.getLocalization().loginSuccess));
      }
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll('Exception:', '').trim()));
    }
  }
}
