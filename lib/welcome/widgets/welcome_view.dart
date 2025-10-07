// lib/welcome/view/welcome_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prajna_ai/welcome/welcome_bloc/welcome_event.dart';
import 'package:prajna_ai/welcome/widgets/logo_Prajana.dart';

import '../welcome_bloc/welcome_bloc.dart';
import 'feature_card.dart';
// A custom widget for the info cards

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // The beautiful gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3E2E2), Color(0xFFE6007A), Color(0xFFE1C7A9)],
            stops: [0.0,.5,.7],
            begin: Alignment.center,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                LogoPrajana(),
                // Logo

                // Container(
                //   padding: const EdgeInsets.all(20),
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: Colors.white.withOpacity(0.5),
                //   ),
                //   child: Container(
                //     padding: const EdgeInsets.all(25),
                //     decoration: const BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: Colors.white,
                //     ),
                //     child: const Icon(Icons.ac_unit, color: Color(0xFFE6007A), size: 40), // Placeholder icon
                //   ),
                // ),
                const SizedBox(height: 32),
                // Heading Text
                const Text(
                  'Smart AI Companion for Anytime Assistance',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // Subheading Text
                const Text(
                  'Your smart AI companion, ready to assist with answers, advice, and inspiration, keeping you informed and engaged anytime, anywhere you go.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                // Feature Cards
                const FeatureCard(
                  icon: Icons.question_answer_outlined,
                  title: 'Instant Answers',
                  subtitle: 'Get quick, accurate responses to your questions in real-time.',
                  iconColor: Color(0xFFE6007A),

                ),
                const SizedBox(height: 16),
                const FeatureCard(

                  icon: Icons.sync_alt,
                  title: 'Personalized Advice',
                  subtitle: 'Receive tailored insights and advice based on your preferences and needs.',
                  iconColor: Color(0xFF7000FF),
                ),
                const SizedBox(height: 16),
                const FeatureCard(
                  icon: Icons.bubble_chart_outlined,
                  title: 'Inspiration Anytime',
                  subtitle: 'Find fresh ideas, motivation, and creative solutions whenever you need them.',
                  iconColor: Color(0xFF007AFF),
                ),
                const Spacer(flex: 3),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () {
                          // Add the LoginButtonPressed event to the bloc

                          context.read<WelcomeBloc>().add(LogInButtonPressed());
                        },
                        child: const Text('Login'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE6007A),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () {

                          context.read<WelcomeBloc>().add(RegisterBttonPressed());
                        },
                        child: const Text('Register',style: TextStyle( color:  Colors.white),),
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}