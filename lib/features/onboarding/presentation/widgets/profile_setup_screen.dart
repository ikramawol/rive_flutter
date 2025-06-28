import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive_flutter_app/core/theme/theme_toggle_widget.dart';
import 'package:rive_flutter_app/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:rive_flutter_app/features/onboarding/presentation/widgets/personalized_welcome_screen.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is! OnboardingInProgress) {
          return const SizedBox.shrink();
        }

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/logo1.png',
                fit: BoxFit.contain,
                height: 50,
              ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ThemeToggleWidget(),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tell us about yourself',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 68, 161, 255),
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    onChanged: (value) {
                      context.read<OnboardingBloc>().add(UpdateName(value));
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Your Goal',
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        fontSize: 16,
                      ),
                      hintText: 'e.g., Lose weight, Find love, Learn to code',
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 68, 161, 255),
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    onChanged: (value) {
                      context.read<OnboardingBloc>().add(UpdateGoal(value));
                    },
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Select your interests',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      'Fitness',
                      'Technology',
                      'Art',
                      'Music',
                      'Travel',
                      'Food',
                      'Reading',
                      'Gaming',
                    ].map((interest) {
                      final isSelected = state.interests.contains(interest);
                      return FilterChip(
                        label: Text(interest),
                        selected: isSelected,
                        selectedColor: Color.fromARGB(255, 68, 161, 255).withOpacity(0.4),
                        checkmarkColor: Color.fromARGB(255, 68, 161, 255),
                        onSelected: (selected) {
                          final newInterests = List<String>.from(state.interests);
                          if (selected) {
                            if (newInterests.length < 3) {
                              newInterests.add(interest);
                            }
                          } else {
                            newInterests.remove(interest);
                          }
                          context.read<OnboardingBloc>().add(
                            UpdateInterests(newInterests),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PersonalizedWelcomeScreen(),
                          ),
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
                        'Complete Setup',
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
} 