import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:rive_flutter_app/core/theme/theme_bloc.dart';

class ThemeToggleWidget extends StatefulWidget {
  const ThemeToggleWidget({super.key});

  @override
  State<ThemeToggleWidget> createState() => _ThemeToggleWidgetState();
}

class _ThemeToggleWidgetState extends State<ThemeToggleWidget> {
  StateMachineController? _controller;
  SMITrigger? _toggleTrigger;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    // Listen to theme changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final themeState = context.read<ThemeBloc>().state as ThemeInitial;
      setState(() {
        _isDarkMode = themeState.isDarkMode;
      });
    });
  }

  void _onRiveInit(Artboard artboard) {
    try {
      // Try to find any state machine
      if (artboard.stateMachines.isNotEmpty) {
        final stateMachine = artboard.stateMachines.first;
        final controller = StateMachineController.fromArtboard(artboard, stateMachine.name);
        
        if (controller != null) {
          artboard.addController(controller);
          _controller = controller;
          
          // Print all available inputs for debugging
          print('=== RIVE DEBUG INFO ===');
          print('State machine: ${stateMachine.name}');
          print('Available inputs:');
          for (final input in controller.inputs) {
            print('  - ${input.name} (${input.runtimeType})');
          }
          
          // Try to find any trigger input
          for (final input in controller.inputs) {
            if (input is SMITrigger) {
              _toggleTrigger = input;
              print('Found trigger: ${input.name}');
              break;
            }
          }
          
          // If no trigger found, try to find any boolean input
          if (_toggleTrigger == null) {
            for (final input in controller.inputs) {
              if (input is SMIBool) {
                print('Found boolean: ${input.name}');
                break;
              }
            }
          }
        }
      } else {
        print('No state machines found in Rive file');
      }
    } catch (e) {
      print('Error initializing Rive: $e');
    }
  }

  void _toggleTheme() {
    print('Theme toggle pressed!');
    
    // Trigger the Rive animation if available
    if (_toggleTrigger != null) {
      _toggleTrigger!.fire();
      print('Rive animation triggered');
    } else {
      print('No Rive trigger found, but theme will still toggle');
    }
    
    // Toggle the theme
    final themeBloc = context.read<ThemeBloc>();
    themeBloc.add(ToggleTheme());
    
    // Update local state
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    
    print('Theme toggled to: ${_isDarkMode ? 'Dark' : 'Light'}');
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        // Update local state when theme changes
        if (state is ThemeInitial) {
          _isDarkMode = state.isDarkMode;
        }
        
        return GestureDetector(
          onTap: _toggleTheme,
          child: Container(
            width: 48,
            height: 48,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  // Rive animation as background
                  RiveAnimation.asset(
                    'assets/animations/theme_toggle.riv',
                    onInit: _onRiveInit,
                    fit: BoxFit.cover,
                  ),
                  // Fallback icon if Rive fails
                  if (_toggleTrigger == null)
                    Center(
                      child: Icon(
                        _isDarkMode ? Icons.light_mode : Icons.dark_mode,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 24,
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