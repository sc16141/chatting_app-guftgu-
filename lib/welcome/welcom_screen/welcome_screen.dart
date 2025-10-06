// lib/welcome/view/welcome_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prajna_ai/app_routes/app_routes.dart';
import 'package:prajna_ai/welcome/welcome_bloc/welcome_state.dart';
import '../welcome_bloc/welcome_bloc.dart';
import '../widgets/welcome_view.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WelcomeBloc(),
      child: BlocListener<WelcomeBloc, WelcomeState>(
        listener: (context, state) {
          if (state is WelcomeLogInState) {
            context.go(AppRoutes.login);
            print('Navigating to Login Screen...');
          } else if (state is WelcomeRegisterState) {
            context.go(AppRoutes.register);
            print('Navigating to Register Screen...');
          }
        },
        child: const WelcomeView(),
      ),
    );
  }
}