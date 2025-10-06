import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app_routes/app_routes.dart';
import 'auth_firebase/firebase_auth.dart';
import 'auth_firebase/sing_up_bloc.dart';
import 'auth_firebase/sing_up_event.dart';
import 'auth_firebase/sing_up_state.dart';

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

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegisterButtonPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<SignUpBloc>().add(
        SignUpButtonPressed(
          email: _emailController.text,
          password: _passwordController.text,
          fullName: _nameController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.replaceFirst('Exception: ', '')),
            ),
          );
        }
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration Successful!')),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
                  ),
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.all(Radius.circular(12)),
                  // ),
                  labelText: 'Full Name',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,

                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
                  ),
                  labelText: 'Email',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your email' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _passwordController,

                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) => value!.length < 6
                    ? 'Password must be at least 6 characters'
                    : null,
              ),
              const SizedBox(height: 20),
              BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  return state is SignUpLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _onRegisterButtonPressed,
                          child: const Text('Register'),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
