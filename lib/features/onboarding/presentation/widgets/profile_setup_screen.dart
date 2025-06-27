import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive_flutter_app/features/onboarding/presentation/bloc/onboarding_bloc.dart';

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
                    decoration: const InputDecoration(
                      labelText: 'Your Name',
                      border: OutlineInputBorder(),
                      
                    ),
                    onChanged: (value) {
                      context.read<OnboardingBloc>().add(UpdateName(value));
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Your Goal',
                      border: OutlineInputBorder(),
                      hintText: 'e.g., Lose weight, Find love, Learn to code',
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
                        context.read<OnboardingBloc>().add(SubmitProfile());
                      },
                      child: const Text('Complete Setup'),
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