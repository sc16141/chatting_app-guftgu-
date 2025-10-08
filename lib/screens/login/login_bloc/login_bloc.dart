import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/login_auth.dart';
import 'login_event.dart';
import 'login_state.dart'; // Your state file

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService _authService;

  LoginBloc(this._authService) : super(InitialLogin()) {

    on<SignInWithEmailPasswordRequested>((event, emit) async {
      emit(LoadingLogin());
      try {
        final user = await _authService.signInWithEmailAndPassword(
          event.email,
          event.password,
        );
        if (user != null) {
          emit(SuccessLogin(user: user));
        } else {
          emit(const LoginError(error: 'Sign-in failed. Please check your credentials.'));
        }
      } on FirebaseAuthException catch (e) {
        emit(LoginError(error: e.message ?? 'An unknown error occurred.'));
      }
    });

    // on<SignInWithGoogleRequested>((event, emit) async {
    //   emit(LoadingLogin());
    //   try {
    //     final user = await _authService.
    //     if (user != null) {
    //       emit(SuccessLogin(user: user));
    //     } else {
    //       emit(const LoginError(error: 'Google Sign-In was cancelled or failed.'));
    //     }
    //   } on FirebaseAuthException catch (e) {
    //     emit(LoginError(error: e.message ?? 'An unknown Google error occurred.'));
    //   }
    // });

    on<PasswordResetRequested>((event, emit) async {
      try {
        await _authService.sendPasswordResetEmail(event.email);
        emit(PasswordResetEmailSent());
      } on FirebaseAuthException catch (e) {
        emit(LoginError(error: e.message ?? 'Failed to send reset email.'));
      }
    });
  }
}