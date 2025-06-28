import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_flutter_app/core/theme/theme_toggle_widget.dart';
import 'package:rive_flutter_app/features/onboarding/presentation/widgets/profile_setup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal : 8.0),
          child: Image.asset(
            'assets/images/logo1.png',
            fit: BoxFit.contain,
          ),
        ),
         actions: [
           Padding(
            padding: EdgeInsets.symmetric(horizontal : 8.0),
            child: ThemeToggleWidget(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal : 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Spacer(),
              // Rive animation will be added here
              const SizedBox(
                height: 370,
                width: 450,
                child: RiveAnimation.asset(
                  'assets/animations/vission1.riv',
                  fit: BoxFit.cover,
                ),
                
              ),
              // const SizedBox(height: 8),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfileSetupScreen(),
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
                  'Get Started',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              
              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }
} 