import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive_flutter_app/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:rive_flutter_app/features/onboarding/presentation/widgets/welcome_screen.dart';
import 'package:rive_flutter_app/features/onboarding/presentation/widgets/profile_setup_screen.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingSuccess) {
          // Navigate to home page
          return const Scaffold(
            body: Center(
              child: Text('Welcome to your personalized journey!'),
            ),
          );
        }

        return PageView(
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            WelcomeScreen(),
            ProfileSetupScreen(),
          ],
        );
      },
    );
  }
} 