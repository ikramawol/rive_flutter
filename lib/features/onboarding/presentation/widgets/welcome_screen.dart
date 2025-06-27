import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_flutter_app/features/onboarding/presentation/widgets/profile_setup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Rive animation will be added here
              const SizedBox(
                height: 150,
                width: 150,
                child: RiveAnimation.network(
                  'https://cdn.rive.app/animations/vehicles.riv',
                  fit: BoxFit.cover,
                ),
                // child: RiveAnimation.asset(
                //   'assets/animations/black_cat.riv',
                //   fit: BoxFit.contain,
                // ),
              ),
              const SizedBox(height: 48),
              Text(
                'Ready to begin your journey?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Let\'s create your personalized experience',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Navigate to next screen
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfileSetupScreen(),
                    ),
                  );
                  final pageController = PageController();
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text('Get Started'),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
} 