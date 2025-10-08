import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState extends Equatable{
  const LoginState();
  @override
  List<Object> get props => [];

}
class InitialLogin extends LoginState{}
class LoadingLogin extends LoginState{}
class  SuccessLogin extends LoginState{
  final User user;
  const SuccessLogin({required this.user});
  @override
  List<Object> get props =>[user];
}
class LoginError extends LoginState{
  final String error;
  const LoginError({required this.error});
  @override
  List<Object> get props =>[error];
}
class PasswordResetEmailSent extends LoginState{}