import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive_flutter_app/core/theme/theme_toggle_widget.dart';
import 'package:rive_flutter_app/core/widgets/typewriter_text.dart';
import 'package:rive_flutter_app/features/onboarding/presentation/bloc/onboarding_bloc.dart';

class PersonalizedWelcomeScreen extends StatelessWidget {
  const PersonalizedWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is! OnboardingInProgress) {
          return const Scaffold(
            body: Center(child: Text('Welcome!')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Image.asset('assets/images/logo1.png', height: 50),
            // centerTitle: true,
            actions: [const ThemeToggleWidget()],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  
                  // Avatar
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 68, 161, 255),
                    ),
                    child: Center(
                      child: Text(
                        state.name.isNotEmpty ? state.name[0].toUpperCase() : 'U',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Welcome Message
                  TypewriterText(
                    text: 'Welcome, ${state.name.isNotEmpty ? state.name : 'there'}!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 68, 161, 255),
                    ),
                    textAlign: TextAlign.center,
                    duration: const Duration(milliseconds: 100),
                    delay: const Duration(milliseconds: 300),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Personalized Message
                  TypewriterText(
                    text: _getPersonalizedMessage(state.name, state.goal, state.interests),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                    duration: const Duration(milliseconds: 30),
                    delay: const Duration(milliseconds: 1500),
                  ),
                  
                  const Spacer(),
                  
                  // Start Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Welcome to your journey!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(334, 52),
                        backgroundColor: Color.fromARGB(255, 68, 161, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Start My Journey',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _getPersonalizedMessage(String name, String goal, List<String> interests) {
    if (name.isEmpty) return "Welcome to your personalized journey!";
    
    String message = "Welcome, $name! ";
    
    if (goal.isNotEmpty) {
      if (goal.toLowerCase().contains('weight')) {
        message += "Your fitness journey starts now. ";
      } else if (goal.toLowerCase().contains('love')) {
        message += "Your path to meaningful connections begins. ";
      } else if (goal.toLowerCase().contains('code')) {
        message += "Your coding adventure awaits. ";
      } else {
        message += "Your goal of '$goal' is within reach. ";
      }
    }
    
    if (interests.isNotEmpty) {
      message += "Based on your interests in ${interests.join(', ')}, we've curated a perfect experience just for you.";
    } else {
      message += "We're excited to help you achieve your goals!";
    }
    
    return message;
  }
} 