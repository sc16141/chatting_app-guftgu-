import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prajna_ai/screens/register/widgets/register_form.dart';
import 'package:prajna_ai/welcome/widgets/logo_Prajana.dart';

import '../../app_routes/app_routes.dart';
import 'auth_firebase/firebase_auth.dart';
import 'auth_firebase/sing_up_bloc.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3E2E2), Color(0xFFE6007A), Color(0xFFE1C7A9)],
            stops: [0.0, .5, .7],
            begin: Alignment.center,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: IconButton(
                  onPressed: () {
                    context.go(
                      AppRoutes.welcome,
                    ); // navigate back using GoRouter
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                ),
              ),
                 Center(child: LogoPrajana()),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: RepositoryProvider(
                  create: (context) => AuthRepository(),
                  child: BlocProvider(
                    create: (context) => SignUpBloc(
                      authRepository: RepositoryProvider.of<AuthRepository>(
                        context,
                      ),
                    ),
                    child: const RegisterForm(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
