import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prajna_ai/screens/register/auth_firebase/sing_up_event.dart';
import 'package:prajna_ai/screens/register/auth_firebase/sing_up_state.dart';

import 'firebase_auth.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository _authRepository;

  SignUpBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignUpInitial()) {
    on<SignUpButtonPressed>(_onSignUpButtonPressed);
  }

  Future<void> _onSignUpButtonPressed(
      SignUpButtonPressed event,
      Emitter<SignUpState> emit,
      ) async {
    emit(SignUpLoading()); // Inform the UI that registration is in progress
    try {
      await _authRepository.signUp(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
      );
      emit(SignUpSuccess()); // Inform the UI that registration was successful
    } catch (e) {
      emit(SignUpFailure(error: e.toString())); // Inform the UI of an error
    }
  }
}