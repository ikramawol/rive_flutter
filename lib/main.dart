import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive_flutter_app/core/theme/app_theme.dart';
import 'package:rive_flutter_app/core/theme/theme_bloc.dart';
import 'package:rive_flutter_app/features/onboarding/presentation/widgets/splash_screen.dart';
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
        BlocProvider(create: (context) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final isDarkMode = themeState is ThemeInitial ? themeState.isDarkMode : false;
          
          print('=== MAIN APP DEBUG ===');
          print('Theme state: ${themeState.runtimeType}');
          print('Is dark mode: $isDarkMode');
          print('Theme mode: ${isDarkMode ? 'dark' : 'light'}');
          print('=== END MAIN APP DEBUG ===');
          
          return MaterialApp(
            title: 'Personalized Journey',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
} 