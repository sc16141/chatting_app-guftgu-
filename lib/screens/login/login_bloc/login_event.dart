import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class SignInWithEmailPasswordRequested extends LoginEvent {
  final String email;
  final String password;

  const SignInWithEmailPasswordRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignInWithGoogleRequested extends LoginEvent {}

class PasswordResetRequested extends LoginEvent {
  final String email;

  const PasswordResetRequested(this.email);

  @override
  List<Object> get props => [email];
}