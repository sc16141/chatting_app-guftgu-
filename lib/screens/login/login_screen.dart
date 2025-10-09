import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prajna_ai/app_routes/app_routes.dart';
import 'package:prajna_ai/welcome/widgets/logo_Prajana.dart';

import 'login_bloc/login_bloc.dart';
import 'login_bloc/login_event.dart';
import 'login_bloc/login_state.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Shows a SnackBar with a message.
  void _showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : Colors.green,
      ),
    );
  }

  /// Shows the dialog for resetting a password.
  void _forgotPassword() {
    final TextEditingController resetEmailController = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Reset Password"),
        content: TextField(
          controller: resetEmailController,
          decoration: const InputDecoration(labelText: "Enter your email"),
          keyboardType: TextInputType.emailAddress,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (resetEmailController.text.isNotEmpty) {
                // Add the PasswordResetRequested event to the BLoC
                context
                    .read<LoginBloc>()
                    .add(PasswordResetRequested(resetEmailController.text.trim()));
                Navigator.of(dialogContext).pop();
              }
            },
            child: const Text("Send"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDEFF4), // Light pink background
      body: BlocConsumer<LoginBloc, LoginState>(
        // The listener handles side-effects that don't need UI rebuilds,
        // like showing snackbars or navigating to another screen.
        listener: (context, state) {
          if (state is LoginError) {
            _showSnackbar(state.error, isError: true);
          }
          if (state is SuccessLogin) {
            _showSnackbar('Login Successful!');
            // TODO: Navigate to your home screen here
            context.go(AppRoutes.home);
          }
          if (state is PasswordResetEmailSent) {
            _showSnackbar('Password reset email has been sent.');
          }
        },
        // The builder rebuilds the UI in response to state changes.
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      // App Logo
                      LogoPrajana(),
                      // SizedBox(height: 20),
                      // CircleAvatar(
                      //   radius: 50,
                      //   backgroundColor: Colors.white,
                      //   child: Text(
                      //     'C',
                      //     style: TextStyle(
                      //       fontSize: 48,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.pink.shade300,
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 30),

                      // Title
                      const Text(
                        'Login to your account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Email Text Field
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                        (value?.isEmpty ?? true) ? 'Please enter an email' : null,
                      ),
                      const SizedBox(height: 16),

                      // Password Text Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) => (value?.isEmpty ?? true)
                            ? 'Please enter a password'
                            : null,
                      ),
                      const SizedBox(height: 10),

                      // Remember Me & Forgot Password Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // You can add "Remember Me" logic here if needed
                          const SizedBox(),
                          TextButton(
                            onPressed: _forgotPassword,
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Sign In Button
                      if (state is LoadingLogin)
                        const Center(child: CircularProgressIndicator())
                      else
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<LoginBloc>().add(
                                SignInWithEmailPasswordRequested(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Sign In', style: TextStyle(fontSize: 18)),
                        ),
                      const SizedBox(height: 30),
                      const Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('or Login with', style: TextStyle(color: Colors.black54)),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Google Login Button
                      if (state is! LoadingLogin)
                        OutlinedButton.icon(
                          icon: Image.asset('assets/images/google.png', height: 24,width:24 ,), // Add google logo to assets
                          onPressed: () {
                            context.read<LoginBloc>().add(SignInWithGoogleRequested());
                          },
                          label: const Text(
                            'Login with Google',
                            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      const SizedBox(height: 40),

                      // Create Account Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?", style: TextStyle(color: Colors.black54)),
                          TextButton(
                            onPressed: () {
                              context.go(AppRoutes.register);
                            },
                            child: const Text(
                              'Create an Account',
                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}