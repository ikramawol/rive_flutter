import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive_flutter_app/core/theme/app_theme.dart';
import 'package:rive_flutter_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:rive_flutter_app/features/onboarding/presentation/bloc/onboarding_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnboardingBloc()),
      ],
      child: MaterialApp(
        title: 'Personalized Journey',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const OnboardingPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
} 