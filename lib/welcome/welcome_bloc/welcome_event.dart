 import 'package:equatable/equatable.dart';

abstract class WelcomeEvent extends Equatable{
  const WelcomeEvent();
  @override
   List<Object> get props =>[];

}
class LogInButtonPressed  extends WelcomeEvent{}
 class RegisterBttonPressed extends WelcomeEvent{}

