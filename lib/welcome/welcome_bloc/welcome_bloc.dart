import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prajna_ai/welcome/welcome_bloc/welcome_event.dart';
import 'package:prajna_ai/welcome/welcome_bloc/welcome_state.dart';

class WelcomeBloc  extends Bloc<WelcomeEvent, WelcomeState>{
  WelcomeBloc():super(WelcomeInitial()){
    on<LogInButtonPressed>((event, emit){
      emit(WelcomeLogInState());
    });
    on<RegisterBttonPressed>((event ,emit){
      emit(WelcomeRegisterState());
    });
  }
}
